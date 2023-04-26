import 'dart:async';
import 'dart:convert';

import 'package:anthochamp_dart_essentials/dart_essentials.dart';

// converts UriQueryParameters back and forth

class FetchBuiltinsApplicationWwwFormUrlencodedCoders {
  static final compatibleMimeTypes = <String>{
    'application/x-www-form-urlencoded',
  };

  final Encoding queryComponentEncoding;

  FetchBuiltinsApplicationWwwFormUrlencodedCoders({
    this.queryComponentEncoding = utf8,
  });

  List<int> encoder(
    dynamic structuredData,
    Encoding charsetEncoding,
  ) {
    if (structuredData == null) {
      return [];
    }

    final queryString =
        (structuredData as UriQueryParameters).entries.map((fieldValue) {
      final encodedKey = Uri.encodeQueryComponent(
        fieldValue.key,
        encoding: queryComponentEncoding,
      );

      List<String> values;
      if (fieldValue.value is String) {
        values = [fieldValue.value];
      } else {
        values = fieldValue.value;
      }

      final encodedValues = values
          .map((value) => Uri.encodeQueryComponent(
                value,
                encoding: queryComponentEncoding,
              ))
          .join(',');

      return '$encodedKey=$encodedValues';
    }).join('&');

    return charsetEncoding.encode(queryString);
  }

  Future<UriQueryParameters> decoder(
    Stream<List<int>> bodyStream,
    Encoding charsetEncoding,
  ) async {
    return Uri.splitQueryString(
      await charsetEncoding.decodeStream(bodyStream),
      encoding: queryComponentEncoding,
    );
  }
}
