// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiMetadataResponse _$ApiMetadataResponseFromJson(Map<String, dynamic> json) {
  return _ApiMetadataResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiMetadataResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String> get data => throw _privateConstructorUsedError;

  /// Serializes this ApiMetadataResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiMetadataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiMetadataResponseCopyWith<ApiMetadataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiMetadataResponseCopyWith<$Res> {
  factory $ApiMetadataResponseCopyWith(
          ApiMetadataResponse value, $Res Function(ApiMetadataResponse) then) =
      _$ApiMetadataResponseCopyWithImpl<$Res, ApiMetadataResponse>;
  @useResult
  $Res call({bool success, String? message, List<String> data});
}

/// @nodoc
class _$ApiMetadataResponseCopyWithImpl<$Res, $Val extends ApiMetadataResponse>
    implements $ApiMetadataResponseCopyWith<$Res> {
  _$ApiMetadataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiMetadataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiMetadataResponseImplCopyWith<$Res>
    implements $ApiMetadataResponseCopyWith<$Res> {
  factory _$$ApiMetadataResponseImplCopyWith(_$ApiMetadataResponseImpl value,
          $Res Function(_$ApiMetadataResponseImpl) then) =
      __$$ApiMetadataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, List<String> data});
}

/// @nodoc
class __$$ApiMetadataResponseImplCopyWithImpl<$Res>
    extends _$ApiMetadataResponseCopyWithImpl<$Res, _$ApiMetadataResponseImpl>
    implements _$$ApiMetadataResponseImplCopyWith<$Res> {
  __$$ApiMetadataResponseImplCopyWithImpl(_$ApiMetadataResponseImpl _value,
      $Res Function(_$ApiMetadataResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiMetadataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$ApiMetadataResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiMetadataResponseImpl implements _ApiMetadataResponse {
  const _$ApiMetadataResponseImpl(
      {this.success = true, this.message, required final List<String> data})
      : _data = data;

  factory _$ApiMetadataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiMetadataResponseImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  final List<String> _data;
  @override
  List<String> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ApiMetadataResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiMetadataResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of ApiMetadataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiMetadataResponseImplCopyWith<_$ApiMetadataResponseImpl> get copyWith =>
      __$$ApiMetadataResponseImplCopyWithImpl<_$ApiMetadataResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiMetadataResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiMetadataResponse implements ApiMetadataResponse {
  const factory _ApiMetadataResponse(
      {final bool success,
      final String? message,
      required final List<String> data}) = _$ApiMetadataResponseImpl;

  factory _ApiMetadataResponse.fromJson(Map<String, dynamic> json) =
      _$ApiMetadataResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  List<String> get data;

  /// Create a copy of ApiMetadataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiMetadataResponseImplCopyWith<_$ApiMetadataResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiSubtypesResponse _$ApiSubtypesResponseFromJson(Map<String, dynamic> json) {
  return _ApiSubtypesResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiSubtypesResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  /// Serializes this ApiSubtypesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiSubtypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiSubtypesResponseCopyWith<ApiSubtypesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiSubtypesResponseCopyWith<$Res> {
  factory $ApiSubtypesResponseCopyWith(
          ApiSubtypesResponse value, $Res Function(ApiSubtypesResponse) then) =
      _$ApiSubtypesResponseCopyWithImpl<$Res, ApiSubtypesResponse>;
  @useResult
  $Res call({bool success, String? message, dynamic data});
}

/// @nodoc
class _$ApiSubtypesResponseCopyWithImpl<$Res, $Val extends ApiSubtypesResponse>
    implements $ApiSubtypesResponseCopyWith<$Res> {
  _$ApiSubtypesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiSubtypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiSubtypesResponseImplCopyWith<$Res>
    implements $ApiSubtypesResponseCopyWith<$Res> {
  factory _$$ApiSubtypesResponseImplCopyWith(_$ApiSubtypesResponseImpl value,
          $Res Function(_$ApiSubtypesResponseImpl) then) =
      __$$ApiSubtypesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, dynamic data});
}

/// @nodoc
class __$$ApiSubtypesResponseImplCopyWithImpl<$Res>
    extends _$ApiSubtypesResponseCopyWithImpl<$Res, _$ApiSubtypesResponseImpl>
    implements _$$ApiSubtypesResponseImplCopyWith<$Res> {
  __$$ApiSubtypesResponseImplCopyWithImpl(_$ApiSubtypesResponseImpl _value,
      $Res Function(_$ApiSubtypesResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiSubtypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ApiSubtypesResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiSubtypesResponseImpl implements _ApiSubtypesResponse {
  const _$ApiSubtypesResponseImpl(
      {this.success = true, this.message, required this.data});

  factory _$ApiSubtypesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiSubtypesResponseImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'ApiSubtypesResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSubtypesResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, const DeepCollectionEquality().hash(data));

  /// Create a copy of ApiSubtypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSubtypesResponseImplCopyWith<_$ApiSubtypesResponseImpl> get copyWith =>
      __$$ApiSubtypesResponseImplCopyWithImpl<_$ApiSubtypesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiSubtypesResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiSubtypesResponse implements ApiSubtypesResponse {
  const factory _ApiSubtypesResponse(
      {final bool success,
      final String? message,
      required final dynamic data}) = _$ApiSubtypesResponseImpl;

  factory _ApiSubtypesResponse.fromJson(Map<String, dynamic> json) =
      _$ApiSubtypesResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  dynamic get data;

  /// Create a copy of ApiSubtypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiSubtypesResponseImplCopyWith<_$ApiSubtypesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiErrorResponse _$ApiErrorResponseFromJson(Map<String, dynamic> json) {
  return _ApiErrorResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiErrorResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get detail => throw _privateConstructorUsedError;

  /// Serializes this ApiErrorResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiErrorResponseCopyWith<ApiErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorResponseCopyWith<$Res> {
  factory $ApiErrorResponseCopyWith(
          ApiErrorResponse value, $Res Function(ApiErrorResponse) then) =
      _$ApiErrorResponseCopyWithImpl<$Res, ApiErrorResponse>;
  @useResult
  $Res call({bool success, String message, String? detail});
}

/// @nodoc
class _$ApiErrorResponseCopyWithImpl<$Res, $Val extends ApiErrorResponse>
    implements $ApiErrorResponseCopyWith<$Res> {
  _$ApiErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiErrorResponseImplCopyWith<$Res>
    implements $ApiErrorResponseCopyWith<$Res> {
  factory _$$ApiErrorResponseImplCopyWith(_$ApiErrorResponseImpl value,
          $Res Function(_$ApiErrorResponseImpl) then) =
      __$$ApiErrorResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, String? detail});
}

/// @nodoc
class __$$ApiErrorResponseImplCopyWithImpl<$Res>
    extends _$ApiErrorResponseCopyWithImpl<$Res, _$ApiErrorResponseImpl>
    implements _$$ApiErrorResponseImplCopyWith<$Res> {
  __$$ApiErrorResponseImplCopyWithImpl(_$ApiErrorResponseImpl _value,
      $Res Function(_$ApiErrorResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? detail = freezed,
  }) {
    return _then(_$ApiErrorResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorResponseImpl implements _ApiErrorResponse {
  const _$ApiErrorResponseImpl(
      {required this.success, required this.message, this.detail});

  factory _$ApiErrorResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final String? detail;

  @override
  String toString() {
    return 'ApiErrorResponse(success: $success, message: $message, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, detail);

  /// Create a copy of ApiErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorResponseImplCopyWith<_$ApiErrorResponseImpl> get copyWith =>
      __$$ApiErrorResponseImplCopyWithImpl<_$ApiErrorResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiErrorResponse implements ApiErrorResponse {
  const factory _ApiErrorResponse(
      {required final bool success,
      required final String message,
      final String? detail}) = _$ApiErrorResponseImpl;

  factory _ApiErrorResponse.fromJson(Map<String, dynamic> json) =
      _$ApiErrorResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  String? get detail;

  /// Create a copy of ApiErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiErrorResponseImplCopyWith<_$ApiErrorResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
