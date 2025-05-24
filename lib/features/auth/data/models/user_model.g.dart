// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      profile:
          UserProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      stats: UserStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      subscription: UserSubscriptionModel.fromJson(
          json['subscription'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'profile': instance.profile,
      'stats': instance.stats,
      'subscription': instance.subscription,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileModelImpl(
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
      nationality: json['nationality'] as String?,
      targetScore: json['targetScore'] as String?,
      currentLevel: json['currentLevel'] as String?,
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'phone': instance.phone,
      'bio': instance.bio,
      'nationality': instance.nationality,
      'targetScore': instance.targetScore,
      'currentLevel': instance.currentLevel,
      'interests': instance.interests,
    };

_$UserStatsModelImpl _$$UserStatsModelImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsModelImpl(
      totalTestsTaken: (json['totalTestsTaken'] as num?)?.toInt() ?? 0,
      averageScore: (json['averageScore'] as num?)?.toInt() ?? 0,
      bestScore: (json['bestScore'] as num?)?.toInt() ?? 0,
      partScores: (json['partScores'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      studyStreak: (json['studyStreak'] as num?)?.toInt() ?? 0,
      totalStudyTime: (json['totalStudyTime'] as num?)?.toInt() ?? 0,
      lastTestDate: json['lastTestDate'] == null
          ? null
          : DateTime.parse(json['lastTestDate'] as String),
      lastStudyDate: json['lastStudyDate'] == null
          ? null
          : DateTime.parse(json['lastStudyDate'] as String),
    );

Map<String, dynamic> _$$UserStatsModelImplToJson(
        _$UserStatsModelImpl instance) =>
    <String, dynamic>{
      'totalTestsTaken': instance.totalTestsTaken,
      'averageScore': instance.averageScore,
      'bestScore': instance.bestScore,
      'partScores': instance.partScores,
      'studyStreak': instance.studyStreak,
      'totalStudyTime': instance.totalStudyTime,
      'lastTestDate': instance.lastTestDate?.toIso8601String(),
      'lastStudyDate': instance.lastStudyDate?.toIso8601String(),
    };

_$UserSubscriptionModelImpl _$$UserSubscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserSubscriptionModelImpl(
      type: json['type'] as String? ?? 'free',
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? false,
      paymentMethod: json['paymentMethod'] as String?,
      features: json['features'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserSubscriptionModelImplToJson(
        _$UserSubscriptionModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
      'paymentMethod': instance.paymentMethod,
      'features': instance.features,
    };
