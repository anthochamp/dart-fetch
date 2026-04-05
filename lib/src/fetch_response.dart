// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:ac_httpx_client/ac_httpx_client.dart';

import 'fetch_options.dart';

/// An HTTP response returned by [fetchWithNoData], [fetchWithStructuredData],
/// or [fetchWithTypedData].
///
/// Consume the response body exactly once with one of the `wait*` or
/// `getDataStream` methods. All `wait*` methods are memoised on their first
/// call; subsequent calls with the same arguments return the cached result.
/// Calling a `wait*` method a second time with different arguments throws a
/// [StateError].
abstract class FetchResponse {
  /// The options that were used to create the originating request.
  FetchOptions get options;

  /// Whether the request was redirected at least once.
  bool get redirected;

  /// The final URL after all redirects.
  Uri get url;

  /// `true` when [status] is in the 200–299 range.
  ///
  /// Named `ok` to match the
  /// [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Response/ok)
  /// canonical property name.
  bool get ok;

  /// The HTTP status code of the response.
  int get status;

  /// The HTTP status text (e.g. `"OK"`, `"Not Found"`).
  String get statusText;

  /// The response headers.
  HttpxHeaders get headers;

  /// Whether the response body has already been consumed.
  bool get bodyUsed;

  /// Returns the raw response body as a byte stream.
  ///
  /// When [ignoreContentEncoding] is `true` (default), transfer-encoding such
  /// as gzip is decoded transparently before the bytes are emitted.
  Stream<List<int>> getDataStream({bool ignoreContentEncoding = true});

  /// Buffers and returns the full raw response body as a byte list.
  ///
  /// Memoised: subsequent calls with the same [ignoreContentEncoding] value
  /// return the cached result. Calling with a different value after the first
  /// call throws a [StateError].
  /// Throws a [TimeoutException] when [timeout] elapses before the body is
  /// fully received.
  Future<List<int>> waitData({
    bool ignoreContentEncoding = true,
    Duration? timeout,
  });

  /// Buffers and decodes the full response body as a UTF-8 string.
  ///
  /// Memoised: subsequent calls return the cached result.
  /// Throws a [TimeoutException] when [timeout] elapses.
  Future<String> waitString({Duration? timeout});

  /// Parses and returns the response body as structured (dynamic) data.
  ///
  /// Uses [decoder] when supplied, otherwise falls back to the decoder
  /// registered for the response `Content-Type` in the global options.
  /// Memoised: subsequent calls with the same [decoder] return the cached
  /// result. Calling with a different decoder after the first call throws a
  /// [StateError].
  /// Throws a [TimeoutException] when [timeout] elapses.
  Future<dynamic> waitStructuredData({
    StructuredDataDecoder? decoder,
    Duration? timeout,
  });

  /// Parses and returns the response body as a typed object [T].
  ///
  /// Uses [decoder] when supplied, otherwise falls back to the typed-data
  /// decoder registered for [T] in the global options. Structured data is
  /// decoded with [structuredDataDecoder] (or the global fallback) before
  /// being passed to the typed decoder.
  /// Throws a [TimeoutException] when [timeout] elapses.
  Future<T> waitTypedData<T extends Object?>({
    TypedDataDecoder? decoder,
    StructuredDataDecoder? structuredDataDecoder,
    Duration? timeout,
  });
}
