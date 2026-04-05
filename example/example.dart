// SPDX-FileCopyrightText: © 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore_for_file: avoid_print

import 'package:ac_fetch/ac_fetch.dart';

Future<void> main() async {
  await _getExample();
  await _postJsonExample();
}

Future<void> _getExample() async {
  print('--- GET request ---');

  final response = await fetchWithNoData(
    FetchOptions(method: 'GET', url: Uri.parse('https://httpbin.org/get')),
  );

  print('ok:     ${response.ok}');
  print('status: ${response.status} ${response.statusText}');

  final body = await response.waitString();
  print('Body (truncated): ${body.substring(0, body.length.clamp(0, 200))}');
}

Future<void> _postJsonExample() async {
  print('\n--- POST with JSON body ---');

  final response = await fetchWithStructuredData(
    FetchOptions(
      method: 'POST',
      url: Uri.parse('https://httpbin.org/post'),
      headers: HttpxHeaders.fromMap({'content-type': 'application/json'}),
    ),
    {'message': 'hello', 'count': 42},
  );

  print('ok:     ${response.ok}');
  print('status: ${response.status} ${response.statusText}');

  final json = await response.waitStructuredData() as Map<String, dynamic>;
  print('Echoed JSON: ${json['json']}');
}
