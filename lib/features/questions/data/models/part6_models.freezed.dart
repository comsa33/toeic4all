// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part6_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Part6SetModel _$Part6SetModelFromJson(Map<String, dynamic> json) {
  return _Part6SetModel.fromJson(json);
}

/// @nodoc
mixin _$Part6SetModel {
  String get id => throw _privateConstructorUsedError;
  String get passageType => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get passage => throw _privateConstructorUsedError;
  String get passageTranslation => throw _privateConstructorUsedError;
  List<Part6QuestionModel> get questions => throw _privateConstructorUsedError;

  /// Serializes this Part6SetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6SetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6SetModelCopyWith<Part6SetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6SetModelCopyWith<$Res> {
  factory $Part6SetModelCopyWith(
          Part6SetModel value, $Res Function(Part6SetModel) then) =
      _$Part6SetModelCopyWithImpl<$Res, Part6SetModel>;
  @useResult
  $Res call(
      {String id,
      String passageType,
      String difficulty,
      String passage,
      String passageTranslation,
      List<Part6QuestionModel> questions});
}

/// @nodoc
class _$Part6SetModelCopyWithImpl<$Res, $Val extends Part6SetModel>
    implements $Part6SetModelCopyWith<$Res> {
  _$Part6SetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6SetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? passageType = null,
    Object? difficulty = null,
    Object? passage = null,
    Object? passageTranslation = null,
    Object? questions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      passageType: null == passageType
          ? _value.passageType
          : passageType // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      passage: null == passage
          ? _value.passage
          : passage // ignore: cast_nullable_to_non_nullable
              as String,
      passageTranslation: null == passageTranslation
          ? _value.passageTranslation
          : passageTranslation // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part6QuestionModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part6SetModelImplCopyWith<$Res>
    implements $Part6SetModelCopyWith<$Res> {
  factory _$$Part6SetModelImplCopyWith(
          _$Part6SetModelImpl value, $Res Function(_$Part6SetModelImpl) then) =
      __$$Part6SetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String passageType,
      String difficulty,
      String passage,
      String passageTranslation,
      List<Part6QuestionModel> questions});
}

/// @nodoc
class __$$Part6SetModelImplCopyWithImpl<$Res>
    extends _$Part6SetModelCopyWithImpl<$Res, _$Part6SetModelImpl>
    implements _$$Part6SetModelImplCopyWith<$Res> {
  __$$Part6SetModelImplCopyWithImpl(
      _$Part6SetModelImpl _value, $Res Function(_$Part6SetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6SetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? passageType = null,
    Object? difficulty = null,
    Object? passage = null,
    Object? passageTranslation = null,
    Object? questions = null,
  }) {
    return _then(_$Part6SetModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      passageType: null == passageType
          ? _value.passageType
          : passageType // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      passage: null == passage
          ? _value.passage
          : passage // ignore: cast_nullable_to_non_nullable
              as String,
      passageTranslation: null == passageTranslation
          ? _value.passageTranslation
          : passageTranslation // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part6QuestionModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6SetModelImpl implements _Part6SetModel {
  const _$Part6SetModelImpl(
      {required this.id,
      required this.passageType,
      required this.difficulty,
      required this.passage,
      required this.passageTranslation,
      required final List<Part6QuestionModel> questions})
      : _questions = questions;

  factory _$Part6SetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6SetModelImplFromJson(json);

  @override
  final String id;
  @override
  final String passageType;
  @override
  final String difficulty;
  @override
  final String passage;
  @override
  final String passageTranslation;
  final List<Part6QuestionModel> _questions;
  @override
  List<Part6QuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'Part6SetModel(id: $id, passageType: $passageType, difficulty: $difficulty, passage: $passage, passageTranslation: $passageTranslation, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6SetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.passageType, passageType) ||
                other.passageType == passageType) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.passage, passage) || other.passage == passage) &&
            (identical(other.passageTranslation, passageTranslation) ||
                other.passageTranslation == passageTranslation) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      passageType,
      difficulty,
      passage,
      passageTranslation,
      const DeepCollectionEquality().hash(_questions));

  /// Create a copy of Part6SetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6SetModelImplCopyWith<_$Part6SetModelImpl> get copyWith =>
      __$$Part6SetModelImplCopyWithImpl<_$Part6SetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6SetModelImplToJson(
      this,
    );
  }
}

