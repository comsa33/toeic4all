import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_filter.freezed.dart';

@freezed
class QuestionFilter with _$QuestionFilter {
  const factory QuestionFilter({
    @Default(null) String? category,
    @Default(null) String? subtype,
    @Default(null) String? difficulty,
    @Default(null) String? passageType,
    @Default(null) String? setType,
    @Default(null) List<String>? passageTypes,
    @Default(10) int limit,
    @Default(1) int page,
  }) = _QuestionFilter;
}

@freezed
class QuestionSession with _$QuestionSession {
  const factory QuestionSession({
    required String sessionId,
    required QuestionType type,
    required List<String> questionIds,
    required Map<String, String> userAnswers,
    required Map<String, String> correctAnswers,
    required DateTime startTime,
    DateTime? endTime,
    @Default(0) int currentIndex,
    @Default(false) bool isCompleted,
  }) = _QuestionSession;
}

enum QuestionType {
  part5,
  part6,
  part7,
}

@freezed
class SessionResult with _$SessionResult {
  const factory SessionResult({
    required String sessionId,
    required QuestionType type,
    required int totalQuestions,
    required int correctAnswers,
    required Duration timeTaken,
    required Map<String, QuestionResult> questionResults,
  }) = _SessionResult;
}

@freezed
class QuestionResult with _$QuestionResult {
  const factory QuestionResult({
    required String questionId,
    required String userAnswer,
    required String correctAnswer,
    required bool isCorrect,
    required Duration timeTaken,
  }) = _QuestionResult;
}
