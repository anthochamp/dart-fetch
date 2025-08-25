// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FetchOptions {

 String get method; Uri get url; HttpxHeaders? get headers; Iterable<HttpxCredentials>? get realmsCredentials; Map<String, StructuredDataEncoder>? get structuredDataEncoders; Map<String, StructuredDataDecoder>? get structuredDataDecoders; TypedDataEncoder? get defaultTypedDataEncoder; TypedDataDecoder? get defaultTypedDataDecoder; int? get maxRedirects; HttpxCachePolicy? get cachePolicy; dynamic get metadata; Duration? get connectionTimeout;
/// Create a copy of FetchOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchOptionsCopyWith<FetchOptions> get copyWith => _$FetchOptionsCopyWithImpl<FetchOptions>(this as FetchOptions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchOptions&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&(identical(other.headers, headers) || other.headers == headers)&&const DeepCollectionEquality().equals(other.realmsCredentials, realmsCredentials)&&const DeepCollectionEquality().equals(other.structuredDataEncoders, structuredDataEncoders)&&const DeepCollectionEquality().equals(other.structuredDataDecoders, structuredDataDecoders)&&(identical(other.defaultTypedDataEncoder, defaultTypedDataEncoder) || other.defaultTypedDataEncoder == defaultTypedDataEncoder)&&(identical(other.defaultTypedDataDecoder, defaultTypedDataDecoder) || other.defaultTypedDataDecoder == defaultTypedDataDecoder)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.cachePolicy, cachePolicy) || other.cachePolicy == cachePolicy)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.connectionTimeout, connectionTimeout) || other.connectionTimeout == connectionTimeout));
}


@override
int get hashCode => Object.hash(runtimeType,method,url,headers,const DeepCollectionEquality().hash(realmsCredentials),const DeepCollectionEquality().hash(structuredDataEncoders),const DeepCollectionEquality().hash(structuredDataDecoders),defaultTypedDataEncoder,defaultTypedDataDecoder,maxRedirects,cachePolicy,const DeepCollectionEquality().hash(metadata),connectionTimeout);

@override
String toString() {
  return 'FetchOptions(method: $method, url: $url, headers: $headers, realmsCredentials: $realmsCredentials, structuredDataEncoders: $structuredDataEncoders, structuredDataDecoders: $structuredDataDecoders, defaultTypedDataEncoder: $defaultTypedDataEncoder, defaultTypedDataDecoder: $defaultTypedDataDecoder, maxRedirects: $maxRedirects, cachePolicy: $cachePolicy, metadata: $metadata, connectionTimeout: $connectionTimeout)';
}


}

