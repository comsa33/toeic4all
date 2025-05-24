// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part5_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) {
  return _ChoiceModel.fromJson(json);
}

/// @nodoc
mixin _$ChoiceModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  /// Serializes this ChoiceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChoiceModelCopyWith<ChoiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChoiceModelCopyWith<$Res> {
  factory $ChoiceModelCopyWith(
          ChoiceModel value, $Res Function(ChoiceModel) then) =
      _$ChoiceModelCopyWithImpl<$Res, ChoiceModel>;
  @useResult
  $Res call({String id, String text, String translation});
}

/// @nodoc
class _$ChoiceModelCopyWithImpl<$Res, $Val extends ChoiceModel>
    implements $ChoiceModelCopyWith<$Res> {
  _$ChoiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? translation = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChoiceModelImplCopyWith<$Res>
    implements $ChoiceModelCopyWith<$Res> {
  factory _$$ChoiceModelImplCopyWith(
          _$ChoiceModelImpl value, $Res Function(_$ChoiceModelImpl) then) =
      __$$ChoiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, String translation});
}

/// @nodoc
class __$$ChoiceModelImplCopyWithImpl<$Res>
    extends _$ChoiceModelCopyWithImpl<$Res, _$ChoiceModelImpl>
    implements _$$ChoiceModelImplCopyWith<$Res> {
  __$$ChoiceModelImplCopyWithImpl(
      _$ChoiceModelImpl _value, $Res Function(_$ChoiceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? translation = null,
  }) {
    return _then(_$ChoiceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChoiceModelImpl implements _ChoiceModel {
  const _$ChoiceModelImpl(
      {required this.id, required this.text, required this.translation});

  factory _$ChoiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChoiceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String translation;

  @override
  String toString() {
    return 'ChoiceModel(id: $id, text: $text, translation: $translation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoiceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, translation);

  /// Create a copy of ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoiceModelImplCopyWith<_$ChoiceModelImpl> get copyWith =>
      __$$ChoiceModelImplCopyWithImpl<_$ChoiceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChoiceModelImplToJson(
      this,
    );
  }
}

abstract class _ChoiceModel implements ChoiceModel {
  const factory _ChoiceModel(
      {required final String id,
      required final String text,
      required final String translation}) = _$ChoiceModelImpl;

  factory _ChoiceModel.fromJson(Map<String, dynamic> json) =
      _$ChoiceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get translation;

  /// Create a copy of ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChoiceModelImplCopyWith<_$ChoiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part5QuestionModel _$Part5QuestionModelFromJson(Map<String, dynamic> json) {
  return _Part5QuestionModel.fromJson(json);
}

/// @nodoc
mixin _$Part5QuestionModel {
  String get id => throw _privateConstructorUsedError;
  String get questionCategory => throw _privateConstructorUsedError;
  String get questionSubType => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get questionText => throw _privateConstructorUsedError;
  String get questionTranslation => throw _privateConstructorUsedError;
  List<ChoiceModel> get choices => throw _privateConstructorUsedError;

  /// Serializes this Part5QuestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part5QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part5QuestionModelCopyWith<Part5QuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part5QuestionModelCopyWith<$Res> {
  factory $Part5QuestionModelCopyWith(
          Part5QuestionModel value, $Res Function(Part5QuestionModel) then) =
      _$Part5QuestionModelCopyWithImpl<$Res, Part5QuestionModel>;
  @useResult
  $Res call(
      {String id,
      String questionCategory,
      String questionSubType,
      String difficulty,
      String questionText,
      String questionTranslation,
      List<ChoiceModel> choices});
}

/// @nodoc
class _$Part5QuestionModelCopyWithImpl<$Res, $Val extends Part5QuestionModel>
    implements $Part5QuestionModelCopyWith<$Res> {
  _$Part5QuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part5QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? questionCategory = null,
    Object? questionSubType = null,
    Object? difficulty = null,
    Object? questionText = null,
    Object? questionTranslation = null,
    Object? choices = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      questionCategory: null == questionCategory
          ? _value.questionCategory
          : questionCategory // ignore: cast_nullable_to_non_nullable
              as String,
      questionSubType: null == questionSubType
          ? _value.questionSubType
          : questionSubType // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      questionText: null == questionText
          ? _value.questionText
          : questionText // ignore: cast_nullable_to_non_nullable
              as String,
      questionTranslation: null == questionTranslation
          ? _value.questionTranslation
          : questionTranslation // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part5QuestionModelImplCopyWith<$Res>
    implements $Part5QuestionModelCopyWith<$Res> {
  factory _$$Part5QuestionModelImplCopyWith(_$Part5QuestionModelImpl value,
          $Res Function(_$Part5QuestionModelImpl) then) =
      __$$Part5QuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String questionCategory,
      String questionSubType,
      String difficulty,
      String questionText,
      String questionTranslation,
      List<ChoiceModel> choices});
}

/// @nodoc
class __$$Part5QuestionModelImplCopyWithImpl<$Res>
    extends _$Part5QuestionModelCopyWithImpl<$Res, _$Part5QuestionModelImpl>
    implements _$$Part5QuestionModelImplCopyWith<$Res> {
  __$$Part5QuestionModelImplCopyWithImpl(_$Part5QuestionModelImpl _value,
      $Res Function(_$Part5QuestionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part5QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? questionCategory = null,
    Object? questionSubType = null,
    Object? difficulty = null,
    Object? questionText = null,
    Object? questionTranslation = null,
    Object? choices = null,
  }) {
    return _then(_$Part5QuestionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      questionCategory: null == questionCategory
          ? _value.questionCategory
          : questionCategory // ignore: cast_nullable_to_non_nullable
              as String,
      questionSubType: null == questionSubType
          ? _value.questionSubType
          : questionSubType // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      questionText: null == questionText
          ? _value.questionText
          : questionText // ignore: cast_nullable_to_non_nullable
              as String,
      questionTranslation: null == questionTranslation
          ? _value.questionTranslation
          : questionTranslation // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part5QuestionModelImpl implements _Part5QuestionModel {
  const _$Part5QuestionModelImpl(
      {required this.id,
      required this.questionCategory,
      required this.questionSubType,
      required this.difficulty,
      required this.questionText,
      required this.questionTranslation,
      required final List<ChoiceModel> choices})
      : _choices = choices;

  factory _$Part5QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part5QuestionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String questionCategory;
  @override
  final String questionSubType;
  @override
  final String difficulty;
  @override
  final String questionText;
  @override
  final String questionTranslation;
  final List<ChoiceModel> _choices;
  @override
  List<ChoiceModel> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  String toString() {
    return 'Part5QuestionModel(id: $id, questionCategory: $questionCategory, questionSubType: $questionSubType, difficulty: $difficulty, questionText: $questionText, questionTranslation: $questionTranslation, choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part5QuestionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questionCategory, questionCategory) ||
                other.questionCategory == questionCategory) &&
            (identical(other.questionSubType, questionSubType) ||
                other.questionSubType == questionSubType) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.questionTranslation, questionTranslation) ||
                other.questionTranslation == questionTranslation) &&
            const DeepCollectionEquality().equals(other._choices, _choices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      questionCategory,
      questionSubType,
      difficulty,
      questionText,
      questionTranslation,
      const DeepCollectionEquality().hash(_choices));

  /// Create a copy of Part5QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part5QuestionModelImplCopyWith<_$Part5QuestionModelImpl> get copyWith =>
      __$$Part5QuestionModelImplCopyWithImpl<_$Part5QuestionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part5QuestionModelImplToJson(
      this,
    );
  }
}

abstract class _Part5QuestionModel implements Part5QuestionModel {
  const factory _Part5QuestionModel(
      {required final String id,
      required final String questionCategory,
      required final String questionSubType,
      required final String difficulty,
      required final String questionText,
      required final String questionTranslation,
      required final List<ChoiceModel> choices}) = _$Part5QuestionModelImpl;

  factory _Part5QuestionModel.fromJson(Map<String, dynamic> json) =
      _$Part5QuestionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get questionCategory;
  @override
  String get questionSubType;
  @override
  String get difficulty;
  @override
  String get questionText;
  @override
  String get questionTranslation;
  @override
  List<ChoiceModel> get choices;

  /// Create a copy of Part5QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part5QuestionModelImplCopyWith<_$Part5QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part5QuestionsData _$Part5QuestionsDataFromJson(Map<String, dynamic> json) {
  return _Part5QuestionsData.fromJson(json);
}

/// @nodoc
mixin _$Part5QuestionsData {
  List<Part5QuestionModel> get questions => throw _privateConstructorUsedError;

  /// Serializes this Part5QuestionsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part5QuestionsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part5QuestionsDataCopyWith<Part5QuestionsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part5QuestionsDataCopyWith<$Res> {
  factory $Part5QuestionsDataCopyWith(
          Part5QuestionsData value, $Res Function(Part5QuestionsData) then) =
      _$Part5QuestionsDataCopyWithImpl<$Res, Part5QuestionsData>;
  @useResult
  $Res call({List<Part5QuestionModel> questions});
}

/// @nodoc
class _$Part5QuestionsDataCopyWithImpl<$Res, $Val extends Part5QuestionsData>
    implements $Part5QuestionsDataCopyWith<$Res> {
  _$Part5QuestionsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part5QuestionsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
  }) {
    return _then(_value.copyWith(
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part5QuestionModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part5QuestionsDataImplCopyWith<$Res>
    implements $Part5QuestionsDataCopyWith<$Res> {
  factory _$$Part5QuestionsDataImplCopyWith(_$Part5QuestionsDataImpl value,
          $Res Function(_$Part5QuestionsDataImpl) then) =
      __$$Part5QuestionsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Part5QuestionModel> questions});
}

/// @nodoc
class __$$Part5QuestionsDataImplCopyWithImpl<$Res>
    extends _$Part5QuestionsDataCopyWithImpl<$Res, _$Part5QuestionsDataImpl>
    implements _$$Part5QuestionsDataImplCopyWith<$Res> {
  __$$Part5QuestionsDataImplCopyWithImpl(_$Part5QuestionsDataImpl _value,
      $Res Function(_$Part5QuestionsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part5QuestionsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
  }) {
    return _then(_$Part5QuestionsDataImpl(
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part5QuestionModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part5QuestionsDataImpl implements _Part5QuestionsData {
  const _$Part5QuestionsDataImpl(
      {required final List<Part5QuestionModel> questions})
      : _questions = questions;

  factory _$Part5QuestionsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part5QuestionsDataImplFromJson(json);

  final List<Part5QuestionModel> _questions;
  @override
  List<Part5QuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'Part5QuestionsData(questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part5QuestionsDataImpl &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_questions));

  /// Create a copy of Part5QuestionsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part5QuestionsDataImplCopyWith<_$Part5QuestionsDataImpl> get copyWith =>
      __$$Part5QuestionsDataImplCopyWithImpl<_$Part5QuestionsDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part5QuestionsDataImplToJson(
      this,
    );
  }
}

abstract class _Part5QuestionsData implements Part5QuestionsData {
  const factory _Part5QuestionsData(
          {required final List<Part5QuestionModel> questions}) =
      _$Part5QuestionsDataImpl;

  factory _Part5QuestionsData.fromJson(Map<String, dynamic> json) =
      _$Part5QuestionsDataImpl.fromJson;

  @override
  List<Part5QuestionModel> get questions;

  /// Create a copy of Part5QuestionsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part5QuestionsDataImplCopyWith<_$Part5QuestionsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part5QuestionsResponseModel _$Part5QuestionsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _Part5QuestionsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$Part5QuestionsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Part5QuestionsData get data => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this Part5QuestionsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part5QuestionsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part5QuestionsResponseModelCopyWith<Part5QuestionsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part5QuestionsResponseModelCopyWith<$Res> {
  factory $Part5QuestionsResponseModelCopyWith(
          Part5QuestionsResponseModel value,
          $Res Function(Part5QuestionsResponseModel) then) =
      _$Part5QuestionsResponseModelCopyWithImpl<$Res,
          Part5QuestionsResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String? message,
      Part5QuestionsData data,
      int count,
      int total,
      int page,
      int totalPages});

  $Part5QuestionsDataCopyWith<$Res> get data;
}

/// @nodoc
class _$Part5QuestionsResponseModelCopyWithImpl<$Res,
        $Val extends Part5QuestionsResponseModel>
    implements $Part5QuestionsResponseModelCopyWith<$Res> {
  _$Part5QuestionsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part5QuestionsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
    Object? count = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
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
              as Part5QuestionsData,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Part5QuestionsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Part5QuestionsDataCopyWith<$Res> get data {
    return $Part5QuestionsDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$Part5QuestionsResponseModelImplCopyWith<$Res>
    implements $Part5QuestionsResponseModelCopyWith<$Res> {
  factory _$$Part5QuestionsResponseModelImplCopyWith(
          _$Part5QuestionsResponseModelImpl value,
          $Res Function(_$Part5QuestionsResponseModelImpl) then) =
      __$$Part5QuestionsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String? message,
      Part5QuestionsData data,
      int count,
      int total,
      int page,
      int totalPages});

  @override
  $Part5QuestionsDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$Part5QuestionsResponseModelImplCopyWithImpl<$Res>
    extends _$Part5QuestionsResponseModelCopyWithImpl<$Res,
        _$Part5QuestionsResponseModelImpl>
    implements _$$Part5QuestionsResponseModelImplCopyWith<$Res> {
  __$$Part5QuestionsResponseModelImplCopyWithImpl(
      _$Part5QuestionsResponseModelImpl _value,
      $Res Function(_$Part5QuestionsResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part5QuestionsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
    Object? count = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
  }) {
    return _then(_$Part5QuestionsResponseModelImpl(
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
              as Part5QuestionsData,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part5QuestionsResponseModelImpl
    implements _Part5QuestionsResponseModel {
  const _$Part5QuestionsResponseModelImpl(
      {this.success = true,
      this.message,
      required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.totalPages});

  factory _$Part5QuestionsResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$Part5QuestionsResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  @override
  final Part5QuestionsData data;
  @override
  final int count;
  @override
  final int total;
  @override
  final int page;
  @override
  final int totalPages;

  @override
  String toString() {
    return 'Part5QuestionsResponseModel(success: $success, message: $message, data: $data, count: $count, total: $total, page: $page, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part5QuestionsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, data, count, total, page, totalPages);

  /// Create a copy of Part5QuestionsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part5QuestionsResponseModelImplCopyWith<_$Part5QuestionsResponseModelImpl>
      get copyWith => __$$Part5QuestionsResponseModelImplCopyWithImpl<
          _$Part5QuestionsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part5QuestionsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _Part5QuestionsResponseModel
    implements Part5QuestionsResponseModel {
  const factory _Part5QuestionsResponseModel(
      {final bool success,
      final String? message,
      required final Part5QuestionsData data,
      required final int count,
      required final int total,
      required final int page,
      required final int totalPages}) = _$Part5QuestionsResponseModelImpl;

  factory _Part5QuestionsResponseModel.fromJson(Map<String, dynamic> json) =
      _$Part5QuestionsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Part5QuestionsData get data;
  @override
  int get count;
  @override
  int get total;
  @override
  int get page;
  @override
  int get totalPages;

  /// Create a copy of Part5QuestionsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part5QuestionsResponseModelImplCopyWith<_$Part5QuestionsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part5AnswerModel _$Part5AnswerModelFromJson(Map<String, dynamic> json) {
  return _Part5AnswerModel.fromJson(json);
}

/// @nodoc
mixin _$Part5AnswerModel {
  String get id => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  List<VocabularyItemModel>? get vocabulary =>
      throw _privateConstructorUsedError;

  /// Serializes this Part5AnswerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part5AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part5AnswerModelCopyWith<Part5AnswerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part5AnswerModelCopyWith<$Res> {
  factory $Part5AnswerModelCopyWith(
          Part5AnswerModel value, $Res Function(Part5AnswerModel) then) =
      _$Part5AnswerModelCopyWithImpl<$Res, Part5AnswerModel>;
  @useResult
  $Res call(
      {String id,
      String answer,
      String explanation,
      List<VocabularyItemModel>? vocabulary});
}

/// @nodoc
class _$Part5AnswerModelCopyWithImpl<$Res, $Val extends Part5AnswerModel>
    implements $Part5AnswerModelCopyWith<$Res> {
  _$Part5AnswerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part5AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? answer = null,
    Object? explanation = null,
    Object? vocabulary = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      vocabulary: freezed == vocabulary
          ? _value.vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as List<VocabularyItemModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part5AnswerModelImplCopyWith<$Res>
    implements $Part5AnswerModelCopyWith<$Res> {
  factory _$$Part5AnswerModelImplCopyWith(_$Part5AnswerModelImpl value,
          $Res Function(_$Part5AnswerModelImpl) then) =
      __$$Part5AnswerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String answer,
      String explanation,
      List<VocabularyItemModel>? vocabulary});
}

/// @nodoc
class __$$Part5AnswerModelImplCopyWithImpl<$Res>
    extends _$Part5AnswerModelCopyWithImpl<$Res, _$Part5AnswerModelImpl>
    implements _$$Part5AnswerModelImplCopyWith<$Res> {
  __$$Part5AnswerModelImplCopyWithImpl(_$Part5AnswerModelImpl _value,
      $Res Function(_$Part5AnswerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part5AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? answer = null,
    Object? explanation = null,
    Object? vocabulary = freezed,
  }) {
    return _then(_$Part5AnswerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      vocabulary: freezed == vocabulary
          ? _value._vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as List<VocabularyItemModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part5AnswerModelImpl implements _Part5AnswerModel {
  const _$Part5AnswerModelImpl(
      {required this.id,
      required this.answer,
      required this.explanation,
      final List<VocabularyItemModel>? vocabulary})
      : _vocabulary = vocabulary;

  factory _$Part5AnswerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part5AnswerModelImplFromJson(json);

  @override
  final String id;
  @override
  final String answer;
  @override
  final String explanation;
  final List<VocabularyItemModel>? _vocabulary;
  @override
  List<VocabularyItemModel>? get vocabulary {
    final value = _vocabulary;
    if (value == null) return null;
    if (_vocabulary is EqualUnmodifiableListView) return _vocabulary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Part5AnswerModel(id: $id, answer: $answer, explanation: $explanation, vocabulary: $vocabulary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part5AnswerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            const DeepCollectionEquality()
                .equals(other._vocabulary, _vocabulary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, answer, explanation,
      const DeepCollectionEquality().hash(_vocabulary));

  /// Create a copy of Part5AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part5AnswerModelImplCopyWith<_$Part5AnswerModelImpl> get copyWith =>
      __$$Part5AnswerModelImplCopyWithImpl<_$Part5AnswerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part5AnswerModelImplToJson(
      this,
    );
  }
}

abstract class _Part5AnswerModel implements Part5AnswerModel {
  const factory _Part5AnswerModel(
      {required final String id,
      required final String answer,
      required final String explanation,
      final List<VocabularyItemModel>? vocabulary}) = _$Part5AnswerModelImpl;

  factory _Part5AnswerModel.fromJson(Map<String, dynamic> json) =
      _$Part5AnswerModelImpl.fromJson;

  @override
  String get id;
  @override
  String get answer;
  @override
  String get explanation;
  @override
  List<VocabularyItemModel>? get vocabulary;

  /// Create a copy of Part5AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part5AnswerModelImplCopyWith<_$Part5AnswerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part5AnswerResponseModel _$Part5AnswerResponseModelFromJson(
    Map<String, dynamic> json) {
  return _Part5AnswerResponseModel.fromJson(json);
}

/// @nodoc
mixin _$Part5AnswerResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Part5AnswerModel get data => throw _privateConstructorUsedError;

  /// Serializes this Part5AnswerResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part5AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part5AnswerResponseModelCopyWith<Part5AnswerResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part5AnswerResponseModelCopyWith<$Res> {
  factory $Part5AnswerResponseModelCopyWith(Part5AnswerResponseModel value,
          $Res Function(Part5AnswerResponseModel) then) =
      _$Part5AnswerResponseModelCopyWithImpl<$Res, Part5AnswerResponseModel>;
  @useResult
  $Res call({bool success, String? message, Part5AnswerModel data});

  $Part5AnswerModelCopyWith<$Res> get data;
}

/// @nodoc
class _$Part5AnswerResponseModelCopyWithImpl<$Res,
        $Val extends Part5AnswerResponseModel>
    implements $Part5AnswerResponseModelCopyWith<$Res> {
  _$Part5AnswerResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part5AnswerResponseModel
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
              as Part5AnswerModel,
    ) as $Val);
  }

  /// Create a copy of Part5AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Part5AnswerModelCopyWith<$Res> get data {
    return $Part5AnswerModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$Part5AnswerResponseModelImplCopyWith<$Res>
    implements $Part5AnswerResponseModelCopyWith<$Res> {
  factory _$$Part5AnswerResponseModelImplCopyWith(
          _$Part5AnswerResponseModelImpl value,
          $Res Function(_$Part5AnswerResponseModelImpl) then) =
      __$$Part5AnswerResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, Part5AnswerModel data});

  @override
  $Part5AnswerModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$Part5AnswerResponseModelImplCopyWithImpl<$Res>
    extends _$Part5AnswerResponseModelCopyWithImpl<$Res,
        _$Part5AnswerResponseModelImpl>
    implements _$$Part5AnswerResponseModelImplCopyWith<$Res> {
  __$$Part5AnswerResponseModelImplCopyWithImpl(
      _$Part5AnswerResponseModelImpl _value,
      $Res Function(_$Part5AnswerResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part5AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$Part5AnswerResponseModelImpl(
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
              as Part5AnswerModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part5AnswerResponseModelImpl implements _Part5AnswerResponseModel {
  const _$Part5AnswerResponseModelImpl(
      {this.success = true, this.message, required this.data});

  factory _$Part5AnswerResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part5AnswerResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  @override
  final Part5AnswerModel data;

  @override
  String toString() {
    return 'Part5AnswerResponseModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part5AnswerResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  /// Create a copy of Part5AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part5AnswerResponseModelImplCopyWith<_$Part5AnswerResponseModelImpl>
      get copyWith => __$$Part5AnswerResponseModelImplCopyWithImpl<
          _$Part5AnswerResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part5AnswerResponseModelImplToJson(
      this,
    );
  }
}

abstract class _Part5AnswerResponseModel implements Part5AnswerResponseModel {
  const factory _Part5AnswerResponseModel(
      {final bool success,
      final String? message,
      required final Part5AnswerModel data}) = _$Part5AnswerResponseModelImpl;

  factory _Part5AnswerResponseModel.fromJson(Map<String, dynamic> json) =
      _$Part5AnswerResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Part5AnswerModel get data;

  /// Create a copy of Part5AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part5AnswerResponseModelImplCopyWith<_$Part5AnswerResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VocabularyItemModel _$VocabularyItemModelFromJson(Map<String, dynamic> json) {
  return _VocabularyItemModel.fromJson(json);
}

/// @nodoc
mixin _$VocabularyItemModel {
  String get word => throw _privateConstructorUsedError;
  String get meaning => throw _privateConstructorUsedError;
  String get partOfSpeech => throw _privateConstructorUsedError;
  String get example => throw _privateConstructorUsedError;
  String get exampleTranslation => throw _privateConstructorUsedError;

  /// Serializes this VocabularyItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VocabularyItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabularyItemModelCopyWith<VocabularyItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyItemModelCopyWith<$Res> {
  factory $VocabularyItemModelCopyWith(
          VocabularyItemModel value, $Res Function(VocabularyItemModel) then) =
      _$VocabularyItemModelCopyWithImpl<$Res, VocabularyItemModel>;
  @useResult
  $Res call(
      {String word,
      String meaning,
      String partOfSpeech,
      String example,
      String exampleTranslation});
}

/// @nodoc
class _$VocabularyItemModelCopyWithImpl<$Res, $Val extends VocabularyItemModel>
    implements $VocabularyItemModelCopyWith<$Res> {
  _$VocabularyItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabularyItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? meaning = null,
    Object? partOfSpeech = null,
    Object? example = null,
    Object? exampleTranslation = null,
  }) {
    return _then(_value.copyWith(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _value.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      partOfSpeech: null == partOfSpeech
          ? _value.partOfSpeech
          : partOfSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      example: null == example
          ? _value.example
          : example // ignore: cast_nullable_to_non_nullable
              as String,
      exampleTranslation: null == exampleTranslation
          ? _value.exampleTranslation
          : exampleTranslation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VocabularyItemModelImplCopyWith<$Res>
    implements $VocabularyItemModelCopyWith<$Res> {
  factory _$$VocabularyItemModelImplCopyWith(_$VocabularyItemModelImpl value,
          $Res Function(_$VocabularyItemModelImpl) then) =
      __$$VocabularyItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String word,
      String meaning,
      String partOfSpeech,
      String example,
      String exampleTranslation});
}

/// @nodoc
class __$$VocabularyItemModelImplCopyWithImpl<$Res>
    extends _$VocabularyItemModelCopyWithImpl<$Res, _$VocabularyItemModelImpl>
    implements _$$VocabularyItemModelImplCopyWith<$Res> {
  __$$VocabularyItemModelImplCopyWithImpl(_$VocabularyItemModelImpl _value,
      $Res Function(_$VocabularyItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VocabularyItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? meaning = null,
    Object? partOfSpeech = null,
    Object? example = null,
    Object? exampleTranslation = null,
  }) {
    return _then(_$VocabularyItemModelImpl(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _value.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      partOfSpeech: null == partOfSpeech
          ? _value.partOfSpeech
          : partOfSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      example: null == example
          ? _value.example
          : example // ignore: cast_nullable_to_non_nullable
              as String,
      exampleTranslation: null == exampleTranslation
          ? _value.exampleTranslation
          : exampleTranslation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabularyItemModelImpl implements _VocabularyItemModel {
  const _$VocabularyItemModelImpl(
      {required this.word,
      required this.meaning,
      required this.partOfSpeech,
      required this.example,
      required this.exampleTranslation});

  factory _$VocabularyItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabularyItemModelImplFromJson(json);

  @override
  final String word;
  @override
  final String meaning;
  @override
  final String partOfSpeech;
  @override
  final String example;
  @override
  final String exampleTranslation;

  @override
  String toString() {
    return 'VocabularyItemModel(word: $word, meaning: $meaning, partOfSpeech: $partOfSpeech, example: $example, exampleTranslation: $exampleTranslation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyItemModelImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                other.partOfSpeech == partOfSpeech) &&
            (identical(other.example, example) || other.example == example) &&
            (identical(other.exampleTranslation, exampleTranslation) ||
                other.exampleTranslation == exampleTranslation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, word, meaning, partOfSpeech, example, exampleTranslation);

  /// Create a copy of VocabularyItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyItemModelImplCopyWith<_$VocabularyItemModelImpl> get copyWith =>
      __$$VocabularyItemModelImplCopyWithImpl<_$VocabularyItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabularyItemModelImplToJson(
      this,
    );
  }
}

abstract class _VocabularyItemModel implements VocabularyItemModel {
  const factory _VocabularyItemModel(
      {required final String word,
      required final String meaning,
      required final String partOfSpeech,
      required final String example,
      required final String exampleTranslation}) = _$VocabularyItemModelImpl;

  factory _VocabularyItemModel.fromJson(Map<String, dynamic> json) =
      _$VocabularyItemModelImpl.fromJson;

  @override
  String get word;
  @override
  String get meaning;
  @override
  String get partOfSpeech;
  @override
  String get example;
  @override
  String get exampleTranslation;

  /// Create a copy of VocabularyItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyItemModelImplCopyWith<_$VocabularyItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
