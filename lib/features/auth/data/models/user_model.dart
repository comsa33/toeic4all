import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String username,
    required String email,
    required String role,
    required UserProfileModel profile,
    required UserStatsModel stats,
    required UserSubscriptionModel subscription,
    @Default(LoginProvider.username) LoginProvider loginProvider,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String name,
    String? profileImageUrl,
    DateTime? dateOfBirth,
    String? phone,
    String? bio,
    String? nationality,
    String? targetScore,
    String? currentLevel,
    @Default([]) List<String> interests,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}

@freezed
class UserStatsModel with _$UserStatsModel {
  const factory UserStatsModel({
    @Default(0) int totalTestsTaken,
    @Default(0) int averageScore,
    @Default(0) int bestScore,
    @Default({}) Map<String, int> partScores,
    @Default(0) int studyStreak,
    @Default(0) int totalStudyTime,
    DateTime? lastTestDate,
    DateTime? lastStudyDate,
  }) = _UserStatsModel;

  factory UserStatsModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatsModelFromJson(json);
}

@freezed
class UserSubscriptionModel with _$UserSubscriptionModel {
  const factory UserSubscriptionModel({
    @Default('free') String type,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isActive,
    String? paymentMethod,
    @Default({}) Map<String, dynamic> features,
  }) = _UserSubscriptionModel;

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      role: role,
      profile: profile.toEntity(),
      stats: stats.toEntity(),
      subscription: subscription.toEntity(),
      loginProvider: loginProvider,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserProfileModelX on UserProfileModel {
  UserProfile toEntity() {
    return UserProfile(
      name: name,
      profileImageUrl: profileImageUrl,
      dateOfBirth: dateOfBirth,
      phone: phone,
      bio: bio,
      nationality: nationality,
      targetScore: targetScore,
      currentLevel: currentLevel,
      interests: interests,
    );
  }
}

extension UserStatsModelX on UserStatsModel {
  UserStats toEntity() {
    return UserStats(
      totalTestsTaken: totalTestsTaken,
      averageScore: averageScore,
      bestScore: bestScore,
      partScores: partScores,
      studyStreak: studyStreak,
      totalStudyTime: totalStudyTime,
      lastTestDate: lastTestDate,
      lastStudyDate: lastStudyDate,
    );
  }
}

extension UserSubscriptionModelX on UserSubscriptionModel {
  UserSubscription toEntity() {
    return UserSubscription(
      type: type,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      paymentMethod: paymentMethod,
      features: features,
    );
  }
}

extension UserX on User {
  UserModel toModel() {
    return UserModel(
      id: id,
      username: username,
      email: email,
      role: role,
      profile: profile.toModel(),
      stats: stats.toModel(),
      subscription: subscription.toModel(),
      loginProvider: loginProvider,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserProfileX on UserProfile {
  UserProfileModel toModel() {
    return UserProfileModel(
      name: name,
      profileImageUrl: profileImageUrl,
      dateOfBirth: dateOfBirth,
      phone: phone,
      bio: bio,
      nationality: nationality,
      targetScore: targetScore,
      currentLevel: currentLevel,
      interests: interests,
    );
  }
}

extension UserStatsX on UserStats {
  UserStatsModel toModel() {
    return UserStatsModel(
      totalTestsTaken: totalTestsTaken,
      averageScore: averageScore,
      bestScore: bestScore,
      partScores: partScores,
      studyStreak: studyStreak,
      totalStudyTime: totalStudyTime,
      lastTestDate: lastTestDate,
      lastStudyDate: lastStudyDate,
    );
  }
}

extension UserSubscriptionX on UserSubscription {
  UserSubscriptionModel toModel() {
    return UserSubscriptionModel(
      type: type,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      paymentMethod: paymentMethod,
      features: features,
    );
  }
}
