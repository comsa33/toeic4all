// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  UserProfileModel get profile => throw _privateConstructorUsedError;
  UserStatsModel get stats => throw _privateConstructorUsedError;
  UserSubscriptionModel get subscription => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String role,
      UserProfileModel profile,
      UserStatsModel stats,
      UserSubscriptionModel subscription,
      DateTime? createdAt,
      DateTime? updatedAt});

  $UserProfileModelCopyWith<$Res> get profile;
  $UserStatsModelCopyWith<$Res> get stats;
  $UserSubscriptionModelCopyWith<$Res> get subscription;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? role = null,
    Object? profile = null,
    Object? stats = null,
    Object? subscription = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfileModel,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStatsModel,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as UserSubscriptionModel,
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

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileModelCopyWith<$Res> get profile {
    return $UserProfileModelCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatsModelCopyWith<$Res> get stats {
    return $UserStatsModelCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSubscriptionModelCopyWith<$Res> get subscription {
    return $UserSubscriptionModelCopyWith<$Res>(_value.subscription, (value) {
      return _then(_value.copyWith(subscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String role,
      UserProfileModel profile,
      UserStatsModel stats,
      UserSubscriptionModel subscription,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $UserProfileModelCopyWith<$Res> get profile;
  @override
  $UserStatsModelCopyWith<$Res> get stats;
  @override
  $UserSubscriptionModelCopyWith<$Res> get subscription;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? role = null,
    Object? profile = null,
    Object? stats = null,
    Object? subscription = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfileModel,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStatsModel,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as UserSubscriptionModel,
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
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.username,
      required this.email,
      required this.role,
      required this.profile,
      required this.stats,
      required this.subscription,
      this.createdAt,
      this.updatedAt});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String role;
  @override
  final UserProfileModel profile;
  @override
  final UserStatsModel stats;
  @override
  final UserSubscriptionModel subscription;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, role: $role, profile: $profile, stats: $stats, subscription: $subscription, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, email, role,
      profile, stats, subscription, createdAt, updatedAt);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String username,
      required final String email,
      required final String role,
      required final UserProfileModel profile,
      required final UserStatsModel stats,
      required final UserSubscriptionModel subscription,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get role;
  @override
  UserProfileModel get profile;
  @override
  UserStatsModel get stats;
  @override
  UserSubscriptionModel get subscription;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  String get name => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  String? get targetScore => throw _privateConstructorUsedError;
  String? get currentLevel => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
          UserProfileModel value, $Res Function(UserProfileModel) then) =
      _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call(
      {String name,
      String? profileImageUrl,
      DateTime? dateOfBirth,
      String? phone,
      String? bio,
      String? nationality,
      String? targetScore,
      String? currentLevel,
      List<String> interests});
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? profileImageUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? phone = freezed,
    Object? bio = freezed,
    Object? nationality = freezed,
    Object? targetScore = freezed,
    Object? currentLevel = freezed,
    Object? interests = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      targetScore: freezed == targetScore
          ? _value.targetScore
          : targetScore // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(_$UserProfileModelImpl value,
          $Res Function(_$UserProfileModelImpl) then) =
      __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? profileImageUrl,
      DateTime? dateOfBirth,
      String? phone,
      String? bio,
      String? nationality,
      String? targetScore,
      String? currentLevel,
      List<String> interests});
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(_$UserProfileModelImpl _value,
      $Res Function(_$UserProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? profileImageUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? phone = freezed,
    Object? bio = freezed,
    Object? nationality = freezed,
    Object? targetScore = freezed,
    Object? currentLevel = freezed,
    Object? interests = null,
  }) {
    return _then(_$UserProfileModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      targetScore: freezed == targetScore
          ? _value.targetScore
          : targetScore // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl implements _UserProfileModel {
  const _$UserProfileModelImpl(
      {required this.name,
      this.profileImageUrl,
      this.dateOfBirth,
      this.phone,
      this.bio,
      this.nationality,
      this.targetScore,
      this.currentLevel,
      final List<String> interests = const []})
      : _interests = interests;

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? profileImageUrl;
  @override
  final DateTime? dateOfBirth;
  @override
  final String? phone;
  @override
  final String? bio;
  @override
  final String? nationality;
  @override
  final String? targetScore;
  @override
  final String? currentLevel;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  String toString() {
    return 'UserProfileModel(name: $name, profileImageUrl: $profileImageUrl, dateOfBirth: $dateOfBirth, phone: $phone, bio: $bio, nationality: $nationality, targetScore: $targetScore, currentLevel: $currentLevel, interests: $interests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.targetScore, targetScore) ||
                other.targetScore == targetScore) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      profileImageUrl,
      dateOfBirth,
      phone,
      bio,
      nationality,
      targetScore,
      currentLevel,
      const DeepCollectionEquality().hash(_interests));

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(
      this,
    );
  }
}

