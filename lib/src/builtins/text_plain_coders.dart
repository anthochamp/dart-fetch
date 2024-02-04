// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';
import 'dart:convert';

// converts String back and forth

class FetchBuiltinsTextPlainCoders {
  static final compatibleMimeTypes = <String>{
    'text/',
  };

  static List<int> encoder(
    dynamic structuredData,
    Encoding charsetEncoding,
  ) {
    if (structuredData == null) {
      return [];
    }

    return charsetEncoding.encode(structuredData);
  }

  static Future<String> decoder(
    Stream<List<int>> bodyStream,
    Encoding charsetEncoding,
  ) {
    return charsetEncoding.decodeStream(bodyStream);
  }
}
