// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import '../fetch_options.dart';
import 'application_json_coders.dart';
import 'application_octet_coders.dart';
import 'application_www_form_url_encoded_coders.dart';
import 'text_plain_coders.dart';

class FetchBuiltins {
  static final applicationWwwFormUrlencodedCoders =
      FetchBuiltinsApplicationWwwFormUrlencodedCoders();

  static final structuredDataDecodersPerMimeType =
      <String, StructuredDataDecoder>{
    ...Map.fromEntries(FetchBuiltinsApplicationJsonCoders.compatibleMimeTypes
        .map((e) => MapEntry<String, StructuredDataDecoder>(
              e,
              FetchBuiltinsApplicationJsonCoders.decoder,
            ))),
    ...Map.fromEntries(FetchBuiltinsApplicationOctetCoders.compatibleMimeTypes
        .map((e) => MapEntry<String, StructuredDataDecoder>(
              e,
              FetchBuiltinsApplicationOctetCoders.decoder,
            ))),
    ...Map.fromEntries(FetchBuiltinsApplicationWwwFormUrlencodedCoders
        .compatibleMimeTypes
        .map((e) => MapEntry<String, StructuredDataDecoder>(
              e,
              applicationWwwFormUrlencodedCoders.decoder,
            ))),
    ...Map.fromEntries(FetchBuiltinsTextPlainCoders.compatibleMimeTypes.map(
      (e) => MapEntry<String, StructuredDataDecoder>(
        e,
        FetchBuiltinsTextPlainCoders.decoder,
      ),
    )),
  };

  static final structuredDataEncodersPerMimeType =
      <String, StructuredDataEncoder>{
    ...Map.fromEntries(FetchBuiltinsApplicationJsonCoders.compatibleMimeTypes
        .map((e) => MapEntry<String, StructuredDataEncoder>(
              e,
              FetchBuiltinsApplicationJsonCoders.encoder,
            ))),
    ...Map.fromEntries(FetchBuiltinsApplicationOctetCoders.compatibleMimeTypes
        .map((e) => MapEntry<String, StructuredDataEncoder>(
              e,
              FetchBuiltinsApplicationOctetCoders.encoder,
            ))),
    ...Map.fromEntries(FetchBuiltinsApplicationWwwFormUrlencodedCoders
        .compatibleMimeTypes
        .map((e) => MapEntry<String, StructuredDataEncoder>(
              e,
              applicationWwwFormUrlencodedCoders.encoder,
            ))),
    ...Map.fromEntries(FetchBuiltinsTextPlainCoders.compatibleMimeTypes
        .map((e) => MapEntry<String, StructuredDataEncoder>(
              e,
              FetchBuiltinsTextPlainCoders.encoder,
            ))),
  };
}