/// @nodoc
abstract mixin class $FetchOptionsCopyWith<$Res>  {
  factory $FetchOptionsCopyWith(FetchOptions value, $Res Function(FetchOptions) _then) = _$FetchOptionsCopyWithImpl;
@useResult
$Res call({
 String method, Uri url, HttpxHeaders? headers, Iterable<HttpxCredentials>? realmsCredentials, Map<String, StructuredDataEncoder>? structuredDataEncoders, Map<String, StructuredDataDecoder>? structuredDataDecoders, TypedDataEncoder? defaultTypedDataEncoder, TypedDataDecoder? defaultTypedDataDecoder, int? maxRedirects, HttpxCachePolicy? cachePolicy, dynamic metadata, Duration? connectionTimeout
});




}
/// @nodoc
class _$FetchOptionsCopyWithImpl<$Res>
    implements $FetchOptionsCopyWith<$Res> {
  _$FetchOptionsCopyWithImpl(this._self, this._then);

  final FetchOptions _self;
  final $Res Function(FetchOptions) _then;

/// Create a copy of FetchOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? url = null,Object? headers = freezed,Object? realmsCredentials = freezed,Object? structuredDataEncoders = freezed,Object? structuredDataDecoders = freezed,Object? defaultTypedDataEncoder = freezed,Object? defaultTypedDataDecoder = freezed,Object? maxRedirects = freezed,Object? cachePolicy = freezed,Object? metadata = freezed,Object? connectionTimeout = freezed,}) {
  return _then(_self.copyWith(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as HttpxHeaders?,realmsCredentials: freezed == realmsCredentials ? _self.realmsCredentials : realmsCredentials // ignore: cast_nullable_to_non_nullable
as Iterable<HttpxCredentials>?,structuredDataEncoders: freezed == structuredDataEncoders ? _self.structuredDataEncoders : structuredDataEncoders // ignore: cast_nullable_to_non_nullable
as Map<String, StructuredDataEncoder>?,structuredDataDecoders: freezed == structuredDataDecoders ? _self.structuredDataDecoders : structuredDataDecoders // ignore: cast_nullable_to_non_nullable
as Map<String, StructuredDataDecoder>?,defaultTypedDataEncoder: freezed == defaultTypedDataEncoder ? _self.defaultTypedDataEncoder : defaultTypedDataEncoder // ignore: cast_nullable_to_non_nullable
as TypedDataEncoder?,defaultTypedDataDecoder: freezed == defaultTypedDataDecoder ? _self.defaultTypedDataDecoder : defaultTypedDataDecoder // ignore: cast_nullable_to_non_nullable
as TypedDataDecoder?,maxRedirects: freezed == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int?,cachePolicy: freezed == cachePolicy ? _self.cachePolicy : cachePolicy // ignore: cast_nullable_to_non_nullable
as HttpxCachePolicy?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,connectionTimeout: freezed == connectionTimeout ? _self.connectionTimeout : connectionTimeout // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchOptions].
extension FetchOptionsPatterns on FetchOptions {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchOptions() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchOptions value)  $default,){
final _that = this;
switch (_that) {
case _FetchOptions():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchOptions value)?  $default,){
final _that = this;
switch (_that) {
case _FetchOptions() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String method,  Uri url,  HttpxHeaders? headers,  Iterable<HttpxCredentials>? realmsCredentials,  Map<String, StructuredDataEncoder>? structuredDataEncoders,  Map<String, StructuredDataDecoder>? structuredDataDecoders,  TypedDataEncoder? defaultTypedDataEncoder,  TypedDataDecoder? defaultTypedDataDecoder,  int? maxRedirects,  HttpxCachePolicy? cachePolicy,  dynamic metadata,  Duration? connectionTimeout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchOptions() when $default != null:
return $default(_that.method,_that.url,_that.headers,_that.realmsCredentials,_that.structuredDataEncoders,_that.structuredDataDecoders,_that.defaultTypedDataEncoder,_that.defaultTypedDataDecoder,_that.maxRedirects,_that.cachePolicy,_that.metadata,_that.connectionTimeout);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String method,  Uri url,  HttpxHeaders? headers,  Iterable<HttpxCredentials>? realmsCredentials,  Map<String, StructuredDataEncoder>? structuredDataEncoders,  Map<String, StructuredDataDecoder>? structuredDataDecoders,  TypedDataEncoder? defaultTypedDataEncoder,  TypedDataDecoder? defaultTypedDataDecoder,  int? maxRedirects,  HttpxCachePolicy? cachePolicy,  dynamic metadata,  Duration? connectionTimeout)  $default,) {final _that = this;
switch (_that) {
case _FetchOptions():
return $default(_that.method,_that.url,_that.headers,_that.realmsCredentials,_that.structuredDataEncoders,_that.structuredDataDecoders,_that.defaultTypedDataEncoder,_that.defaultTypedDataDecoder,_that.maxRedirects,_that.cachePolicy,_that.metadata,_that.connectionTimeout);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String method,  Uri url,  HttpxHeaders? headers,  Iterable<HttpxCredentials>? realmsCredentials,  Map<String, StructuredDataEncoder>? structuredDataEncoders,  Map<String, StructuredDataDecoder>? structuredDataDecoders,  TypedDataEncoder? defaultTypedDataEncoder,  TypedDataDecoder? defaultTypedDataDecoder,  int? maxRedirects,  HttpxCachePolicy? cachePolicy,  dynamic metadata,  Duration? connectionTimeout)?  $default,) {final _that = this;
switch (_that) {
case _FetchOptions() when $default != null:
return $default(_that.method,_that.url,_that.headers,_that.realmsCredentials,_that.structuredDataEncoders,_that.structuredDataDecoders,_that.defaultTypedDataEncoder,_that.defaultTypedDataDecoder,_that.maxRedirects,_that.cachePolicy,_that.metadata,_that.connectionTimeout);case _:
  return null;

}
}

}

/// @nodoc


class _FetchOptions implements FetchOptions {
  const _FetchOptions({required this.method, required this.url, this.headers, this.realmsCredentials, final  Map<String, StructuredDataEncoder>? structuredDataEncoders, final  Map<String, StructuredDataDecoder>? structuredDataDecoders, this.defaultTypedDataEncoder, this.defaultTypedDataDecoder, this.maxRedirects, this.cachePolicy, this.metadata, this.connectionTimeout}): _structuredDataEncoders = structuredDataEncoders,_structuredDataDecoders = structuredDataDecoders;
  

@override final  String method;
@override final  Uri url;
@override final  HttpxHeaders? headers;
@override final  Iterable<HttpxCredentials>? realmsCredentials;
 final  Map<String, StructuredDataEncoder>? _structuredDataEncoders;
@override Map<String, StructuredDataEncoder>? get structuredDataEncoders {
  final value = _structuredDataEncoders;
  if (value == null) return null;
  if (_structuredDataEncoders is EqualUnmodifiableMapView) return _structuredDataEncoders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, StructuredDataDecoder>? _structuredDataDecoders;
@override Map<String, StructuredDataDecoder>? get structuredDataDecoders {
  final value = _structuredDataDecoders;
  if (value == null) return null;
  if (_structuredDataDecoders is EqualUnmodifiableMapView) return _structuredDataDecoders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  TypedDataEncoder? defaultTypedDataEncoder;
@override final  TypedDataDecoder? defaultTypedDataDecoder;
@override final  int? maxRedirects;
@override final  HttpxCachePolicy? cachePolicy;
@override final  dynamic metadata;
@override final  Duration? connectionTimeout;

/// Create a copy of FetchOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchOptionsCopyWith<_FetchOptions> get copyWith => __$FetchOptionsCopyWithImpl<_FetchOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchOptions&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&(identical(other.headers, headers) || other.headers == headers)&&const DeepCollectionEquality().equals(other.realmsCredentials, realmsCredentials)&&const DeepCollectionEquality().equals(other._structuredDataEncoders, _structuredDataEncoders)&&const DeepCollectionEquality().equals(other._structuredDataDecoders, _structuredDataDecoders)&&(identical(other.defaultTypedDataEncoder, defaultTypedDataEncoder) || other.defaultTypedDataEncoder == defaultTypedDataEncoder)&&(identical(other.defaultTypedDataDecoder, defaultTypedDataDecoder) || other.defaultTypedDataDecoder == defaultTypedDataDecoder)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.cachePolicy, cachePolicy) || other.cachePolicy == cachePolicy)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.connectionTimeout, connectionTimeout) || other.connectionTimeout == connectionTimeout));
}


@override
int get hashCode => Object.hash(runtimeType,method,url,headers,const DeepCollectionEquality().hash(realmsCredentials),const DeepCollectionEquality().hash(_structuredDataEncoders),const DeepCollectionEquality().hash(_structuredDataDecoders),defaultTypedDataEncoder,defaultTypedDataDecoder,maxRedirects,cachePolicy,const DeepCollectionEquality().hash(metadata),connectionTimeout);

@override
String toString() {
  return 'FetchOptions(method: $method, url: $url, headers: $headers, realmsCredentials: $realmsCredentials, structuredDataEncoders: $structuredDataEncoders, structuredDataDecoders: $structuredDataDecoders, defaultTypedDataEncoder: $defaultTypedDataEncoder, defaultTypedDataDecoder: $defaultTypedDataDecoder, maxRedirects: $maxRedirects, cachePolicy: $cachePolicy, metadata: $metadata, connectionTimeout: $connectionTimeout)';
}


}

/// @nodoc
abstract mixin class _$FetchOptionsCopyWith<$Res> implements $FetchOptionsCopyWith<$Res> {
  factory _$FetchOptionsCopyWith(_FetchOptions value, $Res Function(_FetchOptions) _then) = __$FetchOptionsCopyWithImpl;
@override @useResult
$Res call({
 String method, Uri url, HttpxHeaders? headers, Iterable<HttpxCredentials>? realmsCredentials, Map<String, StructuredDataEncoder>? structuredDataEncoders, Map<String, StructuredDataDecoder>? structuredDataDecoders, TypedDataEncoder? defaultTypedDataEncoder, TypedDataDecoder? defaultTypedDataDecoder, int? maxRedirects, HttpxCachePolicy? cachePolicy, dynamic metadata, Duration? connectionTimeout
});




}
/// @nodoc
class __$FetchOptionsCopyWithImpl<$Res>
    implements _$FetchOptionsCopyWith<$Res> {
  __$FetchOptionsCopyWithImpl(this._self, this._then);

  final _FetchOptions _self;
  final $Res Function(_FetchOptions) _then;

/// Create a copy of FetchOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? url = null,Object? headers = freezed,Object? realmsCredentials = freezed,Object? structuredDataEncoders = freezed,Object? structuredDataDecoders = freezed,Object? defaultTypedDataEncoder = freezed,Object? defaultTypedDataDecoder = freezed,Object? maxRedirects = freezed,Object? cachePolicy = freezed,Object? metadata = freezed,Object? connectionTimeout = freezed,}) {
  return _then(_FetchOptions(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as HttpxHeaders?,realmsCredentials: freezed == realmsCredentials ? _self.realmsCredentials : realmsCredentials // ignore: cast_nullable_to_non_nullable
as Iterable<HttpxCredentials>?,structuredDataEncoders: freezed == structuredDataEncoders ? _self._structuredDataEncoders : structuredDataEncoders // ignore: cast_nullable_to_non_nullable
as Map<String, StructuredDataEncoder>?,structuredDataDecoders: freezed == structuredDataDecoders ? _self._structuredDataDecoders : structuredDataDecoders // ignore: cast_nullable_to_non_nullable
as Map<String, StructuredDataDecoder>?,defaultTypedDataEncoder: freezed == defaultTypedDataEncoder ? _self.defaultTypedDataEncoder : defaultTypedDataEncoder // ignore: cast_nullable_to_non_nullable
as TypedDataEncoder?,defaultTypedDataDecoder: freezed == defaultTypedDataDecoder ? _self.defaultTypedDataDecoder : defaultTypedDataDecoder // ignore: cast_nullable_to_non_nullable
as TypedDataDecoder?,maxRedirects: freezed == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int?,cachePolicy: freezed == cachePolicy ? _self.cachePolicy : cachePolicy // ignore: cast_nullable_to_non_nullable
as HttpxCachePolicy?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,connectionTimeout: freezed == connectionTimeout ? _self.connectionTimeout : connectionTimeout // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
