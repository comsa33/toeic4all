import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/question_filter.dart';
import '../../domain/entities/question.dart';
import '../providers/questions_providers.dart';
import '../controllers/question_session_controller.dart';
import '../widgets/question_progress_bar.dart';
import '../widgets/choice_button.dart';
import '../../../../shared/widgets/app_button.dart';

class Part5QuizScreen extends ConsumerStatefulWidget {
  final QuestionFilter filter;

  const Part5QuizScreen({
    super.key,
    required this.filter,
  });

  @override
  ConsumerState<Part5QuizScreen> createState() => _Part5QuizScreenState();
}

class _Part5QuizScreenState extends ConsumerState<Part5QuizScreen> {
  bool _showAnswer = false;
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    final questionsAsync = ref.watch(part5QuestionsProvider(widget.filter));
    final sessionState = ref.watch(questionSessionControllerProvider);
    final sessionController = ref.read(questionSessionControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Part 5'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitDialog(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: questionsAsync.when(
        data: (questions) {
          if (questions.isEmpty) {
            return _EmptyState();
          }

          // Initialize session if not started
          if (sessionState.currentSession == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              sessionController.startPart5Session(questions);
            });
            return const Center(child: CircularProgressIndicator());
          }

          final session = sessionState.currentSession!;
          final currentQuestion = questions[session.currentIndex];
          final userAnswer = sessionController.getCurrentUserAnswer();

          return Column(
            children: [
              // Progress bar
              QuestionProgressBar(
                current: session.currentIndex + 1,
                total: questions.length,
                answered: session.userAnswers.length,
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Question info
                      _QuestionInfo(question: currentQuestion),
                      
                      const SizedBox(height: 24),
                      
                      // Question text
                      _QuestionText(question: currentQuestion),
                      
                      const SizedBox(height: 24),
                      
                      // Choices
                      ...currentQuestion.choices.asMap().entries.map((entry) {
                        final index = entry.key;
                        final choice = entry.value;
                        final choiceLabel = String.fromCharCode(65 + index); // A, B, C, D
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ChoiceButton(
                            label: choiceLabel,
                            text: choice.text,
                            translation: choice.translation,
                            isSelected: _selectedChoice == choice.id,
                            isCorrect: _showAnswer ? choice.id == userAnswer : null,
                            onTap: _showAnswer ? null : () {
                              setState(() {
                                _selectedChoice = choice.id;
                              });
                              sessionController.submitAnswer(currentQuestion.id, choice.id);
                            },
                          ),
                        );
                      }),
                      
                      const SizedBox(height: 24),
                      
                      // Answer section
                      if (_showAnswer) _AnswerSection(questionId: currentQuestion.id),
                    ],
                  ),
                ),
              ),
              
              // Bottom navigation
              _BottomNavigation(
                hasAnswer: userAnswer != null,
                showAnswer: _showAnswer,
                onShowAnswer: () {
                  setState(() {
                    _showAnswer = true;
                  });
                },
                onNext: () {
                  sessionController.nextQuestion();
                  setState(() {
                    _showAnswer = false;
                    _selectedChoice = null;
                  });
                },
                onPrevious: session.currentIndex > 0 ? () {
                  sessionController.previousQuestion();
                  setState(() {
                    _showAnswer = false;
                    _selectedChoice = sessionController.getCurrentUserAnswer();
                  });
                } : null,
                isLastQuestion: session.currentIndex >= questions.length - 1,
                onComplete: () => _completeQuiz(context),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _ErrorState(error.toString()),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('퀴즈 종료'),
        content: const Text('정말로 퀴즈를 종료하시겠습니까?\n진행 상황이 저장되지 않습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('계속하기'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(questionSessionControllerProvider.notifier).resetSession();
              context.pop();
            },
            child: const Text('종료'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Part 5 도움말'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• 문장의 빈 칸에 들어갈 가장 적절한 답을 선택하세요'),
            SizedBox(height: 8),
            Text('• 문법과 어휘 지식을 활용하세요'),
            SizedBox(height: 8),
            Text('• 답안 확인 후 해설을 참고하세요'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _completeQuiz(BuildContext context) {
    final sessionController = ref.read(questionSessionControllerProvider.notifier);
    final result = sessionController.completeSession();
    
    if (result != null) {
      context.pushReplacement('/questions/result', extra: result);
    }
  }
}

class _QuestionInfo extends StatelessWidget {
  final Part5Question question;

  const _QuestionInfo({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${question.questionCategory} • ${question.questionSubType}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '난이도: ${question.difficulty}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionText extends StatelessWidget {
  final Part5Question question;

  const _QuestionText({required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
                fontSize: 16,
              ),
            ),
            if (question.questionTranslation.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  question.questionTranslation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AnswerSection extends ConsumerWidget {
  final String questionId;

  const _AnswerSection({required this.questionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerAsync = ref.watch(part5AnswerProvider(questionId));

    return answerAsync.when(
      data: (answer) {
        // Set correct answer in session
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(questionSessionControllerProvider.notifier)
              .setCorrectAnswer(questionId, answer.answer);
        });

        return Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '정답 및 해설',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  answer.explanation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    height: 1.5,
                  ),
                ),
                if (answer.vocabulary != null && answer.vocabulary!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    '핵심 어휘',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...answer.vocabulary!.map((vocab) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                vocab.word,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '[${vocab.partOfSpeech}]',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                vocab.meaning,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          if (vocab.example.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              vocab.example,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            if (vocab.exampleTranslation.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                vocab.exampleTranslation,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                  )),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stack) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('해설을 불러올 수 없습니다: $error'),
        ),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final bool hasAnswer;
  final bool showAnswer;
  final VoidCallback onShowAnswer;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isLastQuestion;
  final VoidCallback onComplete;

  const _BottomNavigation({
    required this.hasAnswer,
    required this.showAnswer,
    required this.onShowAnswer,
    required this.onNext,
    this.onPrevious,
    required this.isLastQuestion,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (onPrevious != null)
              Expanded(
                child: AppButton.outline(
                  text: '이전',
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onPrevious,
                ),
              ),
            
            if (onPrevious != null) const SizedBox(width: 12),
            
            if (hasAnswer && !showAnswer)
              Expanded(
                flex: 2,
                child: AppButton(
                  text: '정답 확인',
                  icon: const Icon(Icons.check),
                  onPressed: onShowAnswer,
                ),
              ),
            
            if (showAnswer)
              Expanded(
                flex: 2,
                child: AppButton(
                  text: isLastQuestion ? '완료' : '다음',
                  icon: Icon(isLastQuestion ? Icons.done : Icons.arrow_forward),
                  onPressed: isLastQuestion ? onComplete : onNext,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            '조건에 맞는 문제를 찾을 수 없습니다',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '다른 필터 조건으로 다시 시도해보세요',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;

  const _ErrorState(this.error);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            '문제를 불러올 수 없습니다',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
