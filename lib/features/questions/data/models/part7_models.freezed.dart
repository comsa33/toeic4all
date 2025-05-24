// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part7_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Part7SetModel _$Part7SetModelFromJson(Map<String, dynamic> json) {
  return _Part7SetModel.fromJson(json);
}

/// @nodoc
mixin _$Part7SetModel {
  String get id => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get questionSetType => throw _privateConstructorUsedError;
  List<Part7PassageModel> get passages => throw _privateConstructorUsedError;
  List<Part7QuestionModel> get questions => throw _privateConstructorUsedError;

  /// Serializes this Part7SetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7SetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7SetModelCopyWith<Part7SetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7SetModelCopyWith<$Res> {
  factory $Part7SetModelCopyWith(
          Part7SetModel value, $Res Function(Part7SetModel) then) =
      _$Part7SetModelCopyWithImpl<$Res, Part7SetModel>;
  @useResult
  $Res call(
      {String id,
      String difficulty,
      String questionSetType,
      List<Part7PassageModel> passages,
      List<Part7QuestionModel> questions});
}

/// @nodoc
class _$Part7SetModelCopyWithImpl<$Res, $Val extends Part7SetModel>
    implements $Part7SetModelCopyWith<$Res> {
  _$Part7SetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7SetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? difficulty = null,
    Object? questionSetType = null,
    Object? passages = null,
    Object? questions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      questionSetType: null == questionSetType
          ? _value.questionSetType
          : questionSetType // ignore: cast_nullable_to_non_nullable
              as String,
      passages: null == passages
          ? _value.passages
          : passages // ignore: cast_nullable_to_non_nullable
              as List<Part7PassageModel>,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part7QuestionModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7SetModelImplCopyWith<$Res>
    implements $Part7SetModelCopyWith<$Res> {
  factory _$$Part7SetModelImplCopyWith(
          _$Part7SetModelImpl value, $Res Function(_$Part7SetModelImpl) then) =
      __$$Part7SetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String difficulty,
      String questionSetType,
      List<Part7PassageModel> passages,
      List<Part7QuestionModel> questions});
}

/// @nodoc
class __$$Part7SetModelImplCopyWithImpl<$Res>
    extends _$Part7SetModelCopyWithImpl<$Res, _$Part7SetModelImpl>
    implements _$$Part7SetModelImplCopyWith<$Res> {
  __$$Part7SetModelImplCopyWithImpl(
      _$Part7SetModelImpl _value, $Res Function(_$Part7SetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7SetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? difficulty = null,
    Object? questionSetType = null,
    Object? passages = null,
    Object? questions = null,
  }) {
    return _then(_$Part7SetModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      questionSetType: null == questionSetType
          ? _value.questionSetType
          : questionSetType // ignore: cast_nullable_to_non_nullable
              as String,
      passages: null == passages
          ? _value._passages
          : passages // ignore: cast_nullable_to_non_nullable
              as List<Part7PassageModel>,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Part7QuestionModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7SetModelImpl implements _Part7SetModel {
  const _$Part7SetModelImpl(
      {required this.id,
      required this.difficulty,
      required this.questionSetType,
      required final List<Part7PassageModel> passages,
      required final List<Part7QuestionModel> questions})
      : _passages = passages,
        _questions = questions;

  factory _$Part7SetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7SetModelImplFromJson(json);

  @override
  final String id;
  @override
  final String difficulty;
  @override
  final String questionSetType;
  final List<Part7PassageModel> _passages;
  @override
  List<Part7PassageModel> get passages {
    if (_passages is EqualUnmodifiableListView) return _passages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_passages);
  }

  final List<Part7QuestionModel> _questions;
  @override
  List<Part7QuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'Part7SetModel(id: $id, difficulty: $difficulty, questionSetType: $questionSetType, passages: $passages, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7SetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.questionSetType, questionSetType) ||
                other.questionSetType == questionSetType) &&
            const DeepCollectionEquality().equals(other._passages, _passages) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      difficulty,
      questionSetType,
      const DeepCollectionEquality().hash(_passages),
      const DeepCollectionEquality().hash(_questions));

  /// Create a copy of Part7SetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7SetModelImplCopyWith<_$Part7SetModelImpl> get copyWith =>
      __$$Part7SetModelImplCopyWithImpl<_$Part7SetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7SetModelImplToJson(
      this,
    );
  }
}

