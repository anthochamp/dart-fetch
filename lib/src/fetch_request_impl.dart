import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';

import 'package:fetch/src/builtins/fetch_builtins.dart';
import 'package:fetch/src/fetch_options.dart';
import 'package:fetch/src/fetch_request.dart';
import 'package:fetch/src/fetch_response.dart';
import 'package:fetch/src/fetch_response_impl.dart';
import 'package:fetch/src/fetch_utilities.dart';
import 'package:httpx_client/httpx_client.dart';

class FetchRequestImpl implements FetchRequest {
  @override
  final FetchOptions options;

  FetchRequestImpl(
    this._clientRequest, {
    required this.options,
  });

  final HttpxRequest _clientRequest;
  final _closeMemoizer = AsyncMemoizer<FetchResponse>();

  @override
  String get method => _clientRequest.method;

  @override
  Uri get url => _clientRequest.uri;

  @override
  bool get bodyUsed => _clientRequest.dataSent > 0;

  @override
  bool get closed => _clientRequest.closed;

  @override
  HttpxHeaders get headers => _clientRequest.headers;

  @override
  Future<void> writeData(
    List<int> data, {
    bool ignoreContentEncoding = true,
  }) async {
    if (closed) {
      throw Exception('Request is closed');
    }

    if (data.isEmpty) {
      return;
    }

    final charsetEncoding = headers.getCharsetEncoding();

    List<int> encodedData;
    if (ignoreContentEncoding || charsetEncoding == null) {
      encodedData = data;
    } else {
      encodedData = charsetEncoding.encode(String.fromCharCodes(data));
    }

    // unless caller has set content-length himself, let remove the header.
    if (_clientRequest.headers.getContentLength() == 0) {
      _clientRequest.headers.setContentLength(null);
    }

    await _clientRequest.write(encodedData);
  }

  @override
  Future<void> writeString(String string) =>
      writeData(string.codeUnits, ignoreContentEncoding: false);

  @override
  Future<FetchResponse> writeStructuredData(
    dynamic structuredData, {
    StructuredDataEncoder? encoder,
  }) async {
    if (closed) {
      throw Exception('Request is closed');
    }

    if (bodyUsed) {
      throw Exception('Unable to write structured data: body has been used');
    }

    StructuredDataEncoder? structuredDataEncoder;

    if (encoder == null) {
      final contentMimeType = headers.getContentType()?.mimeType;
      if (contentMimeType == null) {
        throw UnsupportedError(
          'Unable to write structured data: content mime type is undefined',
        );
      }

      structuredDataEncoder =
          FetchUtilities.findBestDataCoder<StructuredDataEncoder>(
        mimeType: contentMimeType,
        dataCoders: options.structuredDataEncoders,
        builtinsDataCoders: FetchBuiltins.structuredDataEncodersPerMimeType,
      );
      if (structuredDataEncoder == null) {
        throw UnsupportedError(
          'No known structured-data encoder for content type "$contentMimeType"',
        );
      }
    } else {
      structuredDataEncoder = encoder;
    }

    final encodedData = structuredDataEncoder(
      structuredData,
      headers.getCharsetEncoding() ?? const AsciiCodec(allowInvalid: true),
    );

    _clientRequest.headers.setContentLength(encodedData.length);

    await _clientRequest.write(encodedData);

    return close();
  }

  @override
  Future<FetchResponse> writeTypedData<T extends Object?>(
    T typedData, {
    TypedDataEncoder? encoder,
    StructuredDataEncoder? structuredDataEncoder,
  }) async {
    if (closed) {
      throw Exception('Unable to write typed data: request is closed');
    }

    if (bodyUsed) {
      throw Exception('Unable to write typed data: body has been used');
    }

    TypedDataEncoder? typedDataEncoder;

    if (encoder == null) {
      typedDataEncoder = options.defaultTypedDataEncoder;
    } else {
      typedDataEncoder = encoder;
    }

    dynamic structuredData;
    if (typedDataEncoder == null) {
      structuredData = typedData;
    } else {
      structuredData = await typedDataEncoder(typedData, T);
    }

    return writeStructuredData(
      structuredData,
      encoder: structuredDataEncoder,
    );
  }

  @override
  Future<FetchResponse> close() => _closeMemoizer.runOnce(
        () async {
          return FetchResponseImpl(
            await _clientRequest.close(),
            options: options,
          );
        },
      );
}
