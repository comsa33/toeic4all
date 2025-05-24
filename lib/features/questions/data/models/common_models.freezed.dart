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

/// @nodoc
mixin _$ApiMetadataResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String> get data => throw _privateConstructorUsedError;

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

class _$ApiMetadataResponseImpl implements _ApiMetadataResponse {
  const _$ApiMetadataResponseImpl(
      {this.success = true, this.message, required final List<String> data})
      : _data = data;

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
}

abstract class _ApiMetadataResponse implements ApiMetadataResponse {
  const factory _ApiMetadataResponse(
      {final bool success,
      final String? message,
      required final List<String> data}) = _$ApiMetadataResponseImpl;

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

/// @nodoc
mixin _$ApiSubtypesResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

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

class _$ApiSubtypesResponseImpl implements _ApiSubtypesResponse {
  const _$ApiSubtypesResponseImpl(
      {this.success = true, this.message, required this.data});

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
}

abstract class _ApiSubtypesResponse implements ApiSubtypesResponse {
  const factory _ApiSubtypesResponse(
      {final bool success,
      final String? message,
      required final dynamic data}) = _$ApiSubtypesResponseImpl;

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

Part7SetTypesData _$Part7SetTypesDataFromJson(Map<String, dynamic> json) {
  return _Part7SetTypesData.fromJson(json);
}

/// @nodoc
mixin _$Part7SetTypesData {
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'required_passages')
  int get requiredPassages => throw _privateConstructorUsedError;

  /// Serializes this Part7SetTypesData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7SetTypesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7SetTypesDataCopyWith<Part7SetTypesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7SetTypesDataCopyWith<$Res> {
  factory $Part7SetTypesDataCopyWith(
          Part7SetTypesData value, $Res Function(Part7SetTypesData) then) =
      _$Part7SetTypesDataCopyWithImpl<$Res, Part7SetTypesData>;
  @useResult
  $Res call(
      {String description,
      @JsonKey(name: 'required_passages') int requiredPassages});
}

/// @nodoc
class _$Part7SetTypesDataCopyWithImpl<$Res, $Val extends Part7SetTypesData>
    implements $Part7SetTypesDataCopyWith<$Res> {
  _$Part7SetTypesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7SetTypesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? requiredPassages = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requiredPassages: null == requiredPassages
          ? _value.requiredPassages
          : requiredPassages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7SetTypesDataImplCopyWith<$Res>
    implements $Part7SetTypesDataCopyWith<$Res> {
  factory _$$Part7SetTypesDataImplCopyWith(_$Part7SetTypesDataImpl value,
          $Res Function(_$Part7SetTypesDataImpl) then) =
      __$$Part7SetTypesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      @JsonKey(name: 'required_passages') int requiredPassages});
}

