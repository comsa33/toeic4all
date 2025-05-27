import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic4all/features/statistics/presentation/providers/statistics_providers.dart';

void main() {
  group('Statistics Providers Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('statisticsDataProvider should return valid data', () async {
      final statisticsData = await container.read(statisticsDataProvider.future);
      
      expect(statisticsData.totalQuestions, greaterThan(0));
      expect(statisticsData.averageAccuracy, greaterThanOrEqualTo(0.0));
      expect(statisticsData.averageAccuracy, lessThanOrEqualTo(1.0));
      expect(statisticsData.studyStreak, greaterThanOrEqualTo(0));
      expect(statisticsData.estimatedScore, greaterThan(0));
      expect(statisticsData.partScores, isNotEmpty);
      expect(statisticsData.recentResults, isNotEmpty);
      expect(statisticsData.weeklyProgress, isNotEmpty);
    });

    test('partStatisticsProvider should return valid part statistics', () async {
      final partStats = await container.read(partStatisticsProvider(null).future);
      
      expect(partStats, isNotEmpty);
      expect(partStats.length, equals(3)); // Part 5, 6, 7
      
      for (final stat in partStats) {
        expect(stat.totalQuestions, greaterThan(0));
        expect(stat.correctAnswers, greaterThanOrEqualTo(0));
        expect(stat.correctAnswers, lessThanOrEqualTo(stat.totalQuestions));
        expect(stat.accuracy, greaterThanOrEqualTo(0.0));
        expect(stat.accuracy, lessThanOrEqualTo(1.0));
        expect(stat.averageTime, greaterThan(0));
        expect(stat.strongTopics, isNotEmpty);
        expect(stat.weakTopics, isNotEmpty);
      }
    });

    test('recentQuizResultsProvider should return valid quiz results', () async {
      final recentResults = await container.read(recentQuizResultsProvider.future);
      
      expect(recentResults, isNotEmpty);
      
      for (final result in recentResults) {
        expect(result.sessionId, isNotEmpty);
        expect(result.score, greaterThanOrEqualTo(0));
        expect(result.score, lessThanOrEqualTo(100));
        expect(result.accuracy, greaterThanOrEqualTo(0.0));
        expect(result.accuracy, lessThanOrEqualTo(1.0));
        expect(result.date, isNotNull);
      }
    });

    test('weeklyProgressProvider should return valid weekly progress', () async {
      final weeklyProgress = await container.read(weeklyProgressProvider.future);
      
      expect(weeklyProgress, isNotEmpty);
      
      for (final entry in weeklyProgress.entries) {
        expect(entry.key, isNotEmpty);
        expect(entry.value, greaterThanOrEqualTo(0.0));
        expect(entry.value, lessThanOrEqualTo(1.0));
      }
    });

    test('studyStreakProvider should return valid study streak', () async {
      final studyStreak = await container.read(studyStreakProvider.future);
      
      expect(studyStreak, greaterThanOrEqualTo(0));
    });
  });
}
