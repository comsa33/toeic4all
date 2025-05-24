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
  @JsonKey(name: 'questionSeq')
  int get questionSeq => throw _privateConstructorUsedError;
  @JsonKey(name: 'questionType')
  String get questionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'questionText')
  String get questionText => throw _privateConstructorUsedError;
  @JsonKey(name: 'questionTranslation')
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
      {@JsonKey(name: 'questionSeq') int questionSeq,
      @JsonKey(name: 'questionType') String questionType,
      @JsonKey(name: 'questionText') String questionText,
      @JsonKey(name: 'questionTranslation') String questionTranslation,
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
      {@JsonKey(name: 'questionSeq') int questionSeq,
      @JsonKey(name: 'questionType') String questionType,
      @JsonKey(name: 'questionText') String questionText,
      @JsonKey(name: 'questionTranslation') String questionTranslation,
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
      {@JsonKey(name: 'questionSeq') required this.questionSeq,
      @JsonKey(name: 'questionType') required this.questionType,
      @JsonKey(name: 'questionText') required this.questionText,
      @JsonKey(name: 'questionTranslation') required this.questionTranslation,
      required final List<Part7ChoiceModel> choices})
      : _choices = choices;

  factory _$Part7QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7QuestionModelImplFromJson(json);

  @override
  @JsonKey(name: 'questionSeq')
  final int questionSeq;
  @override
  @JsonKey(name: 'questionType')
  final String questionType;
  @override
  @JsonKey(name: 'questionText')
  final String questionText;
  @override
  @JsonKey(name: 'questionTranslation')
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
          {@JsonKey(name: 'questionSeq') required final int questionSeq,
          @JsonKey(name: 'questionType') required final String questionType,
          @JsonKey(name: 'questionText') required final String questionText,
          @JsonKey(name: 'questionTranslation')
          required final String questionTranslation,
          required final List<Part7ChoiceModel> choices}) =
      _$Part7QuestionModelImpl;

  factory _Part7QuestionModel.fromJson(Map<String, dynamic> json) =
      _$Part7QuestionModelImpl.fromJson;

  @override
  @JsonKey(name: 'questionSeq')
  int get questionSeq;
  @override
  @JsonKey(name: 'questionType')
  String get questionType;
  @override
  @JsonKey(name: 'questionText')
  String get questionText;
  @override
  @JsonKey(name: 'questionTranslation')
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

Part7SetModel _$Part7SetModelFromJson(Map<String, dynamic> json) {
  return _Part7SetModel.fromJson(json);
}

/// @nodoc
mixin _$Part7SetModel {
  String get id => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'questionSetType')
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
      @JsonKey(name: 'questionSetType') String questionSetType,
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
      @JsonKey(name: 'questionSetType') String questionSetType,
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
      @JsonKey(name: 'questionSetType') required this.questionSetType,
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
  @JsonKey(name: 'questionSetType')
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
      @JsonKey(name: 'questionSetType') required final String questionSetType,
      required final List<Part7PassageModel> passages,
      required final List<Part7QuestionModel> questions}) = _$Part7SetModelImpl;

  factory _Part7SetModel.fromJson(Map<String, dynamic> json) =
      _$Part7SetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get difficulty;
  @override
  @JsonKey(name: 'questionSetType')
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

Part7SetsData _$Part7SetsDataFromJson(Map<String, dynamic> json) {
  return _Part7SetsData.fromJson(json);
}

/// @nodoc
mixin _$Part7SetsData {
  List<Part7SetModel> get sets => throw _privateConstructorUsedError;

  /// Serializes this Part7SetsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7SetsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7SetsDataCopyWith<Part7SetsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7SetsDataCopyWith<$Res> {
  factory $Part7SetsDataCopyWith(
          Part7SetsData value, $Res Function(Part7SetsData) then) =
      _$Part7SetsDataCopyWithImpl<$Res, Part7SetsData>;
  @useResult
  $Res call({List<Part7SetModel> sets});
}

/// @nodoc
class _$Part7SetsDataCopyWithImpl<$Res, $Val extends Part7SetsData>
    implements $Part7SetsDataCopyWith<$Res> {
  _$Part7SetsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7SetsData
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
              as List<Part7SetModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7SetsDataImplCopyWith<$Res>
    implements $Part7SetsDataCopyWith<$Res> {
  factory _$$Part7SetsDataImplCopyWith(
          _$Part7SetsDataImpl value, $Res Function(_$Part7SetsDataImpl) then) =
      __$$Part7SetsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Part7SetModel> sets});
}