abstract class _Part6SetModel implements Part6SetModel {
  const factory _Part6SetModel(
      {required final String id,
      required final String passageType,
      required final String difficulty,
      required final String passage,
      required final String passageTranslation,
      required final List<Part6QuestionModel> questions}) = _$Part6SetModelImpl;

  factory _Part6SetModel.fromJson(Map<String, dynamic> json) =
      _$Part6SetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get passageType;
  @override
  String get difficulty;
  @override
  String get passage;
  @override
  String get passageTranslation;
  @override
  List<Part6QuestionModel> get questions;

  /// Create a copy of Part6SetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6SetModelImplCopyWith<_$Part6SetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part6QuestionModel _$Part6QuestionModelFromJson(Map<String, dynamic> json) {
  return _Part6QuestionModel.fromJson(json);
}

/// @nodoc
mixin _$Part6QuestionModel {
  int get blankNumber => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  List<Part6ChoiceModel> get choices => throw _privateConstructorUsedError;

  /// Serializes this Part6QuestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6QuestionModelCopyWith<Part6QuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6QuestionModelCopyWith<$Res> {
  factory $Part6QuestionModelCopyWith(
          Part6QuestionModel value, $Res Function(Part6QuestionModel) then) =
      _$Part6QuestionModelCopyWithImpl<$Res, Part6QuestionModel>;
  @useResult
  $Res call(
      {int blankNumber, String questionType, List<Part6ChoiceModel> choices});
}