abstract class _UserProfileModel implements UserProfileModel {
  const factory _UserProfileModel(
      {required final String name,
      final String? profileImageUrl,
      final DateTime? dateOfBirth,
      final String? phone,
      final String? bio,
      final String? nationality,
      final String? targetScore,
      final String? currentLevel,
      final List<String> interests}) = _$UserProfileModelImpl;

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get profileImageUrl;
  @override
  DateTime? get dateOfBirth;
  @override
  String? get phone;
  @override
  String? get bio;
  @override
  String? get nationality;
  @override
  String? get targetScore;
  @override
  String? get currentLevel;
  @override
  List<String> get interests;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStatsModel _$UserStatsModelFromJson(Map<String, dynamic> json) {
  return _UserStatsModel.fromJson(json);
}

/// @nodoc
mixin _$UserStatsModel {
  int get totalTestsTaken => throw _privateConstructorUsedError;
  int get averageScore => throw _privateConstructorUsedError;
  int get bestScore => throw _privateConstructorUsedError;
  Map<String, int> get partScores => throw _privateConstructorUsedError;
  int get studyStreak => throw _privateConstructorUsedError;
  int get totalStudyTime => throw _privateConstructorUsedError;
  DateTime? get lastTestDate => throw _privateConstructorUsedError;
  DateTime? get lastStudyDate => throw _privateConstructorUsedError;

  /// Serializes this UserStatsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsModelCopyWith<UserStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsModelCopyWith<$Res> {
  factory $UserStatsModelCopyWith(
          UserStatsModel value, $Res Function(UserStatsModel) then) =
      _$UserStatsModelCopyWithImpl<$Res, UserStatsModel>;
  @useResult
  $Res call(
      {int totalTestsTaken,
      int averageScore,
      int bestScore,
      Map<String, int> partScores,
      int studyStreak,
      int totalStudyTime,
      DateTime? lastTestDate,
      DateTime? lastStudyDate});
}

/// @nodoc
class _$UserStatsModelCopyWithImpl<$Res, $Val extends UserStatsModel>
    implements $UserStatsModelCopyWith<$Res> {
  _$UserStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTestsTaken = null,
    Object? averageScore = null,
    Object? bestScore = null,
    Object? partScores = null,
    Object? studyStreak = null,
    Object? totalStudyTime = null,
    Object? lastTestDate = freezed,
    Object? lastStudyDate = freezed,
  }) {
    return _then(_value.copyWith(
      totalTestsTaken: null == totalTestsTaken
          ? _value.totalTestsTaken
          : totalTestsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      partScores: null == partScores
          ? _value.partScores
          : partScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      studyStreak: null == studyStreak
          ? _value.studyStreak
          : studyStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalStudyTime: null == totalStudyTime
          ? _value.totalStudyTime
          : totalStudyTime // ignore: cast_nullable_to_non_nullable
              as int,
      lastTestDate: freezed == lastTestDate
          ? _value.lastTestDate
          : lastTestDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastStudyDate: freezed == lastStudyDate
          ? _value.lastStudyDate
          : lastStudyDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatsModelImplCopyWith<$Res>
    implements $UserStatsModelCopyWith<$Res> {
  factory _$$UserStatsModelImplCopyWith(_$UserStatsModelImpl value,
          $Res Function(_$UserStatsModelImpl) then) =
      __$$UserStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalTestsTaken,
      int averageScore,
      int bestScore,
      Map<String, int> partScores,
      int studyStreak,
      int totalStudyTime,
      DateTime? lastTestDate,
      DateTime? lastStudyDate});
}

/// @nodoc
class __$$UserStatsModelImplCopyWithImpl<$Res>
    extends _$UserStatsModelCopyWithImpl<$Res, _$UserStatsModelImpl>
    implements _$$UserStatsModelImplCopyWith<$Res> {
  __$$UserStatsModelImplCopyWithImpl(
      _$UserStatsModelImpl _value, $Res Function(_$UserStatsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTestsTaken = null,
    Object? averageScore = null,
    Object? bestScore = null,
    Object? partScores = null,
    Object? studyStreak = null,
    Object? totalStudyTime = null,
    Object? lastTestDate = freezed,
    Object? lastStudyDate = freezed,
  }) {
    return _then(_$UserStatsModelImpl(
      totalTestsTaken: null == totalTestsTaken
          ? _value.totalTestsTaken
          : totalTestsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      partScores: null == partScores
          ? _value._partScores
          : partScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      studyStreak: null == studyStreak
          ? _value.studyStreak
          : studyStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalStudyTime: null == totalStudyTime
          ? _value.totalStudyTime
          : totalStudyTime // ignore: cast_nullable_to_non_nullable
              as int,
      lastTestDate: freezed == lastTestDate
          ? _value.lastTestDate
          : lastTestDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastStudyDate: freezed == lastStudyDate
          ? _value.lastStudyDate
          : lastStudyDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsModelImpl implements _UserStatsModel {
  const _$UserStatsModelImpl(
      {this.totalTestsTaken = 0,
      this.averageScore = 0,
      this.bestScore = 0,
      final Map<String, int> partScores = const {},
      this.studyStreak = 0,
      this.totalStudyTime = 0,
      this.lastTestDate,
      this.lastStudyDate})
      : _partScores = partScores;

  factory _$UserStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsModelImplFromJson(json);

  @override
  @JsonKey()
  final int totalTestsTaken;
  @override
  @JsonKey()
  final int averageScore;
  @override
  @JsonKey()
  final int bestScore;
  final Map<String, int> _partScores;
  @override
  @JsonKey()
  Map<String, int> get partScores {
    if (_partScores is EqualUnmodifiableMapView) return _partScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_partScores);
  }

  @override
  @JsonKey()
  final int studyStreak;
  @override
  @JsonKey()
  final int totalStudyTime;
  @override
  final DateTime? lastTestDate;
  @override
  final DateTime? lastStudyDate;

  @override
  String toString() {
    return 'UserStatsModel(totalTestsTaken: $totalTestsTaken, averageScore: $averageScore, bestScore: $bestScore, partScores: $partScores, studyStreak: $studyStreak, totalStudyTime: $totalStudyTime, lastTestDate: $lastTestDate, lastStudyDate: $lastStudyDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsModelImpl &&
            (identical(other.totalTestsTaken, totalTestsTaken) ||
                other.totalTestsTaken == totalTestsTaken) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.bestScore, bestScore) ||
                other.bestScore == bestScore) &&
            const DeepCollectionEquality()
                .equals(other._partScores, _partScores) &&
            (identical(other.studyStreak, studyStreak) ||
                other.studyStreak == studyStreak) &&
            (identical(other.totalStudyTime, totalStudyTime) ||
                other.totalStudyTime == totalStudyTime) &&
            (identical(other.lastTestDate, lastTestDate) ||
                other.lastTestDate == lastTestDate) &&
            (identical(other.lastStudyDate, lastStudyDate) ||
                other.lastStudyDate == lastStudyDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalTestsTaken,
      averageScore,
      bestScore,
      const DeepCollectionEquality().hash(_partScores),
      studyStreak,
      totalStudyTime,
      lastTestDate,
      lastStudyDate);

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsModelImplCopyWith<_$UserStatsModelImpl> get copyWith =>
      __$$UserStatsModelImplCopyWithImpl<_$UserStatsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsModelImplToJson(
      this,
    );
  }
}

abstract class _UserStatsModel implements UserStatsModel {
  const factory _UserStatsModel(
      {final int totalTestsTaken,
      final int averageScore,
      final int bestScore,
      final Map<String, int> partScores,
      final int studyStreak,
      final int totalStudyTime,
      final DateTime? lastTestDate,
      final DateTime? lastStudyDate}) = _$UserStatsModelImpl;

  factory _UserStatsModel.fromJson(Map<String, dynamic> json) =
      _$UserStatsModelImpl.fromJson;

  @override
  int get totalTestsTaken;
  @override
  int get averageScore;
  @override
  int get bestScore;
  @override
  Map<String, int> get partScores;
  @override
  int get studyStreak;
  @override
  int get totalStudyTime;
  @override
  DateTime? get lastTestDate;
  @override
  DateTime? get lastStudyDate;

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsModelImplCopyWith<_$UserStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSubscriptionModel _$UserSubscriptionModelFromJson(
    Map<String, dynamic> json) {
  return _UserSubscriptionModel.fromJson(json);
}

/// @nodoc
mixin _$UserSubscriptionModel {
  String get type => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  Map<String, dynamic> get features => throw _privateConstructorUsedError;

  /// Serializes this UserSubscriptionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSubscriptionModelCopyWith<UserSubscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSubscriptionModelCopyWith<$Res> {
  factory $UserSubscriptionModelCopyWith(UserSubscriptionModel value,
          $Res Function(UserSubscriptionModel) then) =
      _$UserSubscriptionModelCopyWithImpl<$Res, UserSubscriptionModel>;
  @useResult
  $Res call(
      {String type,
      DateTime? startDate,
      DateTime? endDate,
      bool isActive,
      String? paymentMethod,
      Map<String, dynamic> features});
}

/// @nodoc
class _$UserSubscriptionModelCopyWithImpl<$Res,
        $Val extends UserSubscriptionModel>
    implements $UserSubscriptionModelCopyWith<$Res> {
  _$UserSubscriptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? paymentMethod = freezed,
    Object? features = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSubscriptionModelImplCopyWith<$Res>
    implements $UserSubscriptionModelCopyWith<$Res> {
  factory _$$UserSubscriptionModelImplCopyWith(
          _$UserSubscriptionModelImpl value,
          $Res Function(_$UserSubscriptionModelImpl) then) =
      __$$UserSubscriptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      DateTime? startDate,
      DateTime? endDate,
      bool isActive,
      String? paymentMethod,
      Map<String, dynamic> features});
}

/// @nodoc
class __$$UserSubscriptionModelImplCopyWithImpl<$Res>
    extends _$UserSubscriptionModelCopyWithImpl<$Res,
        _$UserSubscriptionModelImpl>
    implements _$$UserSubscriptionModelImplCopyWith<$Res> {
  __$$UserSubscriptionModelImplCopyWithImpl(_$UserSubscriptionModelImpl _value,
      $Res Function(_$UserSubscriptionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? paymentMethod = freezed,
    Object? features = null,
  }) {
    return _then(_$UserSubscriptionModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSubscriptionModelImpl implements _UserSubscriptionModel {
  const _$UserSubscriptionModelImpl(
      {this.type = 'free',
      this.startDate,
      this.endDate,
      this.isActive = false,
      this.paymentMethod,
      final Map<String, dynamic> features = const {}})
      : _features = features;

  factory _$UserSubscriptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSubscriptionModelImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? paymentMethod;
  final Map<String, dynamic> _features;
  @override
  @JsonKey()
  Map<String, dynamic> get features {
    if (_features is EqualUnmodifiableMapView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_features);
  }

  @override
  String toString() {
    return 'UserSubscriptionModel(type: $type, startDate: $startDate, endDate: $endDate, isActive: $isActive, paymentMethod: $paymentMethod, features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSubscriptionModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, startDate, endDate,
      isActive, paymentMethod, const DeepCollectionEquality().hash(_features));

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSubscriptionModelImplCopyWith<_$UserSubscriptionModelImpl>
      get copyWith => __$$UserSubscriptionModelImplCopyWithImpl<
          _$UserSubscriptionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSubscriptionModelImplToJson(
      this,
    );
  }
}

abstract class _UserSubscriptionModel implements UserSubscriptionModel {
  const factory _UserSubscriptionModel(
      {final String type,
      final DateTime? startDate,
      final DateTime? endDate,
      final bool isActive,
      final String? paymentMethod,
      final Map<String, dynamic> features}) = _$UserSubscriptionModelImpl;

  factory _UserSubscriptionModel.fromJson(Map<String, dynamic> json) =
      _$UserSubscriptionModelImpl.fromJson;

  @override
  String get type;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isActive;
  @override
  String? get paymentMethod;
  @override
  Map<String, dynamic> get features;

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSubscriptionModelImplCopyWith<_$UserSubscriptionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