/// @nodoc
class __$$Part7SetTypesDataImplCopyWithImpl<$Res>
    extends _$Part7SetTypesDataCopyWithImpl<$Res, _$Part7SetTypesDataImpl>
    implements _$$Part7SetTypesDataImplCopyWith<$Res> {
  __$$Part7SetTypesDataImplCopyWithImpl(_$Part7SetTypesDataImpl _value,
      $Res Function(_$Part7SetTypesDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7SetTypesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? requiredPassages = null,
  }) {
    return _then(_$Part7SetTypesDataImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requiredPassages: null == requiredPassages
          ? _value.requiredPassages
          : requiredPassages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7SetTypesDataImpl implements _Part7SetTypesData {
  const _$Part7SetTypesDataImpl(
      {required this.description,
      @JsonKey(name: 'required_passages') required this.requiredPassages});

  factory _$Part7SetTypesDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7SetTypesDataImplFromJson(json);

  @override
  final String description;
  @override
  @JsonKey(name: 'required_passages')
  final int requiredPassages;

  @override
  String toString() {
    return 'Part7SetTypesData(description: $description, requiredPassages: $requiredPassages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7SetTypesDataImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.requiredPassages, requiredPassages) ||
                other.requiredPassages == requiredPassages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, requiredPassages);

  /// Create a copy of Part7SetTypesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7SetTypesDataImplCopyWith<_$Part7SetTypesDataImpl> get copyWith =>
      __$$Part7SetTypesDataImplCopyWithImpl<_$Part7SetTypesDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7SetTypesDataImplToJson(
      this,
    );
  }
}

abstract class _Part7SetTypesData implements Part7SetTypesData {
  const factory _Part7SetTypesData(
      {required final String description,
      @JsonKey(name: 'required_passages')
      required final int requiredPassages}) = _$Part7SetTypesDataImpl;

  factory _Part7SetTypesData.fromJson(Map<String, dynamic> json) =
      _$Part7SetTypesDataImpl.fromJson;

  @override
  String get description;
  @override
  @JsonKey(name: 'required_passages')
  int get requiredPassages;

  /// Create a copy of Part7SetTypesData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7SetTypesDataImplCopyWith<_$Part7SetTypesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiSetTypesResponse _$ApiSetTypesResponseFromJson(Map<String, dynamic> json) {
  return _ApiSetTypesResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiSetTypesResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Map<String, Part7SetTypesData> get data => throw _privateConstructorUsedError;

  /// Serializes this ApiSetTypesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiSetTypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiSetTypesResponseCopyWith<ApiSetTypesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiSetTypesResponseCopyWith<$Res> {
  factory $ApiSetTypesResponseCopyWith(
          ApiSetTypesResponse value, $Res Function(ApiSetTypesResponse) then) =
      _$ApiSetTypesResponseCopyWithImpl<$Res, ApiSetTypesResponse>;
  @useResult
  $Res call(
      {bool success, String? message, Map<String, Part7SetTypesData> data});
}

/// @nodoc
class _$ApiSetTypesResponseCopyWithImpl<$Res, $Val extends ApiSetTypesResponse>
    implements $ApiSetTypesResponseCopyWith<$Res> {
  _$ApiSetTypesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiSetTypesResponse
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
              as Map<String, Part7SetTypesData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiSetTypesResponseImplCopyWith<$Res>
    implements $ApiSetTypesResponseCopyWith<$Res> {
  factory _$$ApiSetTypesResponseImplCopyWith(_$ApiSetTypesResponseImpl value,
          $Res Function(_$ApiSetTypesResponseImpl) then) =
      __$$ApiSetTypesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success, String? message, Map<String, Part7SetTypesData> data});
}

/// @nodoc
class __$$ApiSetTypesResponseImplCopyWithImpl<$Res>
    extends _$ApiSetTypesResponseCopyWithImpl<$Res, _$ApiSetTypesResponseImpl>
    implements _$$ApiSetTypesResponseImplCopyWith<$Res> {
  __$$ApiSetTypesResponseImplCopyWithImpl(_$ApiSetTypesResponseImpl _value,
      $Res Function(_$ApiSetTypesResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiSetTypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$ApiSetTypesResponseImpl(
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
              as Map<String, Part7SetTypesData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiSetTypesResponseImpl implements _ApiSetTypesResponse {
  const _$ApiSetTypesResponseImpl(
      {this.success = true,
      this.message,
      required final Map<String, Part7SetTypesData> data})
      : _data = data;

  factory _$ApiSetTypesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiSetTypesResponseImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  final Map<String, Part7SetTypesData> _data;
  @override
  Map<String, Part7SetTypesData> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'ApiSetTypesResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSetTypesResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of ApiSetTypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSetTypesResponseImplCopyWith<_$ApiSetTypesResponseImpl> get copyWith =>
      __$$ApiSetTypesResponseImplCopyWithImpl<_$ApiSetTypesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiSetTypesResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiSetTypesResponse implements ApiSetTypesResponse {
  const factory _ApiSetTypesResponse(
          {final bool success,
          final String? message,
          required final Map<String, Part7SetTypesData> data}) =
      _$ApiSetTypesResponseImpl;

  factory _ApiSetTypesResponse.fromJson(Map<String, dynamic> json) =
      _$ApiSetTypesResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Map<String, Part7SetTypesData> get data;

  /// Create a copy of ApiSetTypesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiSetTypesResponseImplCopyWith<_$ApiSetTypesResponseImpl> get copyWith =>
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
