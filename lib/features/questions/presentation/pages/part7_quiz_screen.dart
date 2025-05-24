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

class Part7QuizScreen extends ConsumerStatefulWidget {
  final QuestionFilter filter;

  const Part7QuizScreen({
    super.key,
    required this.filter,
  });

  @override
  ConsumerState<Part7QuizScreen> createState() => _Part7QuizScreenState();
}

class _Part7QuizScreenState extends ConsumerState<Part7QuizScreen> {
  bool _showAnswer = false;
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    final setsAsync = ref.watch(part7SetsProvider(widget.filter));
    final sessionState = ref.watch(questionSessionControllerProvider);
    final sessionController = ref.read(questionSessionControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Part 7'),
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
              sessionController.startPart7Session(sets);
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
          final currentPassages = currentQuestionInfo.passages;

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
                      _QuestionInfo(question: currentQuestion, questionNumber: session.currentIndex + 1),
                      
                      const SizedBox(height: 24),
                      
                      // Passages
                      ...currentPassages.map((passage) => [
                        _PassageSection(passage: passage),
                        const SizedBox(height: 16),
                      ]).expand((x) => x),
                      
                      const SizedBox(height: 8),
                      
                      // Question text
                      _QuestionText(question: currentQuestion),
                      
                      const SizedBox(height: 24),
                      
                      // Choices
                      ...currentQuestion.choices.asMap().entries.map((entry) {
                        final index = entry.key;
                        final choice = entry.value;
                        final choiceId = choice.id;
                        final choiceLabel = String.fromCharCode(65 + index); // A, B, C, D
                        final isSelected = _selectedChoice == choiceId;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ChoiceButton(
                            label: choiceLabel,
                            text: choice.text,
                            translation: choice.translation,
                            isSelected: isSelected,
                            isCorrect: null, // Will be handled by answer section
                            onTap: _showAnswer ? null : () {
                              setState(() {
                                _selectedChoice = choiceId;
                              });
                              final questionId = sessionController.getCurrentQuestionId();
                              if (questionId != null) {
                                sessionController.submitAnswer(questionId, choiceId);
                              }
                            },
                          ),
                        );
                      }),
                      
                      const SizedBox(height: 24),
                      
                      // Show answer section if answer is shown
                      if (_showAnswer) 
                        _AnswerSection(
                          setId: _getCurrentSetId(sets, session.currentIndex),
                          questionSeq: currentQuestion.questionSeq,
                          selectedChoice: _selectedChoice,
                          choices: currentQuestion.choices,
                        ),
                    ],
                  ),
                ),
              ),
              
              // Navigation
              _NavigationBar(
                hasAnswer: _selectedChoice != null,
                showAnswer: _showAnswer,
                onShowAnswer: () {
                  setState(() {
                    _showAnswer = true;
                  });
                },
                onNext: () {
                  _resetQuestionState();
                  sessionController.nextQuestion();
                },
                onPrevious: session.currentIndex > 0 ? () {
                  _resetQuestionState();
                  sessionController.previousQuestion();
                } : null,
                isLastQuestion: session.currentIndex >= _getTotalQuestions(sets) - 1,
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

  ({Part7Question question, List<Part7Passage> passages})? _getCurrentQuestionInfo(List<Part7Set> sets, int currentIndex) {
    var questionCounter = 0;
    
    for (final set in sets) {
      for (final question in set.questions) {
        if (questionCounter == currentIndex) {
          return (question: question, passages: set.passages);
        }
        questionCounter++;
      }
    }
    
    return null;
  }

  int _getTotalQuestions(List<Part7Set> sets) {
    return sets.fold(0, (total, set) => total + set.questions.length);
  }

  String _getCurrentSetId(List<Part7Set> sets, int currentIndex) {
    var questionCounter = 0;
    
    for (final set in sets) {
      for (int i = 0; i < set.questions.length; i++) {
        if (questionCounter == currentIndex) {
          return set.id;
        }
        questionCounter++;
      }
    }
    
    return '';
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
      builder: (context) => AlertDialog(
        title: const Text('문제 풀이 종료'),
        content: const Text('정말로 문제 풀이를 종료하시겠습니까?\n진행 상황이 저장되지 않습니다.'),
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
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Part 7 도움말'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Part 7은 장문 독해 문제입니다.'),
            SizedBox(height: 12),
            Text('• 한 개 또는 여러 개의 지문을 읽고 질문에 답하세요'),
            Text('• 지문의 주요 내용과 세부 사항을 파악해야 합니다'),
            Text('• 문맥을 통해 답을 추론하는 능력이 중요합니다'),
            SizedBox(height: 12),
            Text('팁:'),
            Text('• 질문을 먼저 읽고 지문을 읽으세요'),
            Text('• 키워드를 찾아 관련 부분을 집중적으로 읽으세요'),
            Text('• 전체적인 맥락을 이해하세요'),
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
}

// Question components for Part 7
class _QuestionInfo extends StatelessWidget {
  final Part7Question question;
  final int questionNumber;

  const _QuestionInfo({
    required this.question, 
    required this.questionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.library_books,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Part 7 - Question $questionNumber',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                ),
                if (question.questionType.isNotEmpty)
                  Text(
                    question.questionType,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.purple.shade600,
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
  final Part7Passage passage;

  const _PassageSection({required this.passage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
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
                '지문 ${passage.seq} - ${passage.type}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            passage.text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
          if (passage.translation.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                passage.translation,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuestionText extends StatelessWidget {
  final Part7Question question;

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
            question.questionText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          if (question.questionTranslation.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              question.questionTranslation,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
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

class _AnswerSection extends ConsumerWidget {
  final String setId;
  final int questionSeq;
  final String? selectedChoice;
  final List<Choice> choices;

  const _AnswerSection({
    required this.setId,
    required this.questionSeq,
    required this.selectedChoice,
    required this.choices,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerAsync = ref.watch(part7AnswerProvider((setId: setId, questionSeq: questionSeq)));

    return answerAsync.when(
      data: (answer) {
        // Set correct answer in session
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final questionId = '${setId}_$questionSeq';
          ref.read(questionSessionControllerProvider.notifier)
              .setCorrectAnswer(questionId, answer.answer);
        });

        final isCorrect = selectedChoice == answer.answer;

        return Column(
          children: [
            // Correct/Incorrect indicator
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isCorrect 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCorrect ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green : Colors.red,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCorrect ? '정답입니다!' : '오답입니다',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isCorrect ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '정답: ${answer.answer}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                          ),
                        ),
                        if (selectedChoice != null && !isCorrect)
                          Text(
                            '선택: $selectedChoice',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.red.shade700,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Explanation
            if (answer.explanation.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '해설',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      answer.explanation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red),
        ),
        child: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '정답을 불러올 수 없습니다: $error',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
