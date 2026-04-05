// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:ac_httpx_client/ac_httpx_client.dart';

import 'fetch_options.dart';
import 'fetch_response.dart';

/// A pending HTTP request produced by [fetch].
///
/// Write the request body with [writeData], [writeString], [writeStructuredData],
/// or [writeTypedData], then call [close] to send it and obtain a [FetchResponse].
/// Calling any `write*` method or [close] more than once throws a [StateError].
abstract class FetchRequest {
  /// The options that were used to create this request.
  FetchOptions get options;

  /// The HTTP method (e.g. `GET`, `POST`).
  String get method;

  /// The URL this request targets.
  Uri get url;

  /// Whether the request body has already been written.
  bool get bodyUsed;

  /// Whether the request has been closed (sent).
  bool get closed;

  /// The request headers.
  HttpxHeaders get headers;

  /// Writes raw bytes to the request body.
  Future<void> writeData(List<int> data, {bool ignoreContentEncoding = true});

  /// Encodes [string] with the request charset and writes it to the body.
  Future<void> writeString(String string);

  /// structuredData will be transformed by either the structuredDataEncoder
  /// in parameter, or, if it is not provided and based on request's
  /// content-type, it will pass the result to the matching
  /// options.structuredDataEncoders (or the builtins ones). If none match,
  /// it will fail with an exception.
  /// Calling this method will automatically close the request.
  Future<FetchResponse> writeStructuredData(
    dynamic structuredData, {
    StructuredDataEncoder? encoder,
  });

  /// typedData will be transformed to structuredData by either the
  /// typedDataEncoder in argument or, if none is provided, the
  /// options.typedDataEncoder, or, if none is defined, a pass-through.
  /// Then, it will pass the result to the structuredDataEncoder in parameter,
  /// or, if it is not provided and based on request's content-type, it will
  /// pass the result to the matching options.structuredDataEncoders (or the
  /// builtins ones). If none match, it will fail with an exception.
  /// Calling this method will automatically close the request.
  Future<FetchResponse> writeTypedData<T extends Object?>(
    T typedData, {
    TypedDataEncoder? encoder,
    StructuredDataEncoder? structuredDataEncoder,
  });

  Future<FetchResponse> close();
}
