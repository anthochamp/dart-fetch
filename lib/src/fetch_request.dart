// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ac_httpx_client/ac_httpx_client.dart';

import 'fetch_options.dart';
import 'fetch_response.dart';

abstract class FetchRequest {
  FetchOptions get options;

  String get method;

  Uri get url;

  bool get bodyUsed;

  bool get closed;

  HttpxHeaders get headers;

  Future<void> writeData(
    List<int> data, {
    bool ignoreContentEncoding = true,
  });

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
