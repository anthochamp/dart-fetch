// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
