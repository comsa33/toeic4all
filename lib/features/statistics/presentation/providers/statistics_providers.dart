import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../questions/domain/entities/question_filter.dart';

// 통계 데이터 모델
class StatisticsData {
  final int totalQuestions;
  final double averageAccuracy;
  final int studyStreak;
  final int estimatedScore;
  final Map<String, int> partScores;
  final List<RecentQuizResult> recentResults;
  final Map<String, double> weeklyProgress;
  final int totalStudyTime;
  final List<String> weaknesses;

  const StatisticsData({
    required this.totalQuestions,
    required this.averageAccuracy,
    required this.studyStreak,
    required this.estimatedScore,
    required this.partScores,
    required this.recentResults,
    required this.weeklyProgress,
    required this.totalStudyTime,
    required this.weaknesses,
  });
}

class RecentQuizResult {
  final String sessionId;
  final QuestionType type;
  final int score;
  final double accuracy;
  final DateTime date;

  const RecentQuizResult({
    required this.sessionId,
    required this.type,
    required this.score,
    required this.accuracy,
    required this.date,
  });
}

class PartStatistics {
  final QuestionType type;
  final int totalQuestions;
  final int correctAnswers;
  final double accuracy;
  final int averageTime;
  final List<String> strongTopics;
  final List<String> weakTopics;

  const PartStatistics({
    required this.type,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.accuracy,
    required this.averageTime,
    required this.strongTopics,
    required this.weakTopics,
  });
}

// 통계 데이터 Provider
final statisticsDataProvider = FutureProvider<StatisticsData>((ref) async {
  final authState = ref.watch(authControllerProvider);
  
  if (!authState.isAuthenticated || authState.user == null) {
    // 로그인하지 않은 상태에서는 샘플 데이터 반환
    return _getSampleStatisticsData();
  }

  // 실제 사용자 데이터가 있을 경우 해당 데이터 사용
  final userStats = authState.user!.stats;
  
  return StatisticsData(
    totalQuestions: userStats.totalTestsTaken * 10, // 평균 10문제씩 가정
    averageAccuracy: userStats.averageScore / 100.0 * 0.8, // TOEIC 점수를 정답률로 변환
    studyStreak: userStats.studyStreak,
    estimatedScore: userStats.averageScore > 0 ? userStats.averageScore : 450,
    partScores: {
      'Part 5': userStats.partScores['part5'] ?? 0,
      'Part 6': userStats.partScores['part6'] ?? 0,
      'Part 7': userStats.partScores['part7'] ?? 0,
    },
    recentResults: _generateRecentResults(),
    weeklyProgress: _generateWeeklyProgress(),
    totalStudyTime: userStats.totalStudyTime,
    weaknesses: _generateWeaknesses(),
  );
});

// Part별 통계 Provider
final partStatisticsProvider = FutureProvider.family<List<PartStatistics>, QuestionType?>((ref, filterType) async {
  // 샘플 데이터 또는 실제 데이터 반환
  return _generatePartStatistics(filterType);
});

// 최근 퀴즈 결과 Provider
final recentQuizResultsProvider = FutureProvider<List<RecentQuizResult>>((ref) async {
  // 실제로는 데이터베이스에서 가져와야 함
  return _generateRecentResults();
});

// 주간 진도 Provider
final weeklyProgressProvider = FutureProvider<Map<String, double>>((ref) async {
  // 실제로는 데이터베이스에서 가져와야 함
  return _generateWeeklyProgress();
});

// 학습 스트릭 Provider
final studyStreakProvider = FutureProvider<int>((ref) async {
  final authState = ref.watch(authControllerProvider);
  return authState.user?.stats.studyStreak ?? 0;
});

// Helper functions for generating sample data
StatisticsData _getSampleStatisticsData() {
  return StatisticsData(
    totalQuestions: 2547,
    averageAccuracy: 0.72,
    studyStreak: 7,
    estimatedScore: 650,
    partScores: {
      'Part 5': 78,
      'Part 6': 85,
      'Part 7': 67,
    },
    recentResults: _generateRecentResults(),
    weeklyProgress: _generateWeeklyProgress(),
    totalStudyTime: 18450, // 초 단위
    weaknesses: _generateWeaknesses(),
  );
}

List<RecentQuizResult> _generateRecentResults() {
  final now = DateTime.now();
  return [
    RecentQuizResult(
      sessionId: '1',
      type: QuestionType.part5,
      score: 85,
      accuracy: 0.85,
      date: now.subtract(const Duration(hours: 2)),
    ),
    RecentQuizResult(
      sessionId: '2',
      type: QuestionType.part6,
      score: 90,
      accuracy: 0.90,
      date: now.subtract(const Duration(days: 1)),
    ),
    RecentQuizResult(
      sessionId: '3',
      type: QuestionType.part7,
      score: 75,
      accuracy: 0.75,
      date: now.subtract(const Duration(days: 2)),
    ),
    RecentQuizResult(
      sessionId: '4',
      type: QuestionType.part5,
      score: 80,
      accuracy: 0.80,
      date: now.subtract(const Duration(days: 3)),
    ),
    RecentQuizResult(
      sessionId: '5',
      type: QuestionType.part6,
      score: 95,
      accuracy: 0.95,
      date: now.subtract(const Duration(days: 4)),
    ),
  ];
}

Map<String, double> _generateWeeklyProgress() {
  return {
    '월': 0.68,
    '화': 0.72,
    '수': 0.75,
    '목': 0.78,
    '금': 0.82,
    '토': 0.85,
    '일': 0.88,
  };
}

List<String> _generateWeaknesses() {
  return [
    '관계사 문제',
    '시제 일치',
    '장문 독해의 세부 정보',
    '어휘 선택',
  ];
}

List<PartStatistics> _generatePartStatistics(QuestionType? filterType) {
  final allStats = [
    PartStatistics(
      type: QuestionType.part5,
      totalQuestions: 1250,
      correctAnswers: 975,
      accuracy: 0.78,
      averageTime: 45,
      strongTopics: ['전치사', '접속사', '관사'],
      weakTopics: ['관계사', '시제', '가정법'],
    ),
    PartStatistics(
      type: QuestionType.part6,
      totalQuestions: 648,
      correctAnswers: 551,
      accuracy: 0.85,
      averageTime: 90,
      strongTopics: ['빈칸 추론', '문맥 파악'],
      weakTopics: ['어휘 선택', '연결어'],
    ),
    PartStatistics(
      type: QuestionType.part7,
      totalQuestions: 649,
      correctAnswers: 435,
      accuracy: 0.67,
      averageTime: 120,
      strongTopics: ['주제 파악', '세부 정보'],
      weakTopics: ['추론', '어휘 의미', '복합 지문'],
    ),
  ];

  if (filterType != null) {
    return allStats.where((stat) => stat.type == filterType).toList();
  }
  
  return allStats;
}
