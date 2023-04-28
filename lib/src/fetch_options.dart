// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:ac_httpx_client/ac_httpx_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_options.freezed.dart';

/// Takes a typed-data and return a structured-data usable by the appropriate structured-data encoder (based on mime-type).
/// Depending on the mime-type, the return type must be String, List<int>, Map<String, String | List<String>>, etc.
typedef TypedDataEncoder = FutureOr<dynamic> Function(
  dynamic typedData,
  Type typedDataType,
);

/// Takes a structured-data from a structured-data decoder and return a typed-data (return type must follow typedDataType arg).
/// Depending on the mime-type, the structured data type will be a String, List<int>, Map<String, String | List<String>>, etc.
typedef TypedDataDecoder = FutureOr<dynamic> Function(
  dynamic structuredData,
  Type typedDataType,
);

typedef StructuredDataEncoder = List<int> Function(
  dynamic structuredData,
  Encoding charsetEncoding,
);

typedef StructuredDataDecoder = Future<dynamic> Function(
  Stream<List<int>> bodyStream,
  Encoding charsetEncoding,
);

@freezed
class FetchOptions with _$FetchOptions {
  const factory FetchOptions({
    required String method,
    required Uri url,
    HttpxHeaders? headers,
    Iterable<HttpxCredentials>? realmsCredentials,
    Map<String, StructuredDataEncoder>? structuredDataEncoders,
    Map<String, StructuredDataDecoder>? structuredDataDecoders,
    TypedDataEncoder? defaultTypedDataEncoder,
    TypedDataDecoder? defaultTypedDataDecoder,
    int? maxRedirects,
    HttpxCachePolicy? cachePolicy,
    dynamic metadata,
    Duration? connectionTimeout,
  }) = _FetchOptions;
}
