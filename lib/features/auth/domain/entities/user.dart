// filepath: /Users/ruo/projects/toeic4all/lib/features/auth/domain/entities/user.dart

// 로그인 제공자 열거형 추가
enum LoginProvider {
  username, // 아이디(username) 로그인
  google,   // 구글 로그인
  kakao,    // 카카오 로그인
  naver,    // 네이버 로그인
}

class User {
  final String id;
  final String username;
  final String email;
  final String role;
  final UserProfile profile;
  final UserStats stats;
  final UserSubscription subscription;
  final LoginProvider loginProvider; // 로그인 제공자 필드 추가
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.profile,
    required this.stats,
    required this.subscription,
    this.loginProvider = LoginProvider.username, // 기본값은 아이디 로그인
    this.createdAt,
    this.updatedAt,
  });

  // 소셜 로그인 사용자인지 확인하는 편의 메서드
  bool get isSocialLogin => 
      loginProvider == LoginProvider.google || 
      loginProvider == LoginProvider.kakao || 
      loginProvider == LoginProvider.naver;

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? role,
    UserProfile? profile,
    UserStats? stats,
    UserSubscription? subscription,
    LoginProvider? loginProvider,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      profile: profile ?? this.profile,
      stats: stats ?? this.stats,
      subscription: subscription ?? this.subscription,
      loginProvider: loginProvider ?? this.loginProvider,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserProfile {
  final String name;
  final String? profileImageUrl;
  final DateTime? dateOfBirth;
  final String? phone;
  final String? bio;
  final String? nationality;
  final String? targetScore;
  final String? currentLevel;
  final List<String> interests;

  const UserProfile({
    required this.name,
    this.profileImageUrl,
    this.dateOfBirth,
    this.phone,
    this.bio,
    this.nationality,
    this.targetScore,
    this.currentLevel,
    this.interests = const [],
  });

  UserProfile copyWith({
    String? name,
    String? profileImageUrl,
    DateTime? dateOfBirth,
    String? phone,
    String? bio,
    String? nationality,
    String? targetScore,
    String? currentLevel,
    List<String>? interests,
  }) {
    return UserProfile(
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      nationality: nationality ?? this.nationality,
      targetScore: targetScore ?? this.targetScore,
      currentLevel: currentLevel ?? this.currentLevel,
      interests: interests ?? this.interests,
    );
  }
}

class UserStats {
  final int totalTestsTaken;
  final int averageScore;
  final int bestScore;
  final Map<String, int> partScores;
  final int studyStreak;
  final int totalStudyTime;
  final DateTime? lastTestDate;
  final DateTime? lastStudyDate;

  const UserStats({
    this.totalTestsTaken = 0,
    this.averageScore = 0,
    this.bestScore = 0,
    this.partScores = const {},
    this.studyStreak = 0,
    this.totalStudyTime = 0,
    this.lastTestDate,
    this.lastStudyDate,
  });

  UserStats copyWith({
    int? totalTestsTaken,
    int? averageScore,
    int? bestScore,
    Map<String, int>? partScores,
    int? studyStreak,
    int? totalStudyTime,
    DateTime? lastTestDate,
    DateTime? lastStudyDate,
  }) {
    return UserStats(
      totalTestsTaken: totalTestsTaken ?? this.totalTestsTaken,
      averageScore: averageScore ?? this.averageScore,
      bestScore: bestScore ?? this.bestScore,
      partScores: partScores ?? this.partScores,
      studyStreak: studyStreak ?? this.studyStreak,
      totalStudyTime: totalStudyTime ?? this.totalStudyTime,
      lastTestDate: lastTestDate ?? this.lastTestDate,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
    );
  }
}

class UserSubscription {
  final String type;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;
  final String? paymentMethod;
  final Map<String, dynamic> features;

  const UserSubscription({
    this.type = 'free',
    this.startDate,
    this.endDate,
    this.isActive = false,
    this.paymentMethod,
    this.features = const {},
  });

  UserSubscription copyWith({
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    String? paymentMethod,
    Map<String, dynamic>? features,
  }) {
    return UserSubscription(
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      features: features ?? this.features,
    );
  }
}