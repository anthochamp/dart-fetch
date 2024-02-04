// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:ac_httpx_client/ac_httpx_client.dart';

import 'fetch_globals.dart';
import 'fetch_options.dart';
import 'fetch_request.dart';
import 'fetch_request_impl.dart';
import 'fetch_response.dart';

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

Future<FetchResponse> fetchWithNoData(
  FetchOptions options, {
  HttpxClient? httpxClient,
}) async {
  final fetchRequest = await fetch(options, httpxClient: httpxClient);

  return fetchRequest.close();
}

Future<FetchResponse> fetchWithStructuredData(
  FetchOptions options,
  dynamic structuredData, {
  HttpxClient? httpxClient,
}) async {
  final fetchRequest = await fetch(options, httpxClient: httpxClient);

  return fetchRequest.writeStructuredData(structuredData);
}

Future<FetchResponse> fetchWithTypedData<T>(
  FetchOptions options,
  T typedData, {
  HttpxClient? httpxClient,
  TypedDataEncoder? encoder,
}) async {
  final fetchRequest = await fetch(options, httpxClient: httpxClient);

  return fetchRequest.writeTypedData(typedData, encoder: encoder);
}
