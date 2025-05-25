// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuestionFilter {
  String? get category => throw _privateConstructorUsedError;
  String? get subtype => throw _privateConstructorUsedError;
  String? get difficulty => throw _privateConstructorUsedError;
  String? get passageType => throw _privateConstructorUsedError;
  String? get setType => throw _privateConstructorUsedError;
  List<String>? get passageTypes => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page =>
      throw _privateConstructorUsedError; // Provider 캐싱 방지를 위한 고유 식별자
  String? get requestId => throw _privateConstructorUsedError;

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionFilterCopyWith<QuestionFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionFilterCopyWith<$Res> {
  factory $QuestionFilterCopyWith(
          QuestionFilter value, $Res Function(QuestionFilter) then) =
      _$QuestionFilterCopyWithImpl<$Res, QuestionFilter>;
  @useResult
  $Res call(
      {String? category,
      String? subtype,
      String? difficulty,
      String? passageType,
      String? setType,
      List<String>? passageTypes,
      int limit,
      int page,
      String? requestId});
}

/// @nodoc
class _$QuestionFilterCopyWithImpl<$Res, $Val extends QuestionFilter>
    implements $QuestionFilterCopyWith<$Res> {
  _$QuestionFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? subtype = freezed,
    Object? difficulty = freezed,
    Object? passageType = freezed,
    Object? setType = freezed,
    Object? passageTypes = freezed,
    Object? limit = null,
    Object? page = null,
    Object? requestId = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      subtype: freezed == subtype
          ? _value.subtype
          : subtype // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      passageType: freezed == passageType
          ? _value.passageType
          : passageType // ignore: cast_nullable_to_non_nullable
              as String?,
      setType: freezed == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String?,
      passageTypes: freezed == passageTypes
          ? _value.passageTypes
          : passageTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionFilterImplCopyWith<$Res>
    implements $QuestionFilterCopyWith<$Res> {
  factory _$$QuestionFilterImplCopyWith(_$QuestionFilterImpl value,
          $Res Function(_$QuestionFilterImpl) then) =
      __$$QuestionFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? category,
      String? subtype,
      String? difficulty,
      String? passageType,
      String? setType,
      List<String>? passageTypes,
      int limit,
      int page,
      String? requestId});
}