/// @nodoc
class _$Part6QuestionModelCopyWithImpl<$Res, $Val extends Part6QuestionModel>
    implements $Part6QuestionModelCopyWith<$Res> {
  _$Part6QuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blankNumber = null,
    Object? questionType = null,
    Object? choices = null,
  }) {
    return _then(_value.copyWith(
      blankNumber: null == blankNumber
          ? _value.blankNumber
          : blankNumber // ignore: cast_nullable_to_non_nullable
              as int,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<Part6ChoiceModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part6QuestionModelImplCopyWith<$Res>
    implements $Part6QuestionModelCopyWith<$Res> {
  factory _$$Part6QuestionModelImplCopyWith(_$Part6QuestionModelImpl value,
          $Res Function(_$Part6QuestionModelImpl) then) =
      __$$Part6QuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int blankNumber, String questionType, List<Part6ChoiceModel> choices});
}

/// @nodoc
class __$$Part6QuestionModelImplCopyWithImpl<$Res>
    extends _$Part6QuestionModelCopyWithImpl<$Res, _$Part6QuestionModelImpl>
    implements _$$Part6QuestionModelImplCopyWith<$Res> {
  __$$Part6QuestionModelImplCopyWithImpl(_$Part6QuestionModelImpl _value,
      $Res Function(_$Part6QuestionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blankNumber = null,
    Object? questionType = null,
    Object? choices = null,
  }) {
    return _then(_$Part6QuestionModelImpl(
      blankNumber: null == blankNumber
          ? _value.blankNumber
          : blankNumber // ignore: cast_nullable_to_non_nullable
              as int,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<Part6ChoiceModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6QuestionModelImpl implements _Part6QuestionModel {
  const _$Part6QuestionModelImpl(
      {required this.blankNumber,
      required this.questionType,
      required final List<Part6ChoiceModel> choices})
      : _choices = choices;

  factory _$Part6QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6QuestionModelImplFromJson(json);

  @override
  final int blankNumber;
  @override
  final String questionType;
  final List<Part6ChoiceModel> _choices;
  @override
  List<Part6ChoiceModel> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  String toString() {
    return 'Part6QuestionModel(blankNumber: $blankNumber, questionType: $questionType, choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6QuestionModelImpl &&
            (identical(other.blankNumber, blankNumber) ||
                other.blankNumber == blankNumber) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            const DeepCollectionEquality().equals(other._choices, _choices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, blankNumber, questionType,
      const DeepCollectionEquality().hash(_choices));

  /// Create a copy of Part6QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6QuestionModelImplCopyWith<_$Part6QuestionModelImpl> get copyWith =>
      __$$Part6QuestionModelImplCopyWithImpl<_$Part6QuestionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6QuestionModelImplToJson(
      this,
    );
  }
}

abstract class _Part6QuestionModel implements Part6QuestionModel {
  const factory _Part6QuestionModel(
          {required final int blankNumber,
          required final String questionType,
          required final List<Part6ChoiceModel> choices}) =
      _$Part6QuestionModelImpl;

  factory _Part6QuestionModel.fromJson(Map<String, dynamic> json) =
      _$Part6QuestionModelImpl.fromJson;

  @override
  int get blankNumber;
  @override
  String get questionType;
  @override
  List<Part6ChoiceModel> get choices;

  /// Create a copy of Part6QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6QuestionModelImplCopyWith<_$Part6QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part6ChoiceModel _$Part6ChoiceModelFromJson(Map<String, dynamic> json) {
  return _Part6ChoiceModel.fromJson(json);
}

/// @nodoc
mixin _$Part6ChoiceModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  /// Serializes this Part6ChoiceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6ChoiceModelCopyWith<Part6ChoiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6ChoiceModelCopyWith<$Res> {
  factory $Part6ChoiceModelCopyWith(
          Part6ChoiceModel value, $Res Function(Part6ChoiceModel) then) =
      _$Part6ChoiceModelCopyWithImpl<$Res, Part6ChoiceModel>;
  @useResult
  $Res call({String id, String text, String translation});
}

/// @nodoc
class _$Part6ChoiceModelCopyWithImpl<$Res, $Val extends Part6ChoiceModel>
    implements $Part6ChoiceModelCopyWith<$Res> {
  _$Part6ChoiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6ChoiceModel
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
abstract class _$$Part6ChoiceModelImplCopyWith<$Res>
    implements $Part6ChoiceModelCopyWith<$Res> {
  factory _$$Part6ChoiceModelImplCopyWith(_$Part6ChoiceModelImpl value,
          $Res Function(_$Part6ChoiceModelImpl) then) =
      __$$Part6ChoiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, String translation});
}

/// @nodoc
class __$$Part6ChoiceModelImplCopyWithImpl<$Res>
    extends _$Part6ChoiceModelCopyWithImpl<$Res, _$Part6ChoiceModelImpl>
    implements _$$Part6ChoiceModelImplCopyWith<$Res> {
  __$$Part6ChoiceModelImplCopyWithImpl(_$Part6ChoiceModelImpl _value,
      $Res Function(_$Part6ChoiceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? translation = null,
  }) {
    return _then(_$Part6ChoiceModelImpl(
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
class _$Part6ChoiceModelImpl implements _Part6ChoiceModel {
  const _$Part6ChoiceModelImpl(
      {required this.id, required this.text, required this.translation});

  factory _$Part6ChoiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6ChoiceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String translation;

  @override
  String toString() {
    return 'Part6ChoiceModel(id: $id, text: $text, translation: $translation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6ChoiceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, translation);

  /// Create a copy of Part6ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6ChoiceModelImplCopyWith<_$Part6ChoiceModelImpl> get copyWith =>
      __$$Part6ChoiceModelImplCopyWithImpl<_$Part6ChoiceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6ChoiceModelImplToJson(
      this,
    );
  }
}

abstract class _Part6ChoiceModel implements Part6ChoiceModel {
  const factory _Part6ChoiceModel(
      {required final String id,
      required final String text,
      required final String translation}) = _$Part6ChoiceModelImpl;

  factory _Part6ChoiceModel.fromJson(Map<String, dynamic> json) =
      _$Part6ChoiceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get translation;

  /// Create a copy of Part6ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6ChoiceModelImplCopyWith<_$Part6ChoiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part6SetsData _$Part6SetsDataFromJson(Map<String, dynamic> json) {
  return _Part6SetsData.fromJson(json);
}

/// @nodoc
mixin _$Part6SetsData {
  List<Part6SetModel> get sets => throw _privateConstructorUsedError;

  /// Serializes this Part6SetsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6SetsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6SetsDataCopyWith<Part6SetsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6SetsDataCopyWith<$Res> {
  factory $Part6SetsDataCopyWith(
          Part6SetsData value, $Res Function(Part6SetsData) then) =
      _$Part6SetsDataCopyWithImpl<$Res, Part6SetsData>;
  @useResult
  $Res call({List<Part6SetModel> sets});
}

/// @nodoc
class _$Part6SetsDataCopyWithImpl<$Res, $Val extends Part6SetsData>
    implements $Part6SetsDataCopyWith<$Res> {
  _$Part6SetsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6SetsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sets = null,
  }) {
    return _then(_value.copyWith(
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<Part6SetModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part6SetsDataImplCopyWith<$Res>
    implements $Part6SetsDataCopyWith<$Res> {
  factory _$$Part6SetsDataImplCopyWith(
          _$Part6SetsDataImpl value, $Res Function(_$Part6SetsDataImpl) then) =
      __$$Part6SetsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Part6SetModel> sets});
}

/// @nodoc
class __$$Part6SetsDataImplCopyWithImpl<$Res>
    extends _$Part6SetsDataCopyWithImpl<$Res, _$Part6SetsDataImpl>
    implements _$$Part6SetsDataImplCopyWith<$Res> {
  __$$Part6SetsDataImplCopyWithImpl(
      _$Part6SetsDataImpl _value, $Res Function(_$Part6SetsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6SetsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sets = null,
  }) {
    return _then(_$Part6SetsDataImpl(
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<Part6SetModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6SetsDataImpl implements _Part6SetsData {
  const _$Part6SetsDataImpl({required final List<Part6SetModel> sets})
      : _sets = sets;

  factory _$Part6SetsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6SetsDataImplFromJson(json);

  final List<Part6SetModel> _sets;
  @override
  List<Part6SetModel> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  String toString() {
    return 'Part6SetsData(sets: $sets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6SetsDataImpl &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sets));

  /// Create a copy of Part6SetsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6SetsDataImplCopyWith<_$Part6SetsDataImpl> get copyWith =>
      __$$Part6SetsDataImplCopyWithImpl<_$Part6SetsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6SetsDataImplToJson(
      this,
    );
  }
}

abstract class _Part6SetsData implements Part6SetsData {
  const factory _Part6SetsData({required final List<Part6SetModel> sets}) =
      _$Part6SetsDataImpl;

  factory _Part6SetsData.fromJson(Map<String, dynamic> json) =
      _$Part6SetsDataImpl.fromJson;

  @override
  List<Part6SetModel> get sets;

  /// Create a copy of Part6SetsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6SetsDataImplCopyWith<_$Part6SetsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part6SetsResponseModel _$Part6SetsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _Part6SetsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$Part6SetsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Part6SetsData get data => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this Part6SetsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6SetsResponseModelCopyWith<Part6SetsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6SetsResponseModelCopyWith<$Res> {
  factory $Part6SetsResponseModelCopyWith(Part6SetsResponseModel value,
          $Res Function(Part6SetsResponseModel) then) =
      _$Part6SetsResponseModelCopyWithImpl<$Res, Part6SetsResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String? message,
      Part6SetsData data,
      int count,
      int total,
      int page,
      @JsonKey(name: 'total_pages') int totalPages});

  $Part6SetsDataCopyWith<$Res> get data;
}

/// @nodoc
class _$Part6SetsResponseModelCopyWithImpl<$Res,
        $Val extends Part6SetsResponseModel>
    implements $Part6SetsResponseModelCopyWith<$Res> {
  _$Part6SetsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6SetsResponseModel
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
              as Part6SetsData,
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

  /// Create a copy of Part6SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Part6SetsDataCopyWith<$Res> get data {
    return $Part6SetsDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$Part6SetsResponseModelImplCopyWith<$Res>
    implements $Part6SetsResponseModelCopyWith<$Res> {
  factory _$$Part6SetsResponseModelImplCopyWith(
          _$Part6SetsResponseModelImpl value,
          $Res Function(_$Part6SetsResponseModelImpl) then) =
      __$$Part6SetsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String? message,
      Part6SetsData data,
      int count,
      int total,
      int page,
      @JsonKey(name: 'total_pages') int totalPages});

  @override
  $Part6SetsDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$Part6SetsResponseModelImplCopyWithImpl<$Res>
    extends _$Part6SetsResponseModelCopyWithImpl<$Res,
        _$Part6SetsResponseModelImpl>
    implements _$$Part6SetsResponseModelImplCopyWith<$Res> {
  __$$Part6SetsResponseModelImplCopyWithImpl(
      _$Part6SetsResponseModelImpl _value,
      $Res Function(_$Part6SetsResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6SetsResponseModel
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
    return _then(_$Part6SetsResponseModelImpl(
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
              as Part6SetsData,
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
class _$Part6SetsResponseModelImpl implements _Part6SetsResponseModel {
  const _$Part6SetsResponseModelImpl(
      {this.success = true,
      this.message,
      required this.data,
      required this.count,
      required this.total,
      required this.page,
      @JsonKey(name: 'total_pages') required this.totalPages});

  factory _$Part6SetsResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6SetsResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  @override
  final Part6SetsData data;
  @override
  final int count;
  @override
  final int total;
  @override
  final int page;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;

  @override
  String toString() {
    return 'Part6SetsResponseModel(success: $success, message: $message, data: $data, count: $count, total: $total, page: $page, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6SetsResponseModelImpl &&
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

  /// Create a copy of Part6SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6SetsResponseModelImplCopyWith<_$Part6SetsResponseModelImpl>
      get copyWith => __$$Part6SetsResponseModelImplCopyWithImpl<
          _$Part6SetsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6SetsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _Part6SetsResponseModel implements Part6SetsResponseModel {
  const factory _Part6SetsResponseModel(
          {final bool success,
          final String? message,
          required final Part6SetsData data,
          required final int count,
          required final int total,
          required final int page,
          @JsonKey(name: 'total_pages') required final int totalPages}) =
      _$Part6SetsResponseModelImpl;

  factory _Part6SetsResponseModel.fromJson(Map<String, dynamic> json) =
      _$Part6SetsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Part6SetsData get data;
  @override
  int get count;
  @override
  int get total;
  @override
  int get page;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;

  /// Create a copy of Part6SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6SetsResponseModelImplCopyWith<_$Part6SetsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part6AnswerData _$Part6AnswerDataFromJson(Map<String, dynamic> json) {
  return _Part6AnswerData.fromJson(json);
}

/// @nodoc
mixin _$Part6AnswerData {
  @JsonKey(name: 'set_id')
  String get setId => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_seq')
  int get questionSeq => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;

  /// Serializes this Part6AnswerData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6AnswerDataCopyWith<Part6AnswerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6AnswerDataCopyWith<$Res> {
  factory $Part6AnswerDataCopyWith(
          Part6AnswerData value, $Res Function(Part6AnswerData) then) =
      _$Part6AnswerDataCopyWithImpl<$Res, Part6AnswerData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'set_id') String setId,
      @JsonKey(name: 'question_seq') int questionSeq,
      String answer,
      String explanation});
}

/// @nodoc
class _$Part6AnswerDataCopyWithImpl<$Res, $Val extends Part6AnswerData>
    implements $Part6AnswerDataCopyWith<$Res> {
  _$Part6AnswerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? questionSeq = null,
    Object? answer = null,
    Object? explanation = null,
  }) {
    return _then(_value.copyWith(
      setId: null == setId
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as String,
      questionSeq: null == questionSeq
          ? _value.questionSeq
          : questionSeq // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part6AnswerDataImplCopyWith<$Res>
    implements $Part6AnswerDataCopyWith<$Res> {
  factory _$$Part6AnswerDataImplCopyWith(_$Part6AnswerDataImpl value,
          $Res Function(_$Part6AnswerDataImpl) then) =
      __$$Part6AnswerDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'set_id') String setId,
      @JsonKey(name: 'question_seq') int questionSeq,
      String answer,
      String explanation});
}

/// @nodoc
class __$$Part6AnswerDataImplCopyWithImpl<$Res>
    extends _$Part6AnswerDataCopyWithImpl<$Res, _$Part6AnswerDataImpl>
    implements _$$Part6AnswerDataImplCopyWith<$Res> {
  __$$Part6AnswerDataImplCopyWithImpl(
      _$Part6AnswerDataImpl _value, $Res Function(_$Part6AnswerDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? questionSeq = null,
    Object? answer = null,
    Object? explanation = null,
  }) {
    return _then(_$Part6AnswerDataImpl(
      setId: null == setId
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as String,
      questionSeq: null == questionSeq
          ? _value.questionSeq
          : questionSeq // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6AnswerDataImpl implements _Part6AnswerData {
  const _$Part6AnswerDataImpl(
      {@JsonKey(name: 'set_id') required this.setId,
      @JsonKey(name: 'question_seq') required this.questionSeq,
      required this.answer,
      required this.explanation});

  factory _$Part6AnswerDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6AnswerDataImplFromJson(json);

  @override
  @JsonKey(name: 'set_id')
  final String setId;
  @override
  @JsonKey(name: 'question_seq')
  final int questionSeq;
  @override
  final String answer;
  @override
  final String explanation;

  @override
  String toString() {
    return 'Part6AnswerData(setId: $setId, questionSeq: $questionSeq, answer: $answer, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6AnswerDataImpl &&
            (identical(other.setId, setId) || other.setId == setId) &&
            (identical(other.questionSeq, questionSeq) ||
                other.questionSeq == questionSeq) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, setId, questionSeq, answer, explanation);

  /// Create a copy of Part6AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6AnswerDataImplCopyWith<_$Part6AnswerDataImpl> get copyWith =>
      __$$Part6AnswerDataImplCopyWithImpl<_$Part6AnswerDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6AnswerDataImplToJson(
      this,
    );
  }
}

abstract class _Part6AnswerData implements Part6AnswerData {
  const factory _Part6AnswerData(
      {@JsonKey(name: 'set_id') required final String setId,
      @JsonKey(name: 'question_seq') required final int questionSeq,
      required final String answer,
      required final String explanation}) = _$Part6AnswerDataImpl;

  factory _Part6AnswerData.fromJson(Map<String, dynamic> json) =
      _$Part6AnswerDataImpl.fromJson;

  @override
  @JsonKey(name: 'set_id')
  String get setId;
  @override
  @JsonKey(name: 'question_seq')
  int get questionSeq;
  @override
  String get answer;
  @override
  String get explanation;

  /// Create a copy of Part6AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6AnswerDataImplCopyWith<_$Part6AnswerDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part6AnswerResponseModel _$Part6AnswerResponseModelFromJson(
    Map<String, dynamic> json) {
  return _Part6AnswerResponseModel.fromJson(json);
}

/// @nodoc
mixin _$Part6AnswerResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Part6AnswerData get data => throw _privateConstructorUsedError;

  /// Serializes this Part6AnswerResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6AnswerResponseModelCopyWith<Part6AnswerResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6AnswerResponseModelCopyWith<$Res> {
  factory $Part6AnswerResponseModelCopyWith(Part6AnswerResponseModel value,
          $Res Function(Part6AnswerResponseModel) then) =
      _$Part6AnswerResponseModelCopyWithImpl<$Res, Part6AnswerResponseModel>;
  @useResult
  $Res call({bool success, String? message, Part6AnswerData data});

  $Part6AnswerDataCopyWith<$Res> get data;
}

/// @nodoc
class _$Part6AnswerResponseModelCopyWithImpl<$Res,
        $Val extends Part6AnswerResponseModel>
    implements $Part6AnswerResponseModelCopyWith<$Res> {
  _$Part6AnswerResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6AnswerResponseModel
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
              as Part6AnswerData,
    ) as $Val);
  }

  /// Create a copy of Part6AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Part6AnswerDataCopyWith<$Res> get data {
    return $Part6AnswerDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$Part6AnswerResponseModelImplCopyWith<$Res>
    implements $Part6AnswerResponseModelCopyWith<$Res> {
  factory _$$Part6AnswerResponseModelImplCopyWith(
          _$Part6AnswerResponseModelImpl value,
          $Res Function(_$Part6AnswerResponseModelImpl) then) =
      __$$Part6AnswerResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, Part6AnswerData data});

  @override
  $Part6AnswerDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$Part6AnswerResponseModelImplCopyWithImpl<$Res>
    extends _$Part6AnswerResponseModelCopyWithImpl<$Res,
        _$Part6AnswerResponseModelImpl>
    implements _$$Part6AnswerResponseModelImplCopyWith<$Res> {
  __$$Part6AnswerResponseModelImplCopyWithImpl(
      _$Part6AnswerResponseModelImpl _value,
      $Res Function(_$Part6AnswerResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$Part6AnswerResponseModelImpl(
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
              as Part6AnswerData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6AnswerResponseModelImpl implements _Part6AnswerResponseModel {
  const _$Part6AnswerResponseModelImpl(
      {this.success = true, this.message, required this.data});

  factory _$Part6AnswerResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6AnswerResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  @override
  final Part6AnswerData data;

  @override
  String toString() {
    return 'Part6AnswerResponseModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6AnswerResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  /// Create a copy of Part6AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6AnswerResponseModelImplCopyWith<_$Part6AnswerResponseModelImpl>
      get copyWith => __$$Part6AnswerResponseModelImplCopyWithImpl<
          _$Part6AnswerResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6AnswerResponseModelImplToJson(
      this,
    );
  }
}

abstract class _Part6AnswerResponseModel implements Part6AnswerResponseModel {
  const factory _Part6AnswerResponseModel(
      {final bool success,
      final String? message,
      required final Part6AnswerData data}) = _$Part6AnswerResponseModelImpl;

  factory _Part6AnswerResponseModel.fromJson(Map<String, dynamic> json) =
      _$Part6AnswerResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Part6AnswerData get data;

  /// Create a copy of Part6AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6AnswerResponseModelImplCopyWith<_$Part6AnswerResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part6AnswerModel _$Part6AnswerModelFromJson(Map<String, dynamic> json) {
  return _Part6AnswerModel.fromJson(json);
}

/// @nodoc
mixin _$Part6AnswerModel {
  String get setId => throw _privateConstructorUsedError;
  int get questionSeq => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;

  /// Serializes this Part6AnswerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6AnswerModelCopyWith<Part6AnswerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6AnswerModelCopyWith<$Res> {
  factory $Part6AnswerModelCopyWith(
          Part6AnswerModel value, $Res Function(Part6AnswerModel) then) =
      _$Part6AnswerModelCopyWithImpl<$Res, Part6AnswerModel>;
  @useResult
  $Res call({String setId, int questionSeq, String answer, String explanation});
}

/// @nodoc
class _$Part6AnswerModelCopyWithImpl<$Res, $Val extends Part6AnswerModel>
    implements $Part6AnswerModelCopyWith<$Res> {
  _$Part6AnswerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? questionSeq = null,
    Object? answer = null,
    Object? explanation = null,
  }) {
    return _then(_value.copyWith(
      setId: null == setId
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as String,
      questionSeq: null == questionSeq
          ? _value.questionSeq
          : questionSeq // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part6AnswerModelImplCopyWith<$Res>
    implements $Part6AnswerModelCopyWith<$Res> {
  factory _$$Part6AnswerModelImplCopyWith(_$Part6AnswerModelImpl value,
          $Res Function(_$Part6AnswerModelImpl) then) =
      __$$Part6AnswerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String setId, int questionSeq, String answer, String explanation});
}

/// @nodoc
class __$$Part6AnswerModelImplCopyWithImpl<$Res>
    extends _$Part6AnswerModelCopyWithImpl<$Res, _$Part6AnswerModelImpl>
    implements _$$Part6AnswerModelImplCopyWith<$Res> {
  __$$Part6AnswerModelImplCopyWithImpl(_$Part6AnswerModelImpl _value,
      $Res Function(_$Part6AnswerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? questionSeq = null,
    Object? answer = null,
    Object? explanation = null,
  }) {
    return _then(_$Part6AnswerModelImpl(
      setId: null == setId
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as String,
      questionSeq: null == questionSeq
          ? _value.questionSeq
          : questionSeq // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6AnswerModelImpl implements _Part6AnswerModel {
  const _$Part6AnswerModelImpl(
      {required this.setId,
      required this.questionSeq,
      required this.answer,
      required this.explanation});

  factory _$Part6AnswerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6AnswerModelImplFromJson(json);

  @override
  final String setId;
  @override
  final int questionSeq;
  @override
  final String answer;
  @override
  final String explanation;

  @override
  String toString() {
    return 'Part6AnswerModel(setId: $setId, questionSeq: $questionSeq, answer: $answer, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6AnswerModelImpl &&
            (identical(other.setId, setId) || other.setId == setId) &&
            (identical(other.questionSeq, questionSeq) ||
                other.questionSeq == questionSeq) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, setId, questionSeq, answer, explanation);

  /// Create a copy of Part6AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6AnswerModelImplCopyWith<_$Part6AnswerModelImpl> get copyWith =>
      __$$Part6AnswerModelImplCopyWithImpl<_$Part6AnswerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6AnswerModelImplToJson(
      this,
    );
  }
}

abstract class _Part6AnswerModel implements Part6AnswerModel {
  const factory _Part6AnswerModel(
      {required final String setId,
      required final int questionSeq,
      required final String answer,
      required final String explanation}) = _$Part6AnswerModelImpl;

  factory _Part6AnswerModel.fromJson(Map<String, dynamic> json) =
      _$Part6AnswerModelImpl.fromJson;

  @override
  String get setId;
  @override
  int get questionSeq;
  @override
  String get answer;
  @override
  String get explanation;

  /// Create a copy of Part6AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6AnswerModelImplCopyWith<_$Part6AnswerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
