// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class FetchUtilities {
  static T? findBestDataCoder<T>({
    required String mimeType,
    required Map<String, T> builtinsDataCoders,
    required Map<String, T>? dataCoders,
  }) {
    T? bestDataCoder;
    int? bestMatchLength;

    for (final dataCoder in dataCoders?.entries ?? <MapEntry<String, T>>[]) {
      if (mimeType == dataCoder.key) {
        return dataCoder.value;
      } else if (mimeType.startsWith(dataCoder.key)) {
        final dataCoderKeyLength = dataCoder.key.length;

        if (bestMatchLength == null || dataCoderKeyLength > bestMatchLength) {
          bestDataCoder = dataCoder.value;
          bestMatchLength = dataCoderKeyLength;
        }
      }
    }

    if (bestMatchLength == null) {
      for (final dataCoder in builtinsDataCoders.entries) {
        if (mimeType == dataCoder.key) {
          return dataCoder.value;
        } else if (mimeType.startsWith(dataCoder.key)) {
          final dataCoderKeyLength = dataCoder.key.length;

          if (bestMatchLength == null || dataCoderKeyLength > bestMatchLength) {
            bestDataCoder = dataCoder.value;
            bestMatchLength = dataCoderKeyLength;
          }
        }
      }
    }

    return bestDataCoder;
  }
}
