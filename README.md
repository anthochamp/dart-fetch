# An easy to use HTTP data fetcher

An easy to use HTTP data fetcher with HTTP1/2 and integrated HTTP cache support.

## Features

This package is based on the [ac_httpx_client](https://pub.dev/packages/ac_httpx_client)
package. It inherits all its features plus :

- `Content-Type` charset encoding/decoding;
- `Content-Type` structured-data encoders/decoders (more informations below);
- Custom typed-data support;

What it does NOT implement yet:

- WHATWG fetch-like cache modes;

## Usage

### Request

```dart

final options = FetchOptions(
  method: 'POST',
  url: Uri.parse('https://www.example.com'),
  headers: HttpxHeaders.fromMap({
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  }),
);

final request = fetch(options);

final requestData = {
  'data': 'Hello world!',
};

final response = await request.writeStructuredData(structuredData);

final responseData = await response.waitStructuredData();

// responseData is a charset decoded, json decoded value
print(responseData);
```

### Helpers

#### No data sent

```dart
final options = FetchOptions(
  method: 'GET',
  url: Uri.parse('https://www.example.com'),
  headers: HttpxHeaders.fromMap({
    'Accept': 'application/json',
  }),
);

final response = await fetchWithNoData(options);

final responseData = await response.waitStructuredData();

print(responseData);
```

#### With structured data sent

```dart
final options = FetchOptions(
  method: 'GET',
  url: Uri.parse('https://www.example.com'),
  headers: HttpxHeaders.fromMap({
    'Accept': 'application/json',
  }),
);

final requestData = {
  'data': 'Hello world!',
};

final response = await fetchWithStructuredData(options, requestData);

final responseData = await response.waitStructuredData();

print(responseData);
```

#### With typed data sent

```dart
class RequestData {
  final String data;

  RequestData(this.data);

  @override 
  Map<String, dynamic> toJson() => {
    'data': data,
  }
}

class ResponseData {
  final String data;

  ResponseData.fromJson(Map<String, dynamic> json)
    : data = json['data'];
}

dynamic typedDataEncoder(
  dynamic typedData,
  Type typedDataType,
) {
  if (typedData is RequestData) {
    return typedData.toJson();
  }

  return typedData;
}

dynamic typedDataDecoder(
  dynamic structuredData,
  Type typedDataType,
) {
  if (typedDataType == ResponseData) {
    return ResponseData.from(structuredData as Map<String, dynamic>);
  }

  return structuredData;
}

final options = FetchOptions(
  method: 'POST',
  url: Uri.parse('https://www.example.com'),
  headers: HttpxHeaders.fromMap({
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  }),
  defaultTypedDataEncoder: typedDataEncoder,
  defaultTypedDataDecoder: typedDataDecoder,
);

final requestData = RequestData('Hello world!');

final response = fetchWithTypedData(options, requestData);

final responseData = await response.waitTypedData<ResponseData>();

print(responseData);
```

## HTTP client

The default `HttpxClient` is accessible through the `FetchGlobals` singleton class:

```dart
final myHttpxClient = HttpxClient();

FetchGlobals().defaultHttpxClient = myHttpxClient;
```

You can also specify the `HttpxClient` you want to use when you call `fetch` (or
the helpers):

```dart
final myHttpxClient = HttpxClient();

final options = FetchOptions(
  method: 'GET',
  url: Uri.parse('https://www.example.com'),
);

final response = await fetchWithNoData(options, httpxClient: myHttpxClient);

...
```

## Structured data coders

Fetch will use structured-data coders to convert from and to raw payload bytes
when using structured-data or typed-data methods :

- `FetchRequest.writeStructuredData`,
- `FetchRequest.writeTypedData`,
- `FetchResponse.waitStructuredData`,
- `FetchResponse.waitTypedData`,
- `fetchWithStructuredData` helper and
- `fetchWithTypedData` helper.

The structured data coders are also responsable for charset encoding and decoding.

Matching of the right coder is based on `Content-Type` mime type. It can be overriden
when calling the above methods.

### Builtins coders

<!-- markdownlint-disable MD013 -->
| Mime type | Matcher | Structured-data type |
| --- | --- | --- |
| application/json | _(identical)_ | `Object?` |
| application/x-www-form-urlencoded | _(identical)_ | `Map<String, String \| Iterable<String>>` |
| text/plain | text/* | `String` |
| application/octet-stream | * | `List<int>` |
<!-- markdownlint-enable MD013 -->
