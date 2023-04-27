import 'package:fetch/src/fetch_globals.dart';
import 'package:fetch/src/fetch_options.dart';
import 'package:fetch/src/fetch_request.dart';
import 'package:fetch/src/fetch_request_impl.dart';
import 'package:fetch/src/fetch_response.dart';

Future<FetchRequest> fetch(
  FetchOptions options, {
  bool close = false,
}) async {
  final clientRequest = FetchGlobals().httpxClient.createRequest(
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

Future<FetchResponse> fetchWithStructuredData(
  FetchOptions options,
  dynamic structuredData,
) async {
  final fetchRequest = await fetch(options);

  return fetchRequest.writeStructuredData(structuredData);
}

Future<FetchResponse> fetchWithNoData(FetchOptions options) async {
  final fetchRequest = await fetch(options);

  return fetchRequest.close();
}
