import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/question_filter.dart';
import '../../domain/entities/question.dart';

class QuestionSessionState {
  final QuestionSession? currentSession;
  final bool isLoading;
  final String? error;

  const QuestionSessionState({
    this.currentSession,
    this.isLoading = false,
    this.error,
  });

  QuestionSessionState copyWith({
    QuestionSession? currentSession,
    bool? isLoading,
    String? error,
  }) {
    return QuestionSessionState(
      currentSession: currentSession ?? this.currentSession,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class QuestionSessionController extends StateNotifier<QuestionSessionState> {
  QuestionSessionController() : super(const QuestionSessionState());

  // Start Part 5 session
  void startPart5Session(List<Part5Question> questions) {
    final sessionId = const Uuid().v4();
    final questionIds = questions.map((q) => q.id).toList();
    
    final session = QuestionSession(
      sessionId: sessionId,
      type: QuestionType.part5,
      questionIds: questionIds,
      userAnswers: {},
      correctAnswers: {},
      startTime: DateTime.now(),
    );
    
    state = state.copyWith(currentSession: session);
  }

  // Start Part 6 session
  void startPart6Session(List<Part6Set> sets) {
    final sessionId = const Uuid().v4();
    final questionIds = <String>[];
    
    for (final set in sets) {
      for (final question in set.questions) {
        questionIds.add('${set.id}_${question.blankNumber}');
      }
    }
    
    final session = QuestionSession(
      sessionId: sessionId,
      type: QuestionType.part6,
      questionIds: questionIds,
      userAnswers: {},
      correctAnswers: {},
      startTime: DateTime.now(),
    );
    
    state = state.copyWith(currentSession: session);
  }

  // Start Part 7 session
  void startPart7Session(List<Part7Set> sets) {
    final sessionId = const Uuid().v4();
    final questionIds = <String>[];
    
    for (final set in sets) {
      for (final question in set.questions) {
        questionIds.add('${set.id}_${question.questionSeq}');
      }
    }
    
    final session = QuestionSession(
      sessionId: sessionId,
      type: QuestionType.part7,
      questionIds: questionIds,
      userAnswers: {},
      correctAnswers: {},
      startTime: DateTime.now(),
    );
    
    state = state.copyWith(currentSession: session);
  }

  // Submit answer
  void submitAnswer(String questionId, String answer) {
    final session = state.currentSession;
    if (session == null) return;

    final updatedAnswers = Map<String, String>.from(session.userAnswers);
    updatedAnswers[questionId] = answer;

    final updatedSession = session.copyWith(
      userAnswers: updatedAnswers,
    );

    state = state.copyWith(currentSession: updatedSession);
  }

  // Set correct answer (when viewing solution)
  void setCorrectAnswer(String questionId, String correctAnswer) {
    final session = state.currentSession;
    if (session == null) return;

    final updatedCorrectAnswers = Map<String, String>.from(session.correctAnswers);
    updatedCorrectAnswers[questionId] = correctAnswer;

    final updatedSession = session.copyWith(
      correctAnswers: updatedCorrectAnswers,
    );

    state = state.copyWith(currentSession: updatedSession);
  }

  // Move to next question
  void nextQuestion() {
    final session = state.currentSession;
    if (session == null) return;

    final nextIndex = session.currentIndex + 1;
    final isCompleted = nextIndex >= session.questionIds.length;

    final updatedSession = session.copyWith(
      currentIndex: nextIndex,
      isCompleted: isCompleted,
      endTime: isCompleted ? DateTime.now() : null,
    );

    state = state.copyWith(currentSession: updatedSession);
  }

  // Move to previous question
  void previousQuestion() {
    final session = state.currentSession;
    if (session == null || session.currentIndex <= 0) return;

    final updatedSession = session.copyWith(
      currentIndex: session.currentIndex - 1,
    );

    state = state.copyWith(currentSession: updatedSession);
  }

  // Jump to specific question
  void jumpToQuestion(int index) {
    final session = state.currentSession;
    if (session == null || index < 0 || index >= session.questionIds.length) return;

    final updatedSession = session.copyWith(
      currentIndex: index,
    );

    state = state.copyWith(currentSession: updatedSession);
  }

  // Get current question
  String? getCurrentQuestionId() {
    final session = state.currentSession;
    if (session == null || session.currentIndex >= session.questionIds.length) {
      return null;
    }
    return session.questionIds[session.currentIndex];
  }

  // Get user answer for current question
  String? getCurrentUserAnswer() {
    final session = state.currentSession;
    final questionId = getCurrentQuestionId();
    if (session == null || questionId == null) return null;
    
    return session.userAnswers[questionId];
  }

  // Complete session
  SessionResult? completeSession() {
    final session = state.currentSession;
    if (session == null) return null;

    final totalQuestions = session.questionIds.length;
    var correctAnswers = 0;
    final questionResults = <String, QuestionResult>{};

    for (final questionId in session.questionIds) {
      final userAnswer = session.userAnswers[questionId] ?? '';
      final correctAnswer = session.correctAnswers[questionId] ?? '';
      final isCorrect = userAnswer == correctAnswer && userAnswer.isNotEmpty;
      
      if (isCorrect) correctAnswers++;

      questionResults[questionId] = QuestionResult(
        questionId: questionId,
        userAnswer: userAnswer,
        correctAnswer: correctAnswer,
        isCorrect: isCorrect,
        timeTaken: const Duration(seconds: 0), // TODO: Track individual question time
      );
    }

    final endTime = session.endTime ?? DateTime.now();
    final timeTaken = endTime.difference(session.startTime);

    final result = SessionResult(
      sessionId: session.sessionId,
      type: session.type,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      timeTaken: timeTaken,
      questionResults: questionResults,
    );

    // Clear current session
    state = const QuestionSessionState();

    return result;
  }

  // Reset session
  void resetSession() {
    state = const QuestionSessionState();
  }
}

final questionSessionControllerProvider = StateNotifierProvider<QuestionSessionController, QuestionSessionState>((ref) {
  return QuestionSessionController();
});
