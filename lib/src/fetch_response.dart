// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:ac_httpx_client/ac_httpx_client.dart';

import 'fetch_options.dart';

abstract class FetchResponse {
  FetchOptions get options;

  bool get redirected;

  Uri get url;

  // ignore: prefer-correct-identifier-length
  bool get ok;

  int get status;

  String get statusText;

  HttpxHeaders get headers;

  bool get bodyUsed;

  Stream<List<int>> getDataStream({
    bool ignoreContentEncoding = true,
  });

  Future<List<int>> waitData({
    bool ignoreContentEncoding = true,
    Duration? timeout,
  });

  Future<String> waitString({
    Duration? timeout,
  });

  Future<dynamic> waitStructuredData({
    StructuredDataDecoder? decoder,
    Duration? timeout,
  });

  Future<T> waitTypedData<T extends Object?>({
    TypedDataDecoder? decoder,
    StructuredDataDecoder? structuredDataDecoder,
    Duration? timeout,
  });
}