/// @nodoc
class __$$Part7SetsDataImplCopyWithImpl<$Res>
    extends _$Part7SetsDataCopyWithImpl<$Res, _$Part7SetsDataImpl>
    implements _$$Part7SetsDataImplCopyWith<$Res> {
  __$$Part7SetsDataImplCopyWithImpl(
      _$Part7SetsDataImpl _value, $Res Function(_$Part7SetsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7SetsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sets = null,
  }) {
    return _then(_$Part7SetsDataImpl(
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<Part7SetModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7SetsDataImpl implements _Part7SetsData {
  const _$Part7SetsDataImpl({required final List<Part7SetModel> sets})
      : _sets = sets;

  factory _$Part7SetsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7SetsDataImplFromJson(json);

  final List<Part7SetModel> _sets;
  @override
  List<Part7SetModel> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  String toString() {
    return 'Part7SetsData(sets: $sets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7SetsDataImpl &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sets));

  /// Create a copy of Part7SetsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7SetsDataImplCopyWith<_$Part7SetsDataImpl> get copyWith =>
      __$$Part7SetsDataImplCopyWithImpl<_$Part7SetsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7SetsDataImplToJson(
      this,
    );
  }
}

abstract class _Part7SetsData implements Part7SetsData {
  const factory _Part7SetsData({required final List<Part7SetModel> sets}) =
      _$Part7SetsDataImpl;

  factory _Part7SetsData.fromJson(Map<String, dynamic> json) =
      _$Part7SetsDataImpl.fromJson;

  @override
  List<Part7SetModel> get sets;

  /// Create a copy of Part7SetsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7SetsDataImplCopyWith<_$Part7SetsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Part7SetsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Part7SetsData get data => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError; // 수정: 기본값 제공
  int get total => throw _privateConstructorUsedError; // 수정: 기본값 제공
  int get page => throw _privateConstructorUsedError; // 수정: 기본값 제공
  int get totalPages => throw _privateConstructorUsedError;

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
      String? message,
      Part7SetsData data,
      int count,
      int total,
      int page,
      int totalPages});

  $Part7SetsDataCopyWith<$Res> get data;
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
              as Part7SetsData,
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

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Part7SetsDataCopyWith<$Res> get data {
    return $Part7SetsDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
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
      String? message,
      Part7SetsData data,
      int count,
      int total,
      int page,
      int totalPages});

  @override
  $Part7SetsDataCopyWith<$Res> get data;
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
    Object? message = freezed,
    Object? data = null,
    Object? count = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
  }) {
    return _then(_$Part7SetsResponseModelImpl(
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
              as Part7SetsData,
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

class _$Part7SetsResponseModelImpl implements _Part7SetsResponseModel {
  const _$Part7SetsResponseModelImpl(
      {this.success = true,
      this.message,
      required this.data,
      this.count = 0,
      this.total = 0,
      this.page = 1,
      this.totalPages = 1});

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  @override
  final Part7SetsData data;
  @override
  @JsonKey()
  final int count;
// 수정: 기본값 제공
  @override
  @JsonKey()
  final int total;
// 수정: 기본값 제공
  @override
  @JsonKey()
  final int page;
// 수정: 기본값 제공
  @override
  @JsonKey()
  final int totalPages;

  @override
  String toString() {
    return 'Part7SetsResponseModel(success: $success, message: $message, data: $data, count: $count, total: $total, page: $page, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7SetsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, data, count, total, page, totalPages);

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7SetsResponseModelImplCopyWith<_$Part7SetsResponseModelImpl>
      get copyWith => __$$Part7SetsResponseModelImplCopyWithImpl<
          _$Part7SetsResponseModelImpl>(this, _$identity);
}

abstract class _Part7SetsResponseModel implements Part7SetsResponseModel {
  const factory _Part7SetsResponseModel(
      {final bool success,
      final String? message,
      required final Part7SetsData data,
      final int count,
      final int total,
      final int page,
      final int totalPages}) = _$Part7SetsResponseModelImpl;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Part7SetsData get data;
  @override
  int get count; // 수정: 기본값 제공
  @override
  int get total; // 수정: 기본값 제공
  @override
  int get page; // 수정: 기본값 제공
  @override
  int get totalPages;

  /// Create a copy of Part7SetsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7SetsResponseModelImplCopyWith<_$Part7SetsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part7AnswerData _$Part7AnswerDataFromJson(Map<String, dynamic> json) {
  return _Part7AnswerData.fromJson(json);
}

/// @nodoc
mixin _$Part7AnswerData {
  @JsonKey(name: 'set_id')
  String get setId => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_seq')
  int get questionSeq => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;

  /// Serializes this Part7AnswerData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7AnswerDataCopyWith<Part7AnswerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7AnswerDataCopyWith<$Res> {
  factory $Part7AnswerDataCopyWith(
          Part7AnswerData value, $Res Function(Part7AnswerData) then) =
      _$Part7AnswerDataCopyWithImpl<$Res, Part7AnswerData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'set_id') String setId,
      @JsonKey(name: 'question_seq') int questionSeq,
      String answer,
      String explanation});
}

/// @nodoc
class _$Part7AnswerDataCopyWithImpl<$Res, $Val extends Part7AnswerData>
    implements $Part7AnswerDataCopyWith<$Res> {
  _$Part7AnswerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7AnswerData
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
abstract class _$$Part7AnswerDataImplCopyWith<$Res>
    implements $Part7AnswerDataCopyWith<$Res> {
  factory _$$Part7AnswerDataImplCopyWith(_$Part7AnswerDataImpl value,
          $Res Function(_$Part7AnswerDataImpl) then) =
      __$$Part7AnswerDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'set_id') String setId,
      @JsonKey(name: 'question_seq') int questionSeq,
      String answer,
      String explanation});
}

