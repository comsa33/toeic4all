// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Part5QuestionModel _$Part5QuestionModelFromJson(Map<String, dynamic> json) {
  return _Part5QuestionModel.fromJson(json);
}

/// @nodoc
mixin _$Part5QuestionModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<ChoiceModel> get choices => throw _privateConstructorUsedError;
  int get correctAnswer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
      String text,
      List<ChoiceModel> choices,
      int correctAnswer,
      String explanation,
      String difficulty,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
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
    Object? text = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? difficulty = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      String text,
      List<ChoiceModel> choices,
      int correctAnswer,
      String explanation,
      String difficulty,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
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
    Object? text = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? difficulty = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$Part5QuestionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part5QuestionModelImpl implements _Part5QuestionModel {
  const _$Part5QuestionModelImpl(
      {required this.id,
      required this.text,
      required final List<ChoiceModel> choices,
      required this.correctAnswer,
      required this.explanation,
      required this.difficulty,
      final List<String> tags = const [],
      this.createdAt,
      this.updatedAt})
      : _choices = choices,
        _tags = tags;

  factory _$Part5QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part5QuestionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  final List<ChoiceModel> _choices;
  @override
  List<ChoiceModel> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  final int correctAnswer;
  @override
  final String explanation;
  @override
  final String difficulty;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Part5QuestionModel(id: $id, text: $text, choices: $choices, correctAnswer: $correctAnswer, explanation: $explanation, difficulty: $difficulty, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part5QuestionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      text,
      const DeepCollectionEquality().hash(_choices),
      correctAnswer,
      explanation,
      difficulty,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt);

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
      required final String text,
      required final List<ChoiceModel> choices,
      required final int correctAnswer,
      required final String explanation,
      required final String difficulty,
      final List<String> tags,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$Part5QuestionModelImpl;

  factory _Part5QuestionModel.fromJson(Map<String, dynamic> json) =
      _$Part5QuestionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  List<ChoiceModel> get choices;
  @override
  int get correctAnswer;
  @override
  String get explanation;
  @override
  String get difficulty;
  @override
  List<String> get tags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Part5QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part5QuestionModelImplCopyWith<_$Part5QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part6QuestionSetModel _$Part6QuestionSetModelFromJson(
    Map<String, dynamic> json) {
  return _Part6QuestionSetModel.fromJson(json);
}

/// @nodoc
mixin _$Part6QuestionSetModel {
  String get id => throw _privateConstructorUsedError;
  String get passage => throw _privateConstructorUsedError;
  List<Part6QuestionModel> get questions => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Part6QuestionSetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part6QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part6QuestionSetModelCopyWith<Part6QuestionSetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part6QuestionSetModelCopyWith<$Res> {
  factory $Part6QuestionSetModelCopyWith(Part6QuestionSetModel value,
          $Res Function(Part6QuestionSetModel) then) =
      _$Part6QuestionSetModelCopyWithImpl<$Res, Part6QuestionSetModel>;
  @useResult
  $Res call(
      {String id,
      String passage,
      List<Part6QuestionModel> questions,
      String difficulty,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$Part6QuestionSetModelCopyWithImpl<$Res,
        $Val extends Part6QuestionSetModel>
    implements $Part6QuestionSetModelCopyWith<$Res> {
  _$Part6QuestionSetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part6QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? passage = null,
    Object? questions = null,
    Object? difficulty = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      passage: null == passage
          ? _value.passage
          : passage // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part6QuestionModel>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part6QuestionSetModelImplCopyWith<$Res>
    implements $Part6QuestionSetModelCopyWith<$Res> {
  factory _$$Part6QuestionSetModelImplCopyWith(
          _$Part6QuestionSetModelImpl value,
          $Res Function(_$Part6QuestionSetModelImpl) then) =
      __$$Part6QuestionSetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String passage,
      List<Part6QuestionModel> questions,
      String difficulty,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$Part6QuestionSetModelImplCopyWithImpl<$Res>
    extends _$Part6QuestionSetModelCopyWithImpl<$Res,
        _$Part6QuestionSetModelImpl>
    implements _$$Part6QuestionSetModelImplCopyWith<$Res> {
  __$$Part6QuestionSetModelImplCopyWithImpl(_$Part6QuestionSetModelImpl _value,
      $Res Function(_$Part6QuestionSetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part6QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? passage = null,
    Object? questions = null,
    Object? difficulty = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$Part6QuestionSetModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      passage: null == passage
          ? _value.passage
          : passage // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part6QuestionModel>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6QuestionSetModelImpl implements _Part6QuestionSetModel {
  const _$Part6QuestionSetModelImpl(
      {required this.id,
      required this.passage,
      required final List<Part6QuestionModel> questions,
      required this.difficulty,
      final List<String> tags = const [],
      this.createdAt,
      this.updatedAt})
      : _questions = questions,
        _tags = tags;

  factory _$Part6QuestionSetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6QuestionSetModelImplFromJson(json);

  @override
  final String id;
  @override
  final String passage;
  final List<Part6QuestionModel> _questions;
  @override
  List<Part6QuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final String difficulty;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Part6QuestionSetModel(id: $id, passage: $passage, questions: $questions, difficulty: $difficulty, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6QuestionSetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.passage, passage) || other.passage == passage) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      passage,
      const DeepCollectionEquality().hash(_questions),
      difficulty,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt);

  /// Create a copy of Part6QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part6QuestionSetModelImplCopyWith<_$Part6QuestionSetModelImpl>
      get copyWith => __$$Part6QuestionSetModelImplCopyWithImpl<
          _$Part6QuestionSetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part6QuestionSetModelImplToJson(
      this,
    );
  }
}

abstract class _Part6QuestionSetModel implements Part6QuestionSetModel {
  const factory _Part6QuestionSetModel(
      {required final String id,
      required final String passage,
      required final List<Part6QuestionModel> questions,
      required final String difficulty,
      final List<String> tags,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$Part6QuestionSetModelImpl;

  factory _Part6QuestionSetModel.fromJson(Map<String, dynamic> json) =
      _$Part6QuestionSetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get passage;
  @override
  List<Part6QuestionModel> get questions;
  @override
  String get difficulty;
  @override
  List<String> get tags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Part6QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6QuestionSetModelImplCopyWith<_$Part6QuestionSetModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part6QuestionModel _$Part6QuestionModelFromJson(Map<String, dynamic> json) {
  return _Part6QuestionModel.fromJson(json);
}

/// @nodoc
mixin _$Part6QuestionModel {
  int get questionNumber => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<ChoiceModel> get choices => throw _privateConstructorUsedError;
  int get correctAnswer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;

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
      {int questionNumber,
      String text,
      List<ChoiceModel> choices,
      int correctAnswer,
      String explanation});
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
    Object? questionNumber = null,
    Object? text = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
  }) {
    return _then(_value.copyWith(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
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
      {int questionNumber,
      String text,
      List<ChoiceModel> choices,
      int correctAnswer,
      String explanation});
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
    Object? questionNumber = null,
    Object? text = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
  }) {
    return _then(_$Part6QuestionModelImpl(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part6QuestionModelImpl implements _Part6QuestionModel {
  const _$Part6QuestionModelImpl(
      {required this.questionNumber,
      required this.text,
      required final List<ChoiceModel> choices,
      required this.correctAnswer,
      required this.explanation})
      : _choices = choices;

  factory _$Part6QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part6QuestionModelImplFromJson(json);

  @override
  final int questionNumber;
  @override
  final String text;
  final List<ChoiceModel> _choices;
  @override
  List<ChoiceModel> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  final int correctAnswer;
  @override
  final String explanation;

  @override
  String toString() {
    return 'Part6QuestionModel(questionNumber: $questionNumber, text: $text, choices: $choices, correctAnswer: $correctAnswer, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part6QuestionModelImpl &&
            (identical(other.questionNumber, questionNumber) ||
                other.questionNumber == questionNumber) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionNumber,
      text,
      const DeepCollectionEquality().hash(_choices),
      correctAnswer,
      explanation);

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
      {required final int questionNumber,
      required final String text,
      required final List<ChoiceModel> choices,
      required final int correctAnswer,
      required final String explanation}) = _$Part6QuestionModelImpl;

  factory _Part6QuestionModel.fromJson(Map<String, dynamic> json) =
      _$Part6QuestionModelImpl.fromJson;

  @override
  int get questionNumber;
  @override
  String get text;
  @override
  List<ChoiceModel> get choices;
  @override
  int get correctAnswer;
  @override
  String get explanation;

  /// Create a copy of Part6QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part6QuestionModelImplCopyWith<_$Part6QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part7QuestionSetModel _$Part7QuestionSetModelFromJson(
    Map<String, dynamic> json) {
  return _Part7QuestionSetModel.fromJson(json);
}

/// @nodoc
mixin _$Part7QuestionSetModel {
  String get id => throw _privateConstructorUsedError;
  String get passage => throw _privateConstructorUsedError;
  List<Part7QuestionModel> get questions => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Part7QuestionSetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7QuestionSetModelCopyWith<Part7QuestionSetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7QuestionSetModelCopyWith<$Res> {
  factory $Part7QuestionSetModelCopyWith(Part7QuestionSetModel value,
          $Res Function(Part7QuestionSetModel) then) =
      _$Part7QuestionSetModelCopyWithImpl<$Res, Part7QuestionSetModel>;
  @useResult
  $Res call(
      {String id,
      String passage,
      List<Part7QuestionModel> questions,
      String difficulty,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$Part7QuestionSetModelCopyWithImpl<$Res,
        $Val extends Part7QuestionSetModel>
    implements $Part7QuestionSetModelCopyWith<$Res> {
  _$Part7QuestionSetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? passage = null,
    Object? questions = null,
    Object? difficulty = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      passage: null == passage
          ? _value.passage
          : passage // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part7QuestionModel>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7QuestionSetModelImplCopyWith<$Res>
    implements $Part7QuestionSetModelCopyWith<$Res> {
  factory _$$Part7QuestionSetModelImplCopyWith(
          _$Part7QuestionSetModelImpl value,
          $Res Function(_$Part7QuestionSetModelImpl) then) =
      __$$Part7QuestionSetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String passage,
      List<Part7QuestionModel> questions,
      String difficulty,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$Part7QuestionSetModelImplCopyWithImpl<$Res>
    extends _$Part7QuestionSetModelCopyWithImpl<$Res,
        _$Part7QuestionSetModelImpl>
    implements _$$Part7QuestionSetModelImplCopyWith<$Res> {
  __$$Part7QuestionSetModelImplCopyWithImpl(_$Part7QuestionSetModelImpl _value,
      $Res Function(_$Part7QuestionSetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? passage = null,
    Object? questions = null,
    Object? difficulty = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$Part7QuestionSetModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      passage: null == passage
          ? _value.passage
          : passage // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part7QuestionModel>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7QuestionSetModelImpl implements _Part7QuestionSetModel {
  const _$Part7QuestionSetModelImpl(
      {required this.id,
      required this.passage,
      required final List<Part7QuestionModel> questions,
      required this.difficulty,
      final List<String> tags = const [],
      this.createdAt,
      this.updatedAt})
      : _questions = questions,
        _tags = tags;

  factory _$Part7QuestionSetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7QuestionSetModelImplFromJson(json);

  @override
  final String id;
  @override
  final String passage;
  final List<Part7QuestionModel> _questions;
  @override
  List<Part7QuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final String difficulty;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Part7QuestionSetModel(id: $id, passage: $passage, questions: $questions, difficulty: $difficulty, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7QuestionSetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.passage, passage) || other.passage == passage) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      passage,
      const DeepCollectionEquality().hash(_questions),
      difficulty,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt);

  /// Create a copy of Part7QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7QuestionSetModelImplCopyWith<_$Part7QuestionSetModelImpl>
      get copyWith => __$$Part7QuestionSetModelImplCopyWithImpl<
          _$Part7QuestionSetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7QuestionSetModelImplToJson(
      this,
    );
  }
}

abstract class _Part7QuestionSetModel implements Part7QuestionSetModel {
  const factory _Part7QuestionSetModel(
      {required final String id,
      required final String passage,
      required final List<Part7QuestionModel> questions,
      required final String difficulty,
      final List<String> tags,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$Part7QuestionSetModelImpl;

  factory _Part7QuestionSetModel.fromJson(Map<String, dynamic> json) =
      _$Part7QuestionSetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get passage;
  @override
  List<Part7QuestionModel> get questions;
  @override
  String get difficulty;
  @override
  List<String> get tags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Part7QuestionSetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7QuestionSetModelImplCopyWith<_$Part7QuestionSetModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part7QuestionModel _$Part7QuestionModelFromJson(Map<String, dynamic> json) {
  return _Part7QuestionModel.fromJson(json);
}

/// @nodoc
mixin _$Part7QuestionModel {
  int get questionNumber => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<ChoiceModel> get choices => throw _privateConstructorUsedError;
  int get correctAnswer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;

  /// Serializes this Part7QuestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7QuestionModelCopyWith<Part7QuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7QuestionModelCopyWith<$Res> {
  factory $Part7QuestionModelCopyWith(
          Part7QuestionModel value, $Res Function(Part7QuestionModel) then) =
      _$Part7QuestionModelCopyWithImpl<$Res, Part7QuestionModel>;
  @useResult
  $Res call(
      {int questionNumber,
      String text,
      List<ChoiceModel> choices,
      int correctAnswer,
      String explanation});
}

/// @nodoc
class _$Part7QuestionModelCopyWithImpl<$Res, $Val extends Part7QuestionModel>
    implements $Part7QuestionModelCopyWith<$Res> {
  _$Part7QuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionNumber = null,
    Object? text = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
  }) {
    return _then(_value.copyWith(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7QuestionModelImplCopyWith<$Res>
    implements $Part7QuestionModelCopyWith<$Res> {
  factory _$$Part7QuestionModelImplCopyWith(_$Part7QuestionModelImpl value,
          $Res Function(_$Part7QuestionModelImpl) then) =
      __$$Part7QuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int questionNumber,
      String text,
      List<ChoiceModel> choices,
      int correctAnswer,
      String explanation});
}

/// @nodoc
class __$$Part7QuestionModelImplCopyWithImpl<$Res>
    extends _$Part7QuestionModelCopyWithImpl<$Res, _$Part7QuestionModelImpl>
    implements _$$Part7QuestionModelImplCopyWith<$Res> {
  __$$Part7QuestionModelImplCopyWithImpl(_$Part7QuestionModelImpl _value,
      $Res Function(_$Part7QuestionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionNumber = null,
    Object? text = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
  }) {
    return _then(_$Part7QuestionModelImpl(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceModel>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7QuestionModelImpl implements _Part7QuestionModel {
  const _$Part7QuestionModelImpl(
      {required this.questionNumber,
      required this.text,
      required final List<ChoiceModel> choices,
      required this.correctAnswer,
      required this.explanation})
      : _choices = choices;

  factory _$Part7QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7QuestionModelImplFromJson(json);

  @override
  final int questionNumber;
  @override
  final String text;
  final List<ChoiceModel> _choices;
  @override
  List<ChoiceModel> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  final int correctAnswer;
  @override
  final String explanation;

  @override
  String toString() {
    return 'Part7QuestionModel(questionNumber: $questionNumber, text: $text, choices: $choices, correctAnswer: $correctAnswer, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7QuestionModelImpl &&
            (identical(other.questionNumber, questionNumber) ||
                other.questionNumber == questionNumber) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionNumber,
      text,
      const DeepCollectionEquality().hash(_choices),
      correctAnswer,
      explanation);

  /// Create a copy of Part7QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7QuestionModelImplCopyWith<_$Part7QuestionModelImpl> get copyWith =>
      __$$Part7QuestionModelImplCopyWithImpl<_$Part7QuestionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7QuestionModelImplToJson(
      this,
    );
  }
}

abstract class _Part7QuestionModel implements Part7QuestionModel {
  const factory _Part7QuestionModel(
      {required final int questionNumber,
      required final String text,
      required final List<ChoiceModel> choices,
      required final int correctAnswer,
      required final String explanation}) = _$Part7QuestionModelImpl;

  factory _Part7QuestionModel.fromJson(Map<String, dynamic> json) =
      _$Part7QuestionModelImpl.fromJson;

  @override
  int get questionNumber;
  @override
  String get text;
  @override
  List<ChoiceModel> get choices;
  @override
  int get correctAnswer;
  @override
  String get explanation;

  /// Create a copy of Part7QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7QuestionModelImplCopyWith<_$Part7QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) {
  return _ChoiceModel.fromJson(json);
}

/// @nodoc
mixin _$ChoiceModel {
  String get text => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;

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
  $Res call({String text, String? explanation});
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
    Object? text = null,
    Object? explanation = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call({String text, String? explanation});
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
    Object? text = null,
    Object? explanation = freezed,
  }) {
    return _then(_$ChoiceModelImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChoiceModelImpl implements _ChoiceModel {
  const _$ChoiceModelImpl({required this.text, this.explanation});

  factory _$ChoiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChoiceModelImplFromJson(json);

  @override
  final String text;
  @override
  final String? explanation;

  @override
  String toString() {
    return 'ChoiceModel(text: $text, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoiceModelImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, explanation);

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
      {required final String text,
      final String? explanation}) = _$ChoiceModelImpl;

  factory _ChoiceModel.fromJson(Map<String, dynamic> json) =
      _$ChoiceModelImpl.fromJson;

  @override
  String get text;
  @override
  String? get explanation;

  /// Create a copy of ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChoiceModelImplCopyWith<_$ChoiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VocabularyModel _$VocabularyModelFromJson(Map<String, dynamic> json) {
  return _VocabularyModel.fromJson(json);
}

/// @nodoc
mixin _$VocabularyModel {
  String get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String get meaning => throw _privateConstructorUsedError;
  String get pronunciation => throw _privateConstructorUsedError;
  String get partOfSpeech => throw _privateConstructorUsedError;
  List<String> get examples => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  List<String> get synonyms => throw _privateConstructorUsedError;
  List<String> get antonyms => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this VocabularyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VocabularyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabularyModelCopyWith<VocabularyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyModelCopyWith<$Res> {
  factory $VocabularyModelCopyWith(
          VocabularyModel value, $Res Function(VocabularyModel) then) =
      _$VocabularyModelCopyWithImpl<$Res, VocabularyModel>;
  @useResult
  $Res call(
      {String id,
      String word,
      String meaning,
      String pronunciation,
      String partOfSpeech,
      List<String> examples,
      String difficulty,
      List<String> synonyms,
      List<String> antonyms,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$VocabularyModelCopyWithImpl<$Res, $Val extends VocabularyModel>
    implements $VocabularyModelCopyWith<$Res> {
  _$VocabularyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabularyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? meaning = null,
    Object? pronunciation = null,
    Object? partOfSpeech = null,
    Object? examples = null,
    Object? difficulty = null,
    Object? synonyms = null,
    Object? antonyms = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _value.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: null == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String,
      partOfSpeech: null == partOfSpeech
          ? _value.partOfSpeech
          : partOfSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<String>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      synonyms: null == synonyms
          ? _value.synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      antonyms: null == antonyms
          ? _value.antonyms
          : antonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VocabularyModelImplCopyWith<$Res>
    implements $VocabularyModelCopyWith<$Res> {
  factory _$$VocabularyModelImplCopyWith(_$VocabularyModelImpl value,
          $Res Function(_$VocabularyModelImpl) then) =
      __$$VocabularyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String word,
      String meaning,
      String pronunciation,
      String partOfSpeech,
      List<String> examples,
      String difficulty,
      List<String> synonyms,
      List<String> antonyms,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$VocabularyModelImplCopyWithImpl<$Res>
    extends _$VocabularyModelCopyWithImpl<$Res, _$VocabularyModelImpl>
    implements _$$VocabularyModelImplCopyWith<$Res> {
  __$$VocabularyModelImplCopyWithImpl(
      _$VocabularyModelImpl _value, $Res Function(_$VocabularyModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VocabularyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? meaning = null,
    Object? pronunciation = null,
    Object? partOfSpeech = null,
    Object? examples = null,
    Object? difficulty = null,
    Object? synonyms = null,
    Object? antonyms = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$VocabularyModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _value.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: null == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String,
      partOfSpeech: null == partOfSpeech
          ? _value.partOfSpeech
          : partOfSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value._examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<String>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      synonyms: null == synonyms
          ? _value._synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      antonyms: null == antonyms
          ? _value._antonyms
          : antonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabularyModelImpl implements _VocabularyModel {
  const _$VocabularyModelImpl(
      {required this.id,
      required this.word,
      required this.meaning,
      required this.pronunciation,
      required this.partOfSpeech,
      final List<String> examples = const [],
      required this.difficulty,
      final List<String> synonyms = const [],
      final List<String> antonyms = const [],
      this.createdAt,
      this.updatedAt})
      : _examples = examples,
        _synonyms = synonyms,
        _antonyms = antonyms;

  factory _$VocabularyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabularyModelImplFromJson(json);

  @override
  final String id;
  @override
  final String word;
  @override
  final String meaning;
  @override
  final String pronunciation;
  @override
  final String partOfSpeech;
  final List<String> _examples;
  @override
  @JsonKey()
  List<String> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  final String difficulty;
  final List<String> _synonyms;
  @override
  @JsonKey()
  List<String> get synonyms {
    if (_synonyms is EqualUnmodifiableListView) return _synonyms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_synonyms);
  }

  final List<String> _antonyms;
  @override
  @JsonKey()
  List<String> get antonyms {
    if (_antonyms is EqualUnmodifiableListView) return _antonyms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_antonyms);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'VocabularyModel(id: $id, word: $word, meaning: $meaning, pronunciation: $pronunciation, partOfSpeech: $partOfSpeech, examples: $examples, difficulty: $difficulty, synonyms: $synonyms, antonyms: $antonyms, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                other.partOfSpeech == partOfSpeech) &&
            const DeepCollectionEquality().equals(other._examples, _examples) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._synonyms, _synonyms) &&
            const DeepCollectionEquality().equals(other._antonyms, _antonyms) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      word,
      meaning,
      pronunciation,
      partOfSpeech,
      const DeepCollectionEquality().hash(_examples),
      difficulty,
      const DeepCollectionEquality().hash(_synonyms),
      const DeepCollectionEquality().hash(_antonyms),
      createdAt,
      updatedAt);

  /// Create a copy of VocabularyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyModelImplCopyWith<_$VocabularyModelImpl> get copyWith =>
      __$$VocabularyModelImplCopyWithImpl<_$VocabularyModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabularyModelImplToJson(
      this,
    );
  }
}

abstract class _VocabularyModel implements VocabularyModel {
  const factory _VocabularyModel(
      {required final String id,
      required final String word,
      required final String meaning,
      required final String pronunciation,
      required final String partOfSpeech,
      final List<String> examples,
      required final String difficulty,
      final List<String> synonyms,
      final List<String> antonyms,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$VocabularyModelImpl;

  factory _VocabularyModel.fromJson(Map<String, dynamic> json) =
      _$VocabularyModelImpl.fromJson;

  @override
  String get id;
  @override
  String get word;
  @override
  String get meaning;
  @override
  String get pronunciation;
  @override
  String get partOfSpeech;
  @override
  List<String> get examples;
  @override
  String get difficulty;
  @override
  List<String> get synonyms;
  @override
  List<String> get antonyms;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of VocabularyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyModelImplCopyWith<_$VocabularyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
