import 'package:fetch/src/builtins/application_json_coders.dart';
import 'package:fetch/src/builtins/application_octet_coders.dart';
import 'package:fetch/src/builtins/application_www_form_url_encoded_coders.dart';
import 'package:fetch/src/builtins/text_plain_coders.dart';
import 'package:fetch/src/fetch_options.dart';

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
