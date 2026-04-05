// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:ac_httpx_client/ac_httpx_client.dart';

import 'fetch_globals.dart';
import 'fetch_options.dart';
import 'fetch_request.dart';
import 'fetch_request_impl.dart';
import 'fetch_response.dart';

/// Creates a [FetchRequest] from [options] using the provided [httpxClient]
/// (or [FetchGlobals.defaultHttpxClient] when omitted).
///
/// Call [FetchRequest.close] to send the request and obtain a [FetchResponse].
/// Pass `close: true` to send immediately with no body.
Future<FetchRequest> fetch(
  FetchOptions options, {
  HttpxClient? httpxClient,
  bool close = false,
}) async {
  final client = httpxClient ?? FetchGlobals().defaultHttpxClient;

  final clientRequest = client.createRequest(
    uri: options.url,
    method: options.method,
    headers: options.headers,
    realmsCredentials: options.realmsCredentials,
    maxRedirects: options.maxRedirects,
    connectionTimeout: options.connectionTimeout,
    cachePolicy: options.cachePolicy,
  );

  final request = FetchRequestImpl(clientRequest, options: options);

  if (close) {
    await request.close();
  }

  return request;
}

/// Sends a request built from [options] with no body and returns the response.
Future<FetchResponse> fetchWithNoData(
  FetchOptions options, {
  HttpxClient? httpxClient,
}) async {
  final fetchRequest = await fetch(options, httpxClient: httpxClient);

  return fetchRequest.close();
}

/// Sends a request built from [options] with [structuredData] as the body.
///
/// The data is encoded using the matching encoder from
/// [FetchOptions.structuredDataEncoders] (or the built-in encoders) based on
/// the request's `Content-Type` header.
Future<FetchResponse> fetchWithStructuredData(
  FetchOptions options,
  dynamic structuredData, {
  HttpxClient? httpxClient,
}) async {
  final fetchRequest = await fetch(options, httpxClient: httpxClient);

  return fetchRequest.writeStructuredData(structuredData);
}

/// Sends a request built from [options] with [typedData] converted to
/// structured data and then serialised as the body.
///
/// If [encoder] is not provided, [FetchOptions.typedDataEncoder] is used as
/// the typed-to-structured conversion step; if that is also absent, the data
/// is passed through unchanged.
Future<FetchResponse> fetchWithTypedData<T>(
  FetchOptions options,
  T typedData, {
  HttpxClient? httpxClient,
  TypedDataEncoder? encoder,
}) async {
  final fetchRequest = await fetch(options, httpxClient: httpxClient);

  return fetchRequest.writeTypedData(typedData, encoder: encoder);
}