/// @nodoc
class __$$QuestionFilterImplCopyWithImpl<$Res>
    extends _$QuestionFilterCopyWithImpl<$Res, _$QuestionFilterImpl>
    implements _$$QuestionFilterImplCopyWith<$Res> {
  __$$QuestionFilterImplCopyWithImpl(
      _$QuestionFilterImpl _value, $Res Function(_$QuestionFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? subtype = freezed,
    Object? difficulty = freezed,
    Object? passageType = freezed,
    Object? setType = freezed,
    Object? passageTypes = freezed,
    Object? limit = null,
    Object? page = null,
    Object? requestId = freezed,
  }) {
    return _then(_$QuestionFilterImpl(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      subtype: freezed == subtype
          ? _value.subtype
          : subtype // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      passageType: freezed == passageType
          ? _value.passageType
          : passageType // ignore: cast_nullable_to_non_nullable
              as String?,
      setType: freezed == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String?,
      passageTypes: freezed == passageTypes
          ? _value._passageTypes
          : passageTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$QuestionFilterImpl implements _QuestionFilter {
  const _$QuestionFilterImpl(
      {this.category = null,
      this.subtype = null,
      this.difficulty = null,
      this.passageType = null,
      this.setType = null,
      final List<String>? passageTypes = null,
      this.limit = 10,
      this.page = 1,
      this.requestId})
      : _passageTypes = passageTypes;

  @override
  @JsonKey()
  final String? category;
  @override
  @JsonKey()
  final String? subtype;
  @override
  @JsonKey()
  final String? difficulty;
  @override
  @JsonKey()
  final String? passageType;
  @override
  @JsonKey()
  final String? setType;
  final List<String>? _passageTypes;
  @override
  @JsonKey()
  List<String>? get passageTypes {
    final value = _passageTypes;
    if (value == null) return null;
    if (_passageTypes is EqualUnmodifiableListView) return _passageTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int page;
// Provider 캐싱 방지를 위한 고유 식별자
  @override
  final String? requestId;

  @override
  String toString() {
    return 'QuestionFilter(category: $category, subtype: $subtype, difficulty: $difficulty, passageType: $passageType, setType: $setType, passageTypes: $passageTypes, limit: $limit, page: $page, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionFilterImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subtype, subtype) || other.subtype == subtype) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.passageType, passageType) ||
                other.passageType == passageType) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            const DeepCollectionEquality()
                .equals(other._passageTypes, _passageTypes) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      category,
      subtype,
      difficulty,
      passageType,
      setType,
      const DeepCollectionEquality().hash(_passageTypes),
      limit,
      page,
      requestId);

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionFilterImplCopyWith<_$QuestionFilterImpl> get copyWith =>
      __$$QuestionFilterImplCopyWithImpl<_$QuestionFilterImpl>(
          this, _$identity);
}

abstract class _QuestionFilter implements QuestionFilter {
  const factory _QuestionFilter(
      {final String? category,
      final String? subtype,
      final String? difficulty,
      final String? passageType,
      final String? setType,
      final List<String>? passageTypes,
      final int limit,
      final int page,
      final String? requestId}) = _$QuestionFilterImpl;

  @override
  String? get category;
  @override
  String? get subtype;
  @override
  String? get difficulty;
  @override
  String? get passageType;
  @override
  String? get setType;
  @override
  List<String>? get passageTypes;
  @override
  int get limit;
  @override
  int get page; // Provider 캐싱 방지를 위한 고유 식별자
  @override
  String? get requestId;

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionFilterImplCopyWith<_$QuestionFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuestionSession {
  String get sessionId => throw _privateConstructorUsedError;
  QuestionType get type => throw _privateConstructorUsedError;
  List<String> get questionIds => throw _privateConstructorUsedError;
  Map<String, String> get userAnswers => throw _privateConstructorUsedError;
  Map<String, String> get correctAnswers => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Create a copy of QuestionSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionSessionCopyWith<QuestionSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionSessionCopyWith<$Res> {
  factory $QuestionSessionCopyWith(
          QuestionSession value, $Res Function(QuestionSession) then) =
      _$QuestionSessionCopyWithImpl<$Res, QuestionSession>;
  @useResult
  $Res call(
      {String sessionId,
      QuestionType type,
      List<String> questionIds,
      Map<String, String> userAnswers,
      Map<String, String> correctAnswers,
      DateTime startTime,
      DateTime? endTime,
      int currentIndex,
      bool isCompleted});
}

/// @nodoc
class _$QuestionSessionCopyWithImpl<$Res, $Val extends QuestionSession>
    implements $QuestionSessionCopyWith<$Res> {
  _$QuestionSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? type = null,
    Object? questionIds = null,
    Object? userAnswers = null,
    Object? correctAnswers = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? currentIndex = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      questionIds: null == questionIds
          ? _value.questionIds
          : questionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userAnswers: null == userAnswers
          ? _value.userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionSessionImplCopyWith<$Res>
    implements $QuestionSessionCopyWith<$Res> {
  factory _$$QuestionSessionImplCopyWith(_$QuestionSessionImpl value,
          $Res Function(_$QuestionSessionImpl) then) =
      __$$QuestionSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      QuestionType type,
      List<String> questionIds,
      Map<String, String> userAnswers,
      Map<String, String> correctAnswers,
      DateTime startTime,
      DateTime? endTime,
      int currentIndex,
      bool isCompleted});
}

/// @nodoc
class __$$QuestionSessionImplCopyWithImpl<$Res>
    extends _$QuestionSessionCopyWithImpl<$Res, _$QuestionSessionImpl>
    implements _$$QuestionSessionImplCopyWith<$Res> {
  __$$QuestionSessionImplCopyWithImpl(
      _$QuestionSessionImpl _value, $Res Function(_$QuestionSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? type = null,
    Object? questionIds = null,
    Object? userAnswers = null,
    Object? correctAnswers = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? currentIndex = null,
    Object? isCompleted = null,
  }) {
    return _then(_$QuestionSessionImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      questionIds: null == questionIds
          ? _value._questionIds
          : questionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userAnswers: null == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      correctAnswers: null == correctAnswers
          ? _value._correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$QuestionSessionImpl implements _QuestionSession {
  const _$QuestionSessionImpl(
      {required this.sessionId,
      required this.type,
      required final List<String> questionIds,
      required final Map<String, String> userAnswers,
      required final Map<String, String> correctAnswers,
      required this.startTime,
      this.endTime,
      this.currentIndex = 0,
      this.isCompleted = false})
      : _questionIds = questionIds,
        _userAnswers = userAnswers,
        _correctAnswers = correctAnswers;

  @override
  final String sessionId;
  @override
  final QuestionType type;
  final List<String> _questionIds;
  @override
  List<String> get questionIds {
    if (_questionIds is EqualUnmodifiableListView) return _questionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionIds);
  }

  final Map<String, String> _userAnswers;
  @override
  Map<String, String> get userAnswers {
    if (_userAnswers is EqualUnmodifiableMapView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userAnswers);
  }

  final Map<String, String> _correctAnswers;
  @override
  Map<String, String> get correctAnswers {
    if (_correctAnswers is EqualUnmodifiableMapView) return _correctAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_correctAnswers);
  }

  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  @JsonKey()
  final int currentIndex;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'QuestionSession(sessionId: $sessionId, type: $type, questionIds: $questionIds, userAnswers: $userAnswers, correctAnswers: $correctAnswers, startTime: $startTime, endTime: $endTime, currentIndex: $currentIndex, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionSessionImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._questionIds, _questionIds) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers) &&
            const DeepCollectionEquality()
                .equals(other._correctAnswers, _correctAnswers) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      type,
      const DeepCollectionEquality().hash(_questionIds),
      const DeepCollectionEquality().hash(_userAnswers),
      const DeepCollectionEquality().hash(_correctAnswers),
      startTime,
      endTime,
      currentIndex,
      isCompleted);

  /// Create a copy of QuestionSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionSessionImplCopyWith<_$QuestionSessionImpl> get copyWith =>
      __$$QuestionSessionImplCopyWithImpl<_$QuestionSessionImpl>(
          this, _$identity);
}

abstract class _QuestionSession implements QuestionSession {
  const factory _QuestionSession(
      {required final String sessionId,
      required final QuestionType type,
      required final List<String> questionIds,
      required final Map<String, String> userAnswers,
      required final Map<String, String> correctAnswers,
      required final DateTime startTime,
      final DateTime? endTime,
      final int currentIndex,
      final bool isCompleted}) = _$QuestionSessionImpl;

  @override
  String get sessionId;
  @override
  QuestionType get type;
  @override
  List<String> get questionIds;
  @override
  Map<String, String> get userAnswers;
  @override
  Map<String, String> get correctAnswers;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  int get currentIndex;
  @override
  bool get isCompleted;

  /// Create a copy of QuestionSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionSessionImplCopyWith<_$QuestionSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SessionResult {
  String get sessionId => throw _privateConstructorUsedError;
  QuestionType get type => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  Duration get timeTaken => throw _privateConstructorUsedError;
  Map<String, QuestionResult> get questionResults =>
      throw _privateConstructorUsedError;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionResultCopyWith<SessionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionResultCopyWith<$Res> {
  factory $SessionResultCopyWith(
          SessionResult value, $Res Function(SessionResult) then) =
      _$SessionResultCopyWithImpl<$Res, SessionResult>;
  @useResult
  $Res call(
      {String sessionId,
      QuestionType type,
      int totalQuestions,
      int correctAnswers,
      Duration timeTaken,
      Map<String, QuestionResult> questionResults});
}

/// @nodoc
class _$SessionResultCopyWithImpl<$Res, $Val extends SessionResult>
    implements $SessionResultCopyWith<$Res> {
  _$SessionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? type = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? timeTaken = null,
    Object? questionResults = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      timeTaken: null == timeTaken
          ? _value.timeTaken
          : timeTaken // ignore: cast_nullable_to_non_nullable
              as Duration,
      questionResults: null == questionResults
          ? _value.questionResults
          : questionResults // ignore: cast_nullable_to_non_nullable
              as Map<String, QuestionResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionResultImplCopyWith<$Res>
    implements $SessionResultCopyWith<$Res> {
  factory _$$SessionResultImplCopyWith(
          _$SessionResultImpl value, $Res Function(_$SessionResultImpl) then) =
      __$$SessionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      QuestionType type,
      int totalQuestions,
      int correctAnswers,
      Duration timeTaken,
      Map<String, QuestionResult> questionResults});
}

/// @nodoc
class __$$SessionResultImplCopyWithImpl<$Res>
    extends _$SessionResultCopyWithImpl<$Res, _$SessionResultImpl>
    implements _$$SessionResultImplCopyWith<$Res> {
  __$$SessionResultImplCopyWithImpl(
      _$SessionResultImpl _value, $Res Function(_$SessionResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? type = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? timeTaken = null,
    Object? questionResults = null,
  }) {
    return _then(_$SessionResultImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      timeTaken: null == timeTaken
          ? _value.timeTaken
          : timeTaken // ignore: cast_nullable_to_non_nullable
              as Duration,
      questionResults: null == questionResults
          ? _value._questionResults
          : questionResults // ignore: cast_nullable_to_non_nullable
              as Map<String, QuestionResult>,
    ));
  }
}

/// @nodoc

class _$SessionResultImpl implements _SessionResult {
  const _$SessionResultImpl(
      {required this.sessionId,
      required this.type,
      required this.totalQuestions,
      required this.correctAnswers,
      required this.timeTaken,
      required final Map<String, QuestionResult> questionResults})
      : _questionResults = questionResults;

  @override
  final String sessionId;
  @override
  final QuestionType type;
  @override
  final int totalQuestions;
  @override
  final int correctAnswers;
  @override
  final Duration timeTaken;
  final Map<String, QuestionResult> _questionResults;
  @override
  Map<String, QuestionResult> get questionResults {
    if (_questionResults is EqualUnmodifiableMapView) return _questionResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_questionResults);
  }

  @override
  String toString() {
    return 'SessionResult(sessionId: $sessionId, type: $type, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, timeTaken: $timeTaken, questionResults: $questionResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionResultImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.timeTaken, timeTaken) ||
                other.timeTaken == timeTaken) &&
            const DeepCollectionEquality()
                .equals(other._questionResults, _questionResults));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      type,
      totalQuestions,
      correctAnswers,
      timeTaken,
      const DeepCollectionEquality().hash(_questionResults));

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionResultImplCopyWith<_$SessionResultImpl> get copyWith =>
      __$$SessionResultImplCopyWithImpl<_$SessionResultImpl>(this, _$identity);
}

abstract class _SessionResult implements SessionResult {
  const factory _SessionResult(
          {required final String sessionId,
          required final QuestionType type,
          required final int totalQuestions,
          required final int correctAnswers,
          required final Duration timeTaken,
          required final Map<String, QuestionResult> questionResults}) =
      _$SessionResultImpl;

  @override
  String get sessionId;
  @override
  QuestionType get type;
  @override
  int get totalQuestions;
  @override
  int get correctAnswers;
  @override
  Duration get timeTaken;
  @override
  Map<String, QuestionResult> get questionResults;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionResultImplCopyWith<_$SessionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuestionResult {
  String get questionId => throw _privateConstructorUsedError;
  String get userAnswer => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  Duration get timeTaken => throw _privateConstructorUsedError;

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionResultCopyWith<QuestionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionResultCopyWith<$Res> {
  factory $QuestionResultCopyWith(
          QuestionResult value, $Res Function(QuestionResult) then) =
      _$QuestionResultCopyWithImpl<$Res, QuestionResult>;
  @useResult
  $Res call(
      {String questionId,
      String userAnswer,
      String correctAnswer,
      bool isCorrect,
      Duration timeTaken});
}

/// @nodoc
class _$QuestionResultCopyWithImpl<$Res, $Val extends QuestionResult>
    implements $QuestionResultCopyWith<$Res> {
  _$QuestionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? userAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
    Object? timeTaken = null,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      userAnswer: null == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      timeTaken: null == timeTaken
          ? _value.timeTaken
          : timeTaken // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionResultImplCopyWith<$Res>
    implements $QuestionResultCopyWith<$Res> {
  factory _$$QuestionResultImplCopyWith(_$QuestionResultImpl value,
          $Res Function(_$QuestionResultImpl) then) =
      __$$QuestionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String questionId,
      String userAnswer,
      String correctAnswer,
      bool isCorrect,
      Duration timeTaken});
}

/// @nodoc
class __$$QuestionResultImplCopyWithImpl<$Res>
    extends _$QuestionResultCopyWithImpl<$Res, _$QuestionResultImpl>
    implements _$$QuestionResultImplCopyWith<$Res> {
  __$$QuestionResultImplCopyWithImpl(
      _$QuestionResultImpl _value, $Res Function(_$QuestionResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? userAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
    Object? timeTaken = null,
  }) {
    return _then(_$QuestionResultImpl(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      userAnswer: null == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      timeTaken: null == timeTaken
          ? _value.timeTaken
          : timeTaken // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$QuestionResultImpl implements _QuestionResult {
  const _$QuestionResultImpl(
      {required this.questionId,
      required this.userAnswer,
      required this.correctAnswer,
      required this.isCorrect,
      required this.timeTaken});

  @override
  final String questionId;
  @override
  final String userAnswer;
  @override
  final String correctAnswer;
  @override
  final bool isCorrect;
  @override
  final Duration timeTaken;

  @override
  String toString() {
    return 'QuestionResult(questionId: $questionId, userAnswer: $userAnswer, correctAnswer: $correctAnswer, isCorrect: $isCorrect, timeTaken: $timeTaken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionResultImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.timeTaken, timeTaken) ||
                other.timeTaken == timeTaken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, questionId, userAnswer, correctAnswer, isCorrect, timeTaken);

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionResultImplCopyWith<_$QuestionResultImpl> get copyWith =>
      __$$QuestionResultImplCopyWithImpl<_$QuestionResultImpl>(
          this, _$identity);
}

abstract class _QuestionResult implements QuestionResult {
  const factory _QuestionResult(
      {required final String questionId,
      required final String userAnswer,
      required final String correctAnswer,
      required final bool isCorrect,
      required final Duration timeTaken}) = _$QuestionResultImpl;

  @override
  String get questionId;
  @override
  String get userAnswer;
  @override
  String get correctAnswer;
  @override
  bool get isCorrect;
  @override
  Duration get timeTaken;

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionResultImplCopyWith<_$QuestionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