/// @nodoc
class __$$Part7AnswerDataImplCopyWithImpl<$Res>
    extends _$Part7AnswerDataCopyWithImpl<$Res, _$Part7AnswerDataImpl>
    implements _$$Part7AnswerDataImplCopyWith<$Res> {
  __$$Part7AnswerDataImplCopyWithImpl(
      _$Part7AnswerDataImpl _value, $Res Function(_$Part7AnswerDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? questionSeq = null,
    Object? answer = null,
    Object? explanation = null,
  }) {
    return _then(_$Part7AnswerDataImpl(
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
class _$Part7AnswerDataImpl implements _Part7AnswerData {
  const _$Part7AnswerDataImpl(
      {@JsonKey(name: 'set_id') required this.setId,
      @JsonKey(name: 'question_seq') required this.questionSeq,
      required this.answer,
      required this.explanation});

  factory _$Part7AnswerDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7AnswerDataImplFromJson(json);

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
    return 'Part7AnswerData(setId: $setId, questionSeq: $questionSeq, answer: $answer, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7AnswerDataImpl &&
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

  /// Create a copy of Part7AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7AnswerDataImplCopyWith<_$Part7AnswerDataImpl> get copyWith =>
      __$$Part7AnswerDataImplCopyWithImpl<_$Part7AnswerDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7AnswerDataImplToJson(
      this,
    );
  }
}

abstract class _Part7AnswerData implements Part7AnswerData {
  const factory _Part7AnswerData(
      {@JsonKey(name: 'set_id') required final String setId,
      @JsonKey(name: 'question_seq') required final int questionSeq,
      required final String answer,
      required final String explanation}) = _$Part7AnswerDataImpl;

  factory _Part7AnswerData.fromJson(Map<String, dynamic> json) =
      _$Part7AnswerDataImpl.fromJson;

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

  /// Create a copy of Part7AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7AnswerDataImplCopyWith<_$Part7AnswerDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Part7AnswerResponseModel _$Part7AnswerResponseModelFromJson(
    Map<String, dynamic> json) {
  return _Part7AnswerResponseModel.fromJson(json);
}

/// @nodoc
mixin _$Part7AnswerResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Part7AnswerData get data => throw _privateConstructorUsedError;

  /// Serializes this Part7AnswerResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7AnswerResponseModelCopyWith<Part7AnswerResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7AnswerResponseModelCopyWith<$Res> {
  factory $Part7AnswerResponseModelCopyWith(Part7AnswerResponseModel value,
          $Res Function(Part7AnswerResponseModel) then) =
      _$Part7AnswerResponseModelCopyWithImpl<$Res, Part7AnswerResponseModel>;
  @useResult
  $Res call({bool success, String? message, Part7AnswerData data});

  $Part7AnswerDataCopyWith<$Res> get data;
}

/// @nodoc
class _$Part7AnswerResponseModelCopyWithImpl<$Res,
        $Val extends Part7AnswerResponseModel>
    implements $Part7AnswerResponseModelCopyWith<$Res> {
  _$Part7AnswerResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7AnswerResponseModel
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
              as Part7AnswerData,
    ) as $Val);
  }

  /// Create a copy of Part7AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Part7AnswerDataCopyWith<$Res> get data {
    return $Part7AnswerDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$Part7AnswerResponseModelImplCopyWith<$Res>
    implements $Part7AnswerResponseModelCopyWith<$Res> {
  factory _$$Part7AnswerResponseModelImplCopyWith(
          _$Part7AnswerResponseModelImpl value,
          $Res Function(_$Part7AnswerResponseModelImpl) then) =
      __$$Part7AnswerResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, Part7AnswerData data});

  @override
  $Part7AnswerDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$Part7AnswerResponseModelImplCopyWithImpl<$Res>
    extends _$Part7AnswerResponseModelCopyWithImpl<$Res,
        _$Part7AnswerResponseModelImpl>
    implements _$$Part7AnswerResponseModelImplCopyWith<$Res> {
  __$$Part7AnswerResponseModelImplCopyWithImpl(
      _$Part7AnswerResponseModelImpl _value,
      $Res Function(_$Part7AnswerResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$Part7AnswerResponseModelImpl(
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
              as Part7AnswerData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7AnswerResponseModelImpl implements _Part7AnswerResponseModel {
  const _$Part7AnswerResponseModelImpl(
      {this.success = true, this.message, required this.data});

  factory _$Part7AnswerResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Part7AnswerResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  @override
  final Part7AnswerData data;

  @override
  String toString() {
    return 'Part7AnswerResponseModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7AnswerResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  /// Create a copy of Part7AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7AnswerResponseModelImplCopyWith<_$Part7AnswerResponseModelImpl>
      get copyWith => __$$Part7AnswerResponseModelImplCopyWithImpl<
          _$Part7AnswerResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7AnswerResponseModelImplToJson(
      this,
    );
  }
}

abstract class _Part7AnswerResponseModel implements Part7AnswerResponseModel {
  const factory _Part7AnswerResponseModel(
      {final bool success,
      final String? message,
      required final Part7AnswerData data}) = _$Part7AnswerResponseModelImpl;

  factory _Part7AnswerResponseModel.fromJson(Map<String, dynamic> json) =
      _$Part7AnswerResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Part7AnswerData get data;

  /// Create a copy of Part7AnswerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7AnswerResponseModelImplCopyWith<_$Part7AnswerResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SetTypeInfoModel _$SetTypeInfoModelFromJson(Map<String, dynamic> json) {
  return _SetTypeInfoModel.fromJson(json);
}

/// @nodoc
mixin _$SetTypeInfoModel {
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'required_passages')
  int get requiredPassages => throw _privateConstructorUsedError;

  /// Serializes this SetTypeInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SetTypeInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SetTypeInfoModelCopyWith<SetTypeInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetTypeInfoModelCopyWith<$Res> {
  factory $SetTypeInfoModelCopyWith(
          SetTypeInfoModel value, $Res Function(SetTypeInfoModel) then) =
      _$SetTypeInfoModelCopyWithImpl<$Res, SetTypeInfoModel>;
  @useResult
  $Res call(
      {String description,
      @JsonKey(name: 'required_passages') int requiredPassages});
}

/// @nodoc
class _$SetTypeInfoModelCopyWithImpl<$Res, $Val extends SetTypeInfoModel>
    implements $SetTypeInfoModelCopyWith<$Res> {
  _$SetTypeInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetTypeInfoModel
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
abstract class _$$SetTypeInfoModelImplCopyWith<$Res>
    implements $SetTypeInfoModelCopyWith<$Res> {
  factory _$$SetTypeInfoModelImplCopyWith(_$SetTypeInfoModelImpl value,
          $Res Function(_$SetTypeInfoModelImpl) then) =
      __$$SetTypeInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      @JsonKey(name: 'required_passages') int requiredPassages});
}

/// @nodoc
class __$$SetTypeInfoModelImplCopyWithImpl<$Res>
    extends _$SetTypeInfoModelCopyWithImpl<$Res, _$SetTypeInfoModelImpl>
    implements _$$SetTypeInfoModelImplCopyWith<$Res> {
  __$$SetTypeInfoModelImplCopyWithImpl(_$SetTypeInfoModelImpl _value,
      $Res Function(_$SetTypeInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetTypeInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? requiredPassages = null,
  }) {
    return _then(_$SetTypeInfoModelImpl(
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
class _$SetTypeInfoModelImpl implements _SetTypeInfoModel {
  const _$SetTypeInfoModelImpl(
      {required this.description,
      @JsonKey(name: 'required_passages') required this.requiredPassages});

  factory _$SetTypeInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetTypeInfoModelImplFromJson(json);

  @override
  final String description;
  @override
  @JsonKey(name: 'required_passages')
  final int requiredPassages;

  @override
  String toString() {
    return 'SetTypeInfoModel(description: $description, requiredPassages: $requiredPassages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetTypeInfoModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.requiredPassages, requiredPassages) ||
                other.requiredPassages == requiredPassages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, requiredPassages);

  /// Create a copy of SetTypeInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetTypeInfoModelImplCopyWith<_$SetTypeInfoModelImpl> get copyWith =>
      __$$SetTypeInfoModelImplCopyWithImpl<_$SetTypeInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetTypeInfoModelImplToJson(
      this,
    );
  }
}

abstract class _SetTypeInfoModel implements SetTypeInfoModel {
  const factory _SetTypeInfoModel(
      {required final String description,
      @JsonKey(name: 'required_passages')
      required final int requiredPassages}) = _$SetTypeInfoModelImpl;

  factory _SetTypeInfoModel.fromJson(Map<String, dynamic> json) =
      _$SetTypeInfoModelImpl.fromJson;

  @override
  String get description;
  @override
  @JsonKey(name: 'required_passages')
  int get requiredPassages;

  /// Create a copy of SetTypeInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetTypeInfoModelImplCopyWith<_$SetTypeInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Part7SetTypesResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Map<String, SetTypeInfoModel> get data => throw _privateConstructorUsedError;

  /// Create a copy of Part7SetTypesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7SetTypesResponseModelCopyWith<Part7SetTypesResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7SetTypesResponseModelCopyWith<$Res> {
  factory $Part7SetTypesResponseModelCopyWith(Part7SetTypesResponseModel value,
          $Res Function(Part7SetTypesResponseModel) then) =
      _$Part7SetTypesResponseModelCopyWithImpl<$Res,
          Part7SetTypesResponseModel>;
  @useResult
  $Res call(
      {bool success, String? message, Map<String, SetTypeInfoModel> data});
}

/// @nodoc
class _$Part7SetTypesResponseModelCopyWithImpl<$Res,
        $Val extends Part7SetTypesResponseModel>
    implements $Part7SetTypesResponseModelCopyWith<$Res> {
  _$Part7SetTypesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7SetTypesResponseModel
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
              as Map<String, SetTypeInfoModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7SetTypesResponseModelImplCopyWith<$Res>
    implements $Part7SetTypesResponseModelCopyWith<$Res> {
  factory _$$Part7SetTypesResponseModelImplCopyWith(
          _$Part7SetTypesResponseModelImpl value,
          $Res Function(_$Part7SetTypesResponseModelImpl) then) =
      __$$Part7SetTypesResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success, String? message, Map<String, SetTypeInfoModel> data});
}

/// @nodoc
class __$$Part7SetTypesResponseModelImplCopyWithImpl<$Res>
    extends _$Part7SetTypesResponseModelCopyWithImpl<$Res,
        _$Part7SetTypesResponseModelImpl>
    implements _$$Part7SetTypesResponseModelImplCopyWith<$Res> {
  __$$Part7SetTypesResponseModelImplCopyWithImpl(
      _$Part7SetTypesResponseModelImpl _value,
      $Res Function(_$Part7SetTypesResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7SetTypesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$Part7SetTypesResponseModelImpl(
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
              as Map<String, SetTypeInfoModel>,
    ));
  }
}

/// @nodoc

class _$Part7SetTypesResponseModelImpl implements _Part7SetTypesResponseModel {
  const _$Part7SetTypesResponseModelImpl(
      {this.success = true,
      this.message,
      final Map<String, SetTypeInfoModel> data = const {}})
      : _data = data;

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  final Map<String, SetTypeInfoModel> _data;
  @override
  @JsonKey()
  Map<String, SetTypeInfoModel> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'Part7SetTypesResponseModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7SetTypesResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of Part7SetTypesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7SetTypesResponseModelImplCopyWith<_$Part7SetTypesResponseModelImpl>
      get copyWith => __$$Part7SetTypesResponseModelImplCopyWithImpl<
          _$Part7SetTypesResponseModelImpl>(this, _$identity);
}

abstract class _Part7SetTypesResponseModel
    implements Part7SetTypesResponseModel {
  const factory _Part7SetTypesResponseModel(
          {final bool success,
          final String? message,
          final Map<String, SetTypeInfoModel> data}) =
      _$Part7SetTypesResponseModelImpl;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Map<String, SetTypeInfoModel> get data;

  /// Create a copy of Part7SetTypesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7SetTypesResponseModelImplCopyWith<_$Part7SetTypesResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Part7PassageCombinationsResponseModel
    _$Part7PassageCombinationsResponseModelFromJson(Map<String, dynamic> json) {
  return _Part7PassageCombinationsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$Part7PassageCombinationsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<List<String>> get data => throw _privateConstructorUsedError;

  /// Serializes this Part7PassageCombinationsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Part7PassageCombinationsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Part7PassageCombinationsResponseModelCopyWith<
          Part7PassageCombinationsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Part7PassageCombinationsResponseModelCopyWith<$Res> {
  factory $Part7PassageCombinationsResponseModelCopyWith(
          Part7PassageCombinationsResponseModel value,
          $Res Function(Part7PassageCombinationsResponseModel) then) =
      _$Part7PassageCombinationsResponseModelCopyWithImpl<$Res,
          Part7PassageCombinationsResponseModel>;
  @useResult
  $Res call({bool success, String? message, List<List<String>> data});
}

/// @nodoc
class _$Part7PassageCombinationsResponseModelCopyWithImpl<$Res,
        $Val extends Part7PassageCombinationsResponseModel>
    implements $Part7PassageCombinationsResponseModelCopyWith<$Res> {
  _$Part7PassageCombinationsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Part7PassageCombinationsResponseModel
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
              as List<List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Part7PassageCombinationsResponseModelImplCopyWith<$Res>
    implements $Part7PassageCombinationsResponseModelCopyWith<$Res> {
  factory _$$Part7PassageCombinationsResponseModelImplCopyWith(
          _$Part7PassageCombinationsResponseModelImpl value,
          $Res Function(_$Part7PassageCombinationsResponseModelImpl) then) =
      __$$Part7PassageCombinationsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, List<List<String>> data});
}

/// @nodoc
class __$$Part7PassageCombinationsResponseModelImplCopyWithImpl<$Res>
    extends _$Part7PassageCombinationsResponseModelCopyWithImpl<$Res,
        _$Part7PassageCombinationsResponseModelImpl>
    implements _$$Part7PassageCombinationsResponseModelImplCopyWith<$Res> {
  __$$Part7PassageCombinationsResponseModelImplCopyWithImpl(
      _$Part7PassageCombinationsResponseModelImpl _value,
      $Res Function(_$Part7PassageCombinationsResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Part7PassageCombinationsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$Part7PassageCombinationsResponseModelImpl(
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
              as List<List<String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Part7PassageCombinationsResponseModelImpl
    implements _Part7PassageCombinationsResponseModel {
  const _$Part7PassageCombinationsResponseModelImpl(
      {this.success = true,
      this.message,
      final List<List<String>> data = const []})
      : _data = data;

  factory _$Part7PassageCombinationsResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$Part7PassageCombinationsResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? message;
  final List<List<String>> _data;
  @override
  @JsonKey()
  List<List<String>> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'Part7PassageCombinationsResponseModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Part7PassageCombinationsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of Part7PassageCombinationsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Part7PassageCombinationsResponseModelImplCopyWith<
          _$Part7PassageCombinationsResponseModelImpl>
      get copyWith => __$$Part7PassageCombinationsResponseModelImplCopyWithImpl<
          _$Part7PassageCombinationsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Part7PassageCombinationsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _Part7PassageCombinationsResponseModel
    implements Part7PassageCombinationsResponseModel {
  const factory _Part7PassageCombinationsResponseModel(
          {final bool success,
          final String? message,
          final List<List<String>> data}) =
      _$Part7PassageCombinationsResponseModelImpl;

  factory _Part7PassageCombinationsResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$Part7PassageCombinationsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  List<List<String>> get data;

  /// Create a copy of Part7PassageCombinationsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Part7PassageCombinationsResponseModelImplCopyWith<
          _$Part7PassageCombinationsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
