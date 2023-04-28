// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

// converts List<int> back and forth

class FetchBuiltinsApplicationOctetCoders {
  // https://www.rfc-editor.org/rfc/rfc9110.html#section-8.3
  static final compatibleMimeTypes = <String>{
    '',
  };

  static List<int> encoder(dynamic structuredData, Encoding _) {
    if (structuredData == null) {
      return [];
    }

    return structuredData as List<int>;
  }

  static Future<List<int>> decoder(Stream<List<int>> bodyStream, Encoding _) {
    return bodyStream
        .fold(<int>[], (previous, element) => previous..addAll(element));
  }
}