abstract class _Part7SetModel implements Part7SetModel {
  const factory _Part7SetModel(
      {required final String id,
      required final String difficulty,
      required final String questionSetType,
      required final List<Part7PassageModel> passages,
      required final List<Part7QuestionModel> questions}) = _$Part7SetModelImpl;

  factory _Part7SetModel.fromJson(Map<String, dynamic> json) =
      _$Part7SetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get difficulty;
  @override
  String get questionSetType;
  @override
  List<Part7PassageModel> get passages;
  @override
  List<Part7QuestionModel> get questions;

  /// Create a copy of Part7SetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7SetModelImplCopyWith<_$Part7SetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part7PassageModel _$Part7PassageModelFromJson(Map<String, dynamic> json) {
  return _Part7PassageModel.fromJson(json);
}

/// @nodoc
mixin _$Part7PassageModel {
  int get seq => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  /// Serializes this Part7PassageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7PassageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7PassageModelCopyWith<Part7PassageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7PassageModelCopyWith<$Res> {
  factory $Part7PassageModelCopyWith(
          Part7PassageModel value, $Res Function(Part7PassageModel) then) =
      _$Part7PassageModelCopyWithImpl<$Res, Part7PassageModel>;
  @useResult
  $Res call({int seq, String type, String text, String translation});
}

