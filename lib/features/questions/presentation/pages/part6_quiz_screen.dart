import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/question_filter.dart';
import '../../domain/entities/question.dart';
import '../providers/questions_providers.dart';
import '../controllers/question_session_controller.dart';
import '../widgets/question_progress_bar.dart';
import '../widgets/choice_button.dart';
import '../pages/quiz_result_screen.dart';
import '../../../../shared/widgets/app_button.dart';

class Part6QuizScreen extends ConsumerStatefulWidget {
  final QuestionFilter filter;

  const Part6QuizScreen({
    super.key,
    required this.filter,
  });

  @override
  ConsumerState<Part6QuizScreen> createState() => _Part6QuizScreenState();
}

class _Part6QuizScreenState extends ConsumerState<Part6QuizScreen> {
  bool _showAnswer = false;
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    final setsAsync = ref.watch(part6SetsProvider(widget.filter));
    final sessionState = ref.watch(questionSessionControllerProvider);
    final sessionController = ref.read(questionSessionControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Part 6'),
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
      body: setsAsync.when(
        data: (sets) {
          if (sets.isEmpty) {
            return _EmptyState();
          }

          // Initialize session if not started
          if (sessionState.currentSession == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              sessionController.startPart6Session(sets);
            });
            return const Center(child: CircularProgressIndicator());
          }

          final session = sessionState.currentSession!;
          
          // Find current question from sets
          final currentQuestionInfo = _getCurrentQuestionInfo(sets, session.currentIndex);
          if (currentQuestionInfo == null) {
            return const Center(child: Text('문제를 불러올 수 없습니다.'));
          }

          final currentQuestion = currentQuestionInfo.question;
          final currentPassage = currentQuestionInfo.passage;
          final userAnswer = sessionController.getCurrentUserAnswer();

          return Column(
            children: [
              // Progress bar
              QuestionProgressBar(
                current: session.currentIndex + 1,
                total: _getTotalQuestions(sets),
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
                      
                      // Passage (for Part 6)
                      if (currentPassage.isNotEmpty) ...[
                        _PassageSection(passage: currentPassage),
                        const SizedBox(height: 24),
                      ],
                      
                      // Question text
                      _QuestionText(question: currentQuestion),
                      
                      const SizedBox(height: 24),
                      
                      // Choices
                      ...currentQuestion.choices.asMap().entries.map((entry) {
                        final index = entry.key;
                        final choice = entry.value;
                        final choiceLabel = String.fromCharCode(65 + index.toInt()); // A, B, C, D
                        
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
                              final questionId = sessionController.getCurrentQuestionId();
                              if (questionId != null) {
                                sessionController.submitAnswer(questionId, choice.id);
                              }
                            },
                          ),
                        );
                      }),
                      
                      if (_showAnswer) ...[
                        const SizedBox(height: 24),
                        // Part 6 doesn't have explanation section
                        Text(
                          '정답을 확인하였습니다.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              // Navigation bar
              _NavigationBar(
                hasAnswer: userAnswer != null,
                showAnswer: _showAnswer,
                onShowAnswer: () {
                  setState(() {
                    _showAnswer = true;
                  });
                },
                onNext: () {
                  sessionController.nextQuestion();
                  _resetQuestionState();
                },
                onPrevious: session.currentIndex > 0 ? () {
                  sessionController.previousQuestion();
                  _resetQuestionState();
                } : null,
                isLastQuestion: session.currentIndex == _getTotalQuestions(sets) - 1,
                onComplete: () async {
                  final result = sessionController.completeSession();
                  if (result != null && mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => QuizResultScreen(result: result),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _ErrorState(error.toString()),
      ),
    );
  }

  ({Part6Question question, String passage})? _getCurrentQuestionInfo(List<Part6Set> sets, int currentIndex) {
    var questionCounter = 0;
    
    for (final set in sets) {
      for (final question in set.questions) {
        if (questionCounter == currentIndex) {
          return (question: question, passage: set.passage);
        }
        questionCounter++;
      }
    }
    
    return null;
  }

  int _getTotalQuestions(List<Part6Set> sets) {
    return sets.fold(0, (total, set) => total + set.questions.length);
  }

  void _resetQuestionState() {
    setState(() {
      _showAnswer = false;
      _selectedChoice = null;
    });
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                Navigator.of(context).pop();
              },
              child: const Text('종료'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Part 6 안내'),
          content: const Text(
            'Part 6는 빈칸 추론 문제입니다.\n\n'
            '• 지문을 읽고 빈칸에 들어갈 적절한 답을 선택하세요\n'
            '• 문법, 어휘, 문맥을 종합적으로 고려해야 합니다\n'
            '• "정답 보기" 버튼을 눌러 해설을 확인할 수 있습니다'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

class _QuestionInfo extends StatelessWidget {
  final Part6Question question;

  const _QuestionInfo({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.quiz,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '빈칸 ${question.blankNumber}번',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  question.questionType,
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

class _PassageSection extends StatelessWidget {
  final String passage;

  const _PassageSection({required this.passage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '지문',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            passage,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionText extends StatelessWidget {
  final Part6Question question;

  const _QuestionText({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '빈칸 ${question.blankNumber}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.questionType,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  final bool hasAnswer;
  final bool showAnswer;
  final VoidCallback onShowAnswer;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isLastQuestion;
  final VoidCallback onComplete;

  const _NavigationBar({
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
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Previous button
            if (onPrevious != null)
              Expanded(
                child: AppButton(
                  text: '이전',
                  onPressed: onPrevious,
                ),
              )
            else
              const Expanded(child: SizedBox()),
            
            const SizedBox(width: 12),
            
            // Show answer button
            if (!showAnswer && hasAnswer)
              Expanded(
                flex: 2,
                child: AppButton(
                  text: '정답 보기',
                  onPressed: onShowAnswer,
                ),
              )
            else
              const Expanded(flex: 2, child: SizedBox()),
            
            const SizedBox(width: 12),
            
            // Next/Complete button
            Expanded(
              child: AppButton(
                text: isLastQuestion ? '완료' : '다음',
                onPressed: hasAnswer ? (isLastQuestion ? onComplete : onNext) : null,
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
            Icons.quiz,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '문제를 찾을 수 없습니다',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '다른 조건으로 다시 시도해주세요',
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
            '오류가 발생했습니다',
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
