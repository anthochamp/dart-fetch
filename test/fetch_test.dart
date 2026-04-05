// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:convert';

import 'package:test/test.dart';

import 'package:ac_fetch/src/builtins/application_json_coders.dart';
import 'package:ac_fetch/src/builtins/application_octet_coders.dart';
import 'package:ac_fetch/src/builtins/application_www_form_url_encoded_coders.dart';
import 'package:ac_fetch/src/builtins/text_plain_coders.dart';
import 'package:ac_fetch/src/fetch_utilities.dart';

void main() {
  // ---------------------------------------------------------------------------
  // fetchFindBestDataCoder
  // ---------------------------------------------------------------------------
  group('fetchFindBestDataCoder', () {
    test('returns null when no coders map has a match', () {
      final result = fetchFindBestDataCoder<int>(
        mimeType: 'application/json',
        builtinsDataCoders: {},
        dataCoders: null,
      );
      expect(result, isNull);
    });

    test('exact match in builtins', () {
      final result = fetchFindBestDataCoder<String>(
        mimeType: 'application/json',
        builtinsDataCoders: {'application/json': 'json-coder'},
        dataCoders: null,
      );
      expect(result, equals('json-coder'));
    });

    test('prefix match in builtins', () {
      final result = fetchFindBestDataCoder<String>(
        mimeType: 'text/plain',
        builtinsDataCoders: {'text/': 'text-coder'},
        dataCoders: null,
      );
      expect(result, equals('text-coder'));
    });

    test('exact match wins over prefix match in builtins', () {
      final result = fetchFindBestDataCoder<String>(
        mimeType: 'text/plain',
        builtinsDataCoders: {
          'text/plain': 'exact-text-plain',
          'text/': 'generic-text',
        },
        dataCoders: null,
      );
      expect(result, equals('exact-text-plain'));
    });

    test('longer prefix wins over shorter prefix in builtins', () {
      final result = fetchFindBestDataCoder<String>(
        mimeType: 'text/plain',
        builtinsDataCoders: {
          'text/p': 'medium-prefix',
          'text/': 'generic-text',
        },
        dataCoders: null,
      );
      expect(result, equals('medium-prefix'));
    });

    test(
      'user-supplied exact match takes priority over builtin prefix match',
      () {
        final result = fetchFindBestDataCoder<String>(
          mimeType: 'application/json',
          builtinsDataCoders: {'application/': 'builtin-app'},
          dataCoders: {'application/json': 'user-json'},
        );
        expect(result, equals('user-json'));
      },
    );

    test(
      'user-supplied prefix match prevents builtin exact match from being used',
      () {
        // User coders have a match (prefix), so builtins are not consulted.
        final result = fetchFindBestDataCoder<String>(
          mimeType: 'text/plain',
          builtinsDataCoders: {'text/plain': 'builtin-exact'},
          dataCoders: {'text/': 'user-prefix'},
        );
        expect(result, equals('user-prefix'));
      },
    );

    test('null dataCoders falls back to builtins', () {
      final result = fetchFindBestDataCoder<String>(
        mimeType: 'application/octet-stream',
        builtinsDataCoders: {'application/': 'builtin'},
        dataCoders: null,
      );
      expect(result, equals('builtin'));
    });

    test('empty dataCoders falls back to builtins', () {
      final result = fetchFindBestDataCoder<String>(
        mimeType: 'application/octet-stream',
        builtinsDataCoders: {'application/': 'builtin'},
        dataCoders: {},
      );
      expect(result, equals('builtin'));
    });

    test('empty-string key in builtins matches any mime type', () {
      // Matches because every string starts with ''
      final result = fetchFindBestDataCoder<String>(
        mimeType: 'image/png',
        builtinsDataCoders: {'': 'fallback'},
        dataCoders: null,
      );
      expect(result, equals('fallback'));
    });
  });

  // ---------------------------------------------------------------------------
  // FetchBuiltinsApplicationJsonCoders
  // ---------------------------------------------------------------------------
  group('FetchBuiltinsApplicationJsonCoders', () {
    test('encoder produces valid UTF-8 JSON bytes from a map', () {
      final bytes = FetchBuiltinsApplicationJsonCoders.encoder({
        'key': 'value',
        'num': 42,
      }, utf8);
      final decoded = utf8.decode(bytes);
      expect(jsonDecode(decoded), equals({'key': 'value', 'num': 42}));
    });

    test('encoder encodes null to JSON null bytes', () {
      final bytes = FetchBuiltinsApplicationJsonCoders.encoder(null, utf8);
      expect(utf8.decode(bytes), equals('null'));
    });

    test('encoder round-trips a JSON list', () {
      final bytes = FetchBuiltinsApplicationJsonCoders.encoder([
        1,
        'two',
        true,
      ], utf8);
      expect(jsonDecode(utf8.decode(bytes)), equals([1, 'two', true]));
    });

    test('decoder reads JSON object from stream', () async {
      const jsonString = '{"hello":"world"}';
      final result = await FetchBuiltinsApplicationJsonCoders.decoder(
        Stream.fromIterable([utf8.encode(jsonString)]),
        utf8,
      );
      expect(result, equals({'hello': 'world'}));
    });

    test('decoder reads JSON array from stream', () async {
      const jsonString = '[1, 2, 3]';
      final result = await FetchBuiltinsApplicationJsonCoders.decoder(
        Stream.fromIterable([utf8.encode(jsonString)]),
        utf8,
      );
      expect(result, equals([1, 2, 3]));
    });

    test('encoder-decoder round-trip', () async {
      const original = {'a': 1, 'b': 'hello', 'c': null};
      final bytes = FetchBuiltinsApplicationJsonCoders.encoder(original, utf8);
      final decoded = await FetchBuiltinsApplicationJsonCoders.decoder(
        Stream.fromIterable([bytes]),
        utf8,
      );
      expect(decoded, equals(original));
    });

    test('compatibleMimeTypes contains application/json', () {
      expect(
        FetchBuiltinsApplicationJsonCoders.compatibleMimeTypes,
        contains('application/json'),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // FetchBuiltinsTextPlainCoders
  // ---------------------------------------------------------------------------
  group('FetchBuiltinsTextPlainCoders', () {
    test('encoder encodes string to UTF-8 bytes', () {
      final bytes = FetchBuiltinsTextPlainCoders.encoder('hello', utf8);
      expect(utf8.decode(bytes), equals('hello'));
    });

    test('encoder returns empty bytes for null', () {
      final bytes = FetchBuiltinsTextPlainCoders.encoder(null, utf8);
      expect(bytes, isEmpty);
    });

    test('encoder round-trips non-ASCII characters', () {
      final bytes = FetchBuiltinsTextPlainCoders.encoder('héllo wörld', utf8);
      expect(utf8.decode(bytes), equals('héllo wörld'));
    });

    test('decoder reads string from stream', () async {
      final result = await FetchBuiltinsTextPlainCoders.decoder(
        Stream.fromIterable([utf8.encode('hello world')]),
        utf8,
      );
      expect(result, equals('hello world'));
    });

    test('encoder-decoder round-trip', () async {
      const original = 'The quick brown fox';
      final bytes = FetchBuiltinsTextPlainCoders.encoder(original, utf8);
      final decoded = await FetchBuiltinsTextPlainCoders.decoder(
        Stream.fromIterable([bytes]),
        utf8,
      );
      expect(decoded, equals(original));
    });

    test('compatibleMimeTypes contains text/ prefix', () {
      expect(
        FetchBuiltinsTextPlainCoders.compatibleMimeTypes,
        contains('text/'),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // FetchBuiltinsApplicationOctetCoders
  // ---------------------------------------------------------------------------
  group('FetchBuiltinsApplicationOctetCoders', () {
    test('encoder returns bytes as-is', () {
      final input = <int>[1, 2, 3, 4, 5];
      final result = FetchBuiltinsApplicationOctetCoders.encoder(input, latin1);
      expect(result, equals(input));
    });

    test('encoder returns empty list for null', () {
      final result = FetchBuiltinsApplicationOctetCoders.encoder(null, latin1);
      expect(result, isEmpty);
    });

    test('decoder collects chunks from stream', () async {
      final result = await FetchBuiltinsApplicationOctetCoders.decoder(
        Stream.fromIterable([
          [1, 2, 3],
          [4, 5],
        ]),
        latin1,
      );
      expect(result, equals([1, 2, 3, 4, 5]));
    });

    test('encoder-decoder round-trip', () async {
      final original = <int>[0, 127, 255, 10, 32];
      final encoded = FetchBuiltinsApplicationOctetCoders.encoder(
        original,
        latin1,
      );
      final decoded = await FetchBuiltinsApplicationOctetCoders.decoder(
        Stream.fromIterable([encoded]),
        latin1,
      );
      expect(decoded, equals(original));
    });

    test('compatibleMimeTypes contains empty-string fallback key', () {
      // The empty string prefix matches any MIME type via startsWith('')
      expect(
        FetchBuiltinsApplicationOctetCoders.compatibleMimeTypes,
        contains(''),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // FetchBuiltinsApplicationWwwFormUrlencodedCoders
  // ---------------------------------------------------------------------------
  group('FetchBuiltinsApplicationWwwFormUrlencodedCoders', () {
    final coders = FetchBuiltinsApplicationWwwFormUrlencodedCoders();

    test('encoder encodes simple key=value pair', () {
      final bytes = coders.encoder({'key': 'value'}, utf8);
      final result = utf8.decode(bytes);
      expect(result, equals('key=value'));
    });

    test('encoder returns empty bytes for null', () {
      final bytes = coders.encoder(null, utf8);
      expect(bytes, isEmpty);
    });

    test('encoder encodes multiple pairs separated by &', () {
      final bytes = coders.encoder({'a': 'x', 'b': 'y'}, utf8);
      final result = utf8.decode(bytes);
      final parts = result.split('&');
      expect(parts, containsAll(['a=x', 'b=y']));
    });

    test('encoder percent-encodes spaces', () {
      final bytes = coders.encoder({'q': 'hello world'}, utf8);
      final result = utf8.decode(bytes);
      expect(result, isNot(contains(' ')));
    });

    test('decoder parses simple key=value form data', () async {
      final result = await coders.decoder(
        Stream.fromIterable([utf8.encode('key=value')]),
        utf8,
      );
      expect(result['key'], equals('value'));
    });

    test('decoder parses multiple key=value pairs', () async {
      final result = await coders.decoder(
        Stream.fromIterable([utf8.encode('a=1&b=hello')]),
        utf8,
      );
      expect(result['a'], equals('1'));
      expect(result['b'], equals('hello'));
    });

    test('encoder-decoder round-trip for simple values', () async {
      final original = <String, Object>{'name': 'Alice', 'role': 'admin'};
      final bytes = coders.encoder(original, utf8);
      final decoded = await coders.decoder(Stream.fromIterable([bytes]), utf8);
      expect(decoded['name'], equals(original['name']));
      expect(decoded['role'], equals(original['role']));
    });

    test('compatibleMimeTypes contains application/x-www-form-urlencoded', () {
      expect(
        FetchBuiltinsApplicationWwwFormUrlencodedCoders.compatibleMimeTypes,
        contains('application/x-www-form-urlencoded'),
      );
    });
  });
}
