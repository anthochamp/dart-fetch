// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

/// @nodoc — use [fetchFindBestDataCoder] instead.
@Deprecated('Use fetchFindBestDataCoder() instead')
class FetchUtilities {
  /// @nodoc
  @Deprecated('Use fetchFindBestDataCoder() instead')
  static T? findBestDataCoder<T>({
    required String mimeType,
    required Map<String, T> builtinsDataCoders,
    required Map<String, T>? dataCoders,
  }) => fetchFindBestDataCoder(
    mimeType: mimeType,
    builtinsDataCoders: builtinsDataCoders,
    dataCoders: dataCoders,
  );
}

/// Selects the best matching data coder for [mimeType] from [dataCoders] and
/// [builtinsDataCoders].
///
/// Exact MIME-type matches in [dataCoders] take priority over prefix matches,
/// and user-supplied [dataCoders] take priority over [builtinsDataCoders].
/// Returns `null` when no match is found.
T? fetchFindBestDataCoder<T>({
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
