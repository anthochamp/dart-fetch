// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:ac_dart_essentials/ac_dart_essentials.dart';

// converts JsonValue back and forth

class FetchBuiltinsApplicationJsonCoders {
  static final compatibleMimeTypes = <String>{
    'application/json',
  };

  static List<int> encoder(
    JsonValue structuredData,
    Encoding charsetEncoding,
  ) {
    if (!['csutf8', 'utf-8'].contains(charsetEncoding.name.toLowerCase())) {
      const converter = JsonEncoder();

      final body = converter.convert(structuredData);

      return charsetEncoding.encode(body);
    } else {
      final converter = JsonUtf8Encoder();

      return converter.convert(structuredData);
    }
  }

  static Future<JsonValue> decoder(
    Stream<List<int>> bodyStream,
    Encoding charsetEncoding,
  ) {
    return bodyStream
        .transform(charsetEncoding.decoder)
        .transform(const JsonDecoder())
        .single;
  }
}