/// @nodoc
class _$Part7PassageModelCopyWithImpl<$Res, $Val extends Part7PassageModel>
    implements $Part7PassageModelCopyWith<$Res> {
  _$Part7PassageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7PassageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seq = null,
    Object? type = null,
    Object? text = null,
    Object? translation = null,
  }) {
    return _then(_value.copyWith(
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
abstract class _$$Part7PassageModelImplCopyWith<$Res>
    implements $Part7PassageModelCopyWith<$Res> {
  factory _$$Part7PassageModelImplCopyWith(_$Part7PassageModelImpl value,
          $Res Function(_$Part7PassageModelImpl) then) =
      __$$Part7PassageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int seq, String type, String text, String translation});
}

/// @nodoc
class __$$Part7PassageModelImplCopyWithImpl<$Res>
    extends _$Part7PassageModelCopyWithImpl<$Res, _$Part7PassageModelImpl>
    implements _$$Part7PassageModelImplCopyWith<$Res> {
  __$$Part7PassageModelImplCopyWithImpl(_$Part7PassageModelImpl _value,
      $Res Function(_$Part7PassageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7PassageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seq = null,
    Object? type = null,
    Object? text = null,
    Object? translation = null,
  }) {
    return _then(_$Part7PassageModelImpl(
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
class _$Part7PassageModelImpl implements _Part7PassageModel {
  const _$Part7PassageModelImpl(
      {required this.seq,
      required this.type,
      required this.text,
      required this.translation});

  factory _$Part7PassageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7PassageModelImplFromJson(json);

  @override
  final int seq;
  @override
  final String type;
  @override
  final String text;
  @override
  final String translation;

  @override
  String toString() {
    return 'Part7PassageModel(seq: $seq, type: $type, text: $text, translation: $translation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7PassageModelImpl &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, seq, type, text, translation);

  /// Create a copy of Part7PassageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7PassageModelImplCopyWith<_$Part7PassageModelImpl> get copyWith =>
      __$$Part7PassageModelImplCopyWithImpl<_$Part7PassageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7PassageModelImplToJson(
      this,
    );
  }
}

abstract class _Part7PassageModel implements Part7PassageModel {
  const factory _Part7PassageModel(
      {required final int seq,
      required final String type,
      required final String text,
      required final String translation}) = _$Part7PassageModelImpl;

  factory _Part7PassageModel.fromJson(Map<String, dynamic> json) =
      _$Part7PassageModelImpl.fromJson;

  @override
  int get seq;
  @override
  String get type;
  @override
  String get text;
  @override
  String get translation;

  /// Create a copy of Part7PassageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7PassageModelImplCopyWith<_$Part7PassageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part7QuestionModel _$Part7QuestionModelFromJson(Map<String, dynamic> json) {
  return _Part7QuestionModel.fromJson(json);
}

/// @nodoc
mixin _$Part7QuestionModel {
  int get questionSeq => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  String get questionText => throw _privateConstructorUsedError;
  String get questionTranslation => throw _privateConstructorUsedError;
  List<Part7ChoiceModel> get choices => throw _privateConstructorUsedError;

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
      {int questionSeq,
      String questionType,
      String questionText,
      String questionTranslation,
      List<Part7ChoiceModel> choices});
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
    Object? questionSeq = null,
    Object? questionType = null,
    Object? questionText = null,
    Object? questionTranslation = null,
    Object? choices = null,
  }) {
    return _then(_value.copyWith(
      questionSeq: null == questionSeq
          ? _value.questionSeq
          : questionSeq // ignore: cast_nullable_to_non_nullable
              as int,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
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
              as List<Part7ChoiceModel>,
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
      {int questionSeq,
      String questionType,
      String questionText,
      String questionTranslation,
      List<Part7ChoiceModel> choices});
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
    Object? questionSeq = null,
    Object? questionType = null,
    Object? questionText = null,
    Object? questionTranslation = null,
    Object? choices = null,
  }) {
    return _then(_$Part7QuestionModelImpl(
      questionSeq: null == questionSeq
          ? _value.questionSeq
          : questionSeq // ignore: cast_nullable_to_non_nullable
              as int,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
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
              as List<Part7ChoiceModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7QuestionModelImpl implements _Part7QuestionModel {
  const _$Part7QuestionModelImpl(
      {required this.questionSeq,
      required this.questionType,
      required this.questionText,
      required this.questionTranslation,
      required final List<Part7ChoiceModel> choices})
      : _choices = choices;

  factory _$Part7QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7QuestionModelImplFromJson(json);

  @override
  final int questionSeq;
  @override
  final String questionType;
  @override
  final String questionText;
  @override
  final String questionTranslation;
  final List<Part7ChoiceModel> _choices;
  @override
  List<Part7ChoiceModel> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  String toString() {
    return 'Part7QuestionModel(questionSeq: $questionSeq, questionType: $questionType, questionText: $questionText, questionTranslation: $questionTranslation, choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7QuestionModelImpl &&
            (identical(other.questionSeq, questionSeq) ||
                other.questionSeq == questionSeq) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
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
      questionSeq,
      questionType,
      questionText,
      questionTranslation,
      const DeepCollectionEquality().hash(_choices));

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
          {required final int questionSeq,
          required final String questionType,
          required final String questionText,
          required final String questionTranslation,
          required final List<Part7ChoiceModel> choices}) =
      _$Part7QuestionModelImpl;

  factory _Part7QuestionModel.fromJson(Map<String, dynamic> json) =
      _$Part7QuestionModelImpl.fromJson;

  @override
  int get questionSeq;
  @override
  String get questionType;
  @override
  String get questionText;
  @override
  String get questionTranslation;
  @override
  List<Part7ChoiceModel> get choices;

  /// Create a copy of Part7QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7QuestionModelImplCopyWith<_$Part7QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part7ChoiceModel _$Part7ChoiceModelFromJson(Map<String, dynamic> json) {
  return _Part7ChoiceModel.fromJson(json);
}

/// @nodoc
mixin _$Part7ChoiceModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  /// Serializes this Part7ChoiceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7ChoiceModelCopyWith<Part7ChoiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7ChoiceModelCopyWith<$Res> {
  factory $Part7ChoiceModelCopyWith(
          Part7ChoiceModel value, $Res Function(Part7ChoiceModel) then) =
      _$Part7ChoiceModelCopyWithImpl<$Res, Part7ChoiceModel>;
  @useResult
  $Res call({String id, String text, String translation});
}

/// @nodoc
class _$Part7ChoiceModelCopyWithImpl<$Res, $Val extends Part7ChoiceModel>
    implements $Part7ChoiceModelCopyWith<$Res> {
  _$Part7ChoiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7ChoiceModel
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
abstract class _$$Part7ChoiceModelImplCopyWith<$Res>
    implements $Part7ChoiceModelCopyWith<$Res> {
  factory _$$Part7ChoiceModelImplCopyWith(_$Part7ChoiceModelImpl value,
          $Res Function(_$Part7ChoiceModelImpl) then) =
      __$$Part7ChoiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, String translation});
}

/// @nodoc
class __$$Part7ChoiceModelImplCopyWithImpl<$Res>
    extends _$Part7ChoiceModelCopyWithImpl<$Res, _$Part7ChoiceModelImpl>
    implements _$$Part7ChoiceModelImplCopyWith<$Res> {
  __$$Part7ChoiceModelImplCopyWithImpl(_$Part7ChoiceModelImpl _value,
      $Res Function(_$Part7ChoiceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? translation = null,
  }) {
    return _then(_$Part7ChoiceModelImpl(
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
class _$Part7ChoiceModelImpl implements _Part7ChoiceModel {
  const _$Part7ChoiceModelImpl(
      {required this.id, required this.text, required this.translation});

  factory _$Part7ChoiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7ChoiceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String translation;

  @override
  String toString() {
    return 'Part7ChoiceModel(id: $id, text: $text, translation: $translation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7ChoiceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, translation);

  /// Create a copy of Part7ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7ChoiceModelImplCopyWith<_$Part7ChoiceModelImpl> get copyWith =>
      __$$Part7ChoiceModelImplCopyWithImpl<_$Part7ChoiceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7ChoiceModelImplToJson(
      this,
    );
  }
}

abstract class _Part7ChoiceModel implements Part7ChoiceModel {
  const factory _Part7ChoiceModel(
      {required final String id,
      required final String text,
      required final String translation}) = _$Part7ChoiceModelImpl;

  factory _Part7ChoiceModel.fromJson(Map<String, dynamic> json) =
      _$Part7ChoiceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get translation;

  /// Create a copy of Part7ChoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7ChoiceModelImplCopyWith<_$Part7ChoiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part7SetsResponseModel _$Part7SetsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _Part7SetsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$Part7SetsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  List<Part7SetModel> get sets => throw _privateConstructorUsedError;

  /// Serializes this Part7SetsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7SetsResponseModelCopyWith<Part7SetsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7SetsResponseModelCopyWith<$Res> {
  factory $Part7SetsResponseModelCopyWith(Part7SetsResponseModel value,
          $Res Function(Part7SetsResponseModel) then) =
      _$Part7SetsResponseModelCopyWithImpl<$Res, Part7SetsResponseModel>;
  @useResult
  $Res call(
      {bool success,
      int count,
      int total,
      int page,
      int totalPages,
      List<Part7SetModel> sets});
}

/// @nodoc
class _$Part7SetsResponseModelCopyWithImpl<$Res,
        $Val extends Part7SetsResponseModel>
    implements $Part7SetsResponseModelCopyWith<$Res> {
  _$Part7SetsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
    Object? sets = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
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
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<Part7SetModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7SetsResponseModelImplCopyWith<$Res>
    implements $Part7SetsResponseModelCopyWith<$Res> {
  factory _$$Part7SetsResponseModelImplCopyWith(
          _$Part7SetsResponseModelImpl value,
          $Res Function(_$Part7SetsResponseModelImpl) then) =
      __$$Part7SetsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      int total,
      int page,
      int totalPages,
      List<Part7SetModel> sets});
}

/// @nodoc
class __$$Part7SetsResponseModelImplCopyWithImpl<$Res>
    extends _$Part7SetsResponseModelCopyWithImpl<$Res,
        _$Part7SetsResponseModelImpl>
    implements _$$Part7SetsResponseModelImplCopyWith<$Res> {
  __$$Part7SetsResponseModelImplCopyWithImpl(
      _$Part7SetsResponseModelImpl _value,
      $Res Function(_$Part7SetsResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
    Object? sets = null,
  }) {
    return _then(_$Part7SetsResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
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
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<Part7SetModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7SetsResponseModelImpl implements _Part7SetsResponseModel {
  const _$Part7SetsResponseModelImpl(
      {this.success = true,
      required this.count,
      required this.total,
      required this.page,
      required this.totalPages,
      required final List<Part7SetModel> sets})
      : _sets = sets;

  factory _$Part7SetsResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7SetsResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final int count;
  @override
  final int total;
  @override
  final int page;
  @override
  final int totalPages;
  final List<Part7SetModel> _sets;
  @override
  List<Part7SetModel> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  String toString() {
    return 'Part7SetsResponseModel(success: $success, count: $count, total: $total, page: $page, totalPages: $totalPages, sets: $sets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7SetsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, count, total, page,
      totalPages, const DeepCollectionEquality().hash(_sets));

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7SetsResponseModelImplCopyWith<_$Part7SetsResponseModelImpl>
      get copyWith => __$$Part7SetsResponseModelImplCopyWithImpl<
          _$Part7SetsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7SetsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _Part7SetsResponseModel implements Part7SetsResponseModel {
  const factory _Part7SetsResponseModel(
      {final bool success,
      required final int count,
      required final int total,
      required final int page,
      required final int totalPages,
      required final List<Part7SetModel> sets}) = _$Part7SetsResponseModelImpl;

  factory _Part7SetsResponseModel.fromJson(Map<String, dynamic> json) =
      _$Part7SetsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  int get count;
  @override
  int get total;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  List<Part7SetModel> get sets;

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7SetsResponseModelImplCopyWith<_$Part7SetsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part7AnswerModel _$Part7AnswerModelFromJson(Map<String, dynamic> json) {
  return _Part7AnswerModel.fromJson(json);
}

/// @nodoc
mixin _$Part7AnswerModel {
  String get setId => throw _privateConstructorUsedError;
  int get questionSeq => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;

  /// Serializes this Part7AnswerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7AnswerModelCopyWith<Part7AnswerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7AnswerModelCopyWith<$Res> {
  factory $Part7AnswerModelCopyWith(
          Part7AnswerModel value, $Res Function(Part7AnswerModel) then) =
      _$Part7AnswerModelCopyWithImpl<$Res, Part7AnswerModel>;
  @useResult
  $Res call({String setId, int questionSeq, String answer, String explanation});
}

/// @nodoc
class _$Part7AnswerModelCopyWithImpl<$Res, $Val extends Part7AnswerModel>
    implements $Part7AnswerModelCopyWith<$Res> {
  _$Part7AnswerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7AnswerModel
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
abstract class _$$Part7AnswerModelImplCopyWith<$Res>
    implements $Part7AnswerModelCopyWith<$Res> {
  factory _$$Part7AnswerModelImplCopyWith(_$Part7AnswerModelImpl value,
          $Res Function(_$Part7AnswerModelImpl) then) =
      __$$Part7AnswerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String setId, int questionSeq, String answer, String explanation});
}

/// @nodoc
class __$$Part7AnswerModelImplCopyWithImpl<$Res>
    extends _$Part7AnswerModelCopyWithImpl<$Res, _$Part7AnswerModelImpl>
    implements _$$Part7AnswerModelImplCopyWith<$Res> {
  __$$Part7AnswerModelImplCopyWithImpl(_$Part7AnswerModelImpl _value,
      $Res Function(_$Part7AnswerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? questionSeq = null,
    Object? answer = null,
    Object? explanation = null,
  }) {
    return _then(_$Part7AnswerModelImpl(
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
class _$Part7AnswerModelImpl implements _Part7AnswerModel {
  const _$Part7AnswerModelImpl(
      {required this.setId,
      required this.questionSeq,
      required this.answer,
      required this.explanation});

  factory _$Part7AnswerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7AnswerModelImplFromJson(json);

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
    return 'Part7AnswerModel(setId: $setId, questionSeq: $questionSeq, answer: $answer, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7AnswerModelImpl &&
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

  /// Create a copy of Part7AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7AnswerModelImplCopyWith<_$Part7AnswerModelImpl> get copyWith =>
      __$$Part7AnswerModelImplCopyWithImpl<_$Part7AnswerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7AnswerModelImplToJson(
      this,
    );
  }
}

abstract class _Part7AnswerModel implements Part7AnswerModel {
  const factory _Part7AnswerModel(
      {required final String setId,
      required final int questionSeq,
      required final String answer,
      required final String explanation}) = _$Part7AnswerModelImpl;

  factory _Part7AnswerModel.fromJson(Map<String, dynamic> json) =
      _$Part7AnswerModelImpl.fromJson;

  @override
  String get setId;
  @override
  int get questionSeq;
  @override
  String get answer;
  @override
  String get explanation;

  /// Create a copy of Part7AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7AnswerModelImplCopyWith<_$Part7AnswerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
