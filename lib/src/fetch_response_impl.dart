import 'dart:async';
import 'dart:convert';

import 'package:anthochamp_dart_essentials/dart_essentials.dart';
import 'package:async/async.dart';
import 'package:httpx_client/httpx_client.dart';

import 'package:fetch/src/builtins/fetch_builtins.dart';
import 'package:fetch/src/fetch_options.dart';
import 'package:fetch/src/fetch_response.dart';
import 'package:fetch/src/fetch_utilities.dart';

class FetchResponseImpl implements FetchResponse {
  static const defaultContentCharsetName = 'iso-8859-1';

  @override
  final FetchOptions options;

  FetchResponseImpl(
    this._clientResponse, {
    required this.options,
  }) {
    _clientResponse.pipe(_streamController);
  }

  final HttpxResponse _clientResponse;
  // closed by pipe()
  // ignore: close_sinks
  final _streamController = StreamController<List<int>>();
  final _waitDataMemoizer = AsyncMemoizer<List<int>>();
  final _waitStringMemoizer = AsyncMemoizer<String>();
  final _waitStructuredDataMemoizer = AsyncMemoizer<dynamic>();
  bool? _waitDataMemoizerIgnoreContentEncodingArg;
  StructuredDataDecoder? _waitStructuredDataMemoizerDecoderArg;

  @override
  bool get bodyUsed => _streamController.hasListener;

  @override
  HttpxHeaders get headers => _clientResponse.headers;

  @override
  // ignore: no-magic-number, prefer-correct-identifier-length
  bool get ok => status >= 200 && status < 300;

  @override
  bool get redirected => _clientResponse.redirects.isNotEmpty;

  @override
  int get status => _clientResponse.status;

  @override
  String get statusText => _clientResponse.statusText ?? '';

  @override
  Uri get url => _clientResponse.redirects.isEmpty
      ? options.url
      : _clientResponse.redirects.last.location;

  @override
  Stream<List<int>> getDataStream({
    bool ignoreContentEncoding = true,
  }) {
    Stream<List<int>> transformedStream;
    if (ignoreContentEncoding) {
      transformedStream = _streamController.stream;
    } else {
      final charsetEncoding = _getCharsetEncoding();

      transformedStream = _streamController.stream
          .transform(charsetEncoding.decoder)
          .map((event) => event.codeUnits);
    }

    return transformedStream;
  }

  @override
  Future<List<int>> waitData({
    bool ignoreContentEncoding = true,
    Duration? timeout,
  }) {
    if (_waitDataMemoizer.hasRun &&
        _waitDataMemoizerIgnoreContentEncodingArg != ignoreContentEncoding) {
      throw Exception(
        'waitData has already been executed with a different ignoreContentEncoding value',
      );
    }

    return _waitDataMemoizer.runOnce(() {
      _waitDataMemoizerIgnoreContentEncodingArg = ignoreContentEncoding;

      final future = getDataStream(
        ignoreContentEncoding: ignoreContentEncoding,
      ).fold(<int>[], (previous, element) => previous..addAll(element));

      return timeout == null ? future : future.timeout(timeout);
    });
  }

  @override
  Future<String> waitString({
    Duration? timeout,
  }) =>
      _waitStringMemoizer.runOnce(() {
        final future =
            _getCharsetEncoding().decodeStream(_streamController.stream);

        return timeout == null ? future : future.timeout(timeout);
      });

  @override
  Future<dynamic> waitStructuredData({
    StructuredDataDecoder? decoder,
    Duration? timeout,
  }) {
    if (_waitStructuredDataMemoizer.hasRun &&
        _waitStructuredDataMemoizerDecoderArg != decoder) {
      throw Exception(
        'waitStructuredData has already been executed with a different decoder value',
      );
    }

    return _waitStructuredDataMemoizer.runOnce(() {
      StructuredDataDecoder? structuredDataDecoder;
      if (decoder == null) {
        final contentMimeType = headers.getContentType()?.mimeType;
        if (contentMimeType == null) {
          throw UnsupportedError(
            'Unable to wait structured data: response has no content type',
          );
        }

        structuredDataDecoder =
            FetchUtilities.findBestDataCoder<StructuredDataDecoder>(
          mimeType: contentMimeType,
          dataCoders: options.structuredDataDecoders,
          builtinsDataCoders: FetchBuiltins.structuredDataDecodersPerMimeType,
        );
        if (structuredDataDecoder == null) {
          throw UnsupportedError(
            'Content type "$contentMimeType" has no known structured-data decoder',
          );
        }
      } else {
        structuredDataDecoder = decoder;
      }

      final future = structuredDataDecoder(
        _streamController.stream,
        _getCharsetEncoding(),
      );

      return timeout == null ? future : future.timeout(timeout);
    });
  }

  @override
  Future<T> waitTypedData<T extends Object?>({
    TypedDataDecoder? decoder,
    StructuredDataDecoder? structuredDataDecoder,
    Duration? timeout,
  }) async {
    final stopwatch = Stopwatch();

    final structuredData = await waitStructuredData(
      decoder: structuredDataDecoder,
      timeout: timeout,
    );

    TypedDataDecoder? typedDataDecoder;
    if (decoder == null) {
      typedDataDecoder = options.defaultTypedDataDecoder;
    } else {
      typedDataDecoder = decoder;
    }

    if (typedDataDecoder == null) {
      return structuredData as T;
    }

    final future = Future.value(typedDataDecoder(structuredData, T) as T);

    return timeout == null
        ? future
        : future.timeout(stopwatch.timeLeft(timeout)!);
  }

  Encoding _getCharsetEncoding() {
    Encoding? charsetEncoding = headers.getCharsetEncoding();

    if (charsetEncoding == null) {
      charsetEncoding = Encoding.getByName(defaultContentCharsetName);
      if (charsetEncoding == null) {
        throw UnsupportedError(
          'Charset "$defaultContentCharsetName" is not supported',
        );
      }
    }

    return charsetEncoding;
  }
}
