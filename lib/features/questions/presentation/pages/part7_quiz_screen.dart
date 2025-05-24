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
  bool _showTranslations = false; // 번역 표시 여부
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
          // 번역 토글 버튼 추가
          IconButton(
            icon: Icon(_showTranslations ? Icons.translate : Icons.translate_outlined),
            onPressed: () {
              setState(() {
                _showTranslations = !_showTranslations;
              });
            },
            tooltip: _showTranslations ? '번역 숨기기' : '번역 보기',
          ),
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
              ImprovedQuestionProgressBar(
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
                      // 개선된 문제 정보 카드
                      _ImprovedQuestionInfo(
                        question: currentQuestion, 
                        questionNumber: session.currentIndex + 1,
                        setType: _getCurrentSetType(sets, session.currentIndex),
                        totalQuestions: _getTotalQuestions(sets),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // 개선된 지문 섹션
                      ...currentPassages.map((passage) => [
                        _ImprovedPassageSection(
                          passage: passage,
                          showTranslation: _showTranslations,
                        ),
                        const SizedBox(height: 16),
                      ]).expand((x) => x),
                      
                      const SizedBox(height: 8),
                      
                      // 개선된 질문 텍스트
                      _ImprovedQuestionText(
                        question: currentQuestion,
                        showTranslation: _showTranslations,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // 개선된 선택지
                      ...currentQuestion.choices.asMap().entries.map((entry) {
                        final index = entry.key;
                        final choice = entry.value;
                        final choiceId = choice.id;
                        final choiceLabel = String.fromCharCode(65 + index);
                        final isSelected = _selectedChoice == choiceId;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _ImprovedChoiceButton(
                            label: choiceLabel,
                            text: choice.text,
                            translation: choice.translation,
                            showTranslation: _showTranslations,
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
                      
                      // 개선된 정답 섹션
                      if (_showAnswer) 
                        _ImprovedAnswerSection(
                          setId: _getCurrentSetId(sets, session.currentIndex),
                          questionSeq: currentQuestion.questionSeq,
                          selectedChoice: _selectedChoice,
                          choices: currentQuestion.choices,
                        ),
                    ],
                  ),
                ),
              ),
              
              // 개선된 네비게이션 바
              _ImprovedNavigationBar(
                hasAnswer: _selectedChoice != null,
                showAnswer: _showAnswer,
                onShowAnswer: () {
                  setState(() {
                    _showAnswer = true;
                    _showTranslations = true; // 정답 확인 시 번역도 보여줌
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
                        builder: (context) => ImprovedQuizResultScreen(result: result),
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

  String _getCurrentSetType(List<Part7Set> sets, int currentIndex) {
    var questionCounter = 0;
    
    for (final set in sets) {
      for (int i = 0; i < set.questions.length; i++) {
        if (questionCounter == currentIndex) {
          return set.questionSetType;
        }
        questionCounter++;
      }
    }
    
    return 'Single';
  }

  void _resetQuestionState() {
    setState(() {
      _showAnswer = false;
      _selectedChoice = null;
      _showTranslations = false; // 번역도 초기화
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
            Text('• 번역 버튼으로 해석을 확인할 수 있습니다'),
            Text('• 문맥을 통해 답을 추론하는 능력이 중요합니다'),
            SizedBox(height: 12),
            Text('팁:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• 먼저 번역 없이 지문을 읽어보세요'),
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

// 개선된 문제 정보 위젯
class _ImprovedQuestionInfo extends StatelessWidget {
  final Part7Question question;
  final int questionNumber;
  final String setType;
  final int totalQuestions;

  const _ImprovedQuestionInfo({
    required this.question,
    required this.questionNumber,
    required this.setType,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.1),
            Colors.purple.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
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
                      'Part 7 - 문제 $questionNumber/$totalQuestions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getDarkerColor(Colors.purple),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.layers,
                          label: '$setType 세트',
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          icon: Icons.quiz,
                          label: question.questionType,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 색상을 더 어둡게 만드는 헬퍼 메서드
  Color _getDarkerColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      color.opacity,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _getDarkerColor(color),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // 색상을 더 어둡게 만드는 헬퍼 메서드
  Color _getDarkerColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      color.opacity,
    );
  }
}

// 개선된 지문 섹션
class _ImprovedPassageSection extends StatelessWidget {
  final Part7Passage passage;
  final bool showTranslation;

  const _ImprovedPassageSection({
    required this.passage,
    required this.showTranslation,
  });

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
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _getPassageTypeColor(passage.type),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _getPassageTypeIcon(passage.type),
                  color: Colors.white,
                  size: 16,
                ),
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
              fontSize: 16,
            ),
          ),
          if (showTranslation && passage.translation.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
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
                        Icons.translate,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '번역',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    passage.translation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getPassageTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'email':
        return Colors.blue;
      case 'letter':
        return Colors.green;
      case 'memo':
        return Colors.orange;
      case 'notice':
        return Colors.red;
      case 'advertisement':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getPassageTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'email':
        return Icons.email;
      case 'letter':
        return Icons.mail;
      case 'memo':
        return Icons.note;
      case 'notice':
        return Icons.announcement;
      case 'advertisement':
        return Icons.campaign;
      default:
        return Icons.description;
    }
  }
}

// 개선된 질문 텍스트
class _ImprovedQuestionText extends StatelessWidget {
  final Part7Question question;
  final bool showTranslation;

  const _ImprovedQuestionText({
    required this.question,
    required this.showTranslation,
  });

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '질문',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  question.questionType,
                  style: TextStyle(
                    fontSize: 12,
                    color: _getDarkerColor(Colors.purple),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            question.questionText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.5,
              fontSize: 16,
            ),
          ),
          if (showTranslation && question.questionTranslation.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
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
                        Icons.translate,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '번역',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    question.questionTranslation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 색상을 더 어둡게 만드는 헬퍼 메서드
  Color _getDarkerColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      color.opacity,
    );
  }
}

// Part 7용 개선된 선택지 버튼
class _ImprovedChoiceButton extends StatelessWidget {
  final String label;
  final String text;
  final String translation;
  final bool showTranslation;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback? onTap;

  const _ImprovedChoiceButton({
    required this.label,
    required this.text,
    required this.translation,
    required this.showTranslation,
    required this.isSelected,
    this.isCorrect,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? borderColor;
    Color? textColor;
    IconData? icon;

    if (isCorrect != null) {
      // Show result state
      if (isCorrect!) {
        backgroundColor = Colors.green.withOpacity(0.1);
        borderColor = Colors.green;
        textColor = _getDarkerColor(Colors.green);
        icon = Icons.check_circle;
      } else if (isSelected) {
        backgroundColor = Colors.red.withOpacity(0.1);
        borderColor = Colors.red;
        textColor = _getDarkerColor(Colors.red);
        icon = Icons.cancel;
      } else {
        backgroundColor = Theme.of(context).colorScheme.surface;
        borderColor = Theme.of(context).colorScheme.outline;
        textColor = Theme.of(context).colorScheme.onSurface;
      }
    } else {
      // Normal state
      if (isSelected) {
        backgroundColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7);
        borderColor = Theme.of(context).colorScheme.primary;
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
      } else {
        backgroundColor = Theme.of(context).colorScheme.surface;
        borderColor = Theme.of(context).colorScheme.outline;
        textColor = Theme.of(context).colorScheme.onSurface;
      }
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor!, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Choice label
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: borderColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: borderColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Choice content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (showTranslation && translation.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: textColor?.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.translate,
                              size: 14,
                              color: textColor?.withOpacity(0.7),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                translation,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: textColor?.withOpacity(0.8),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Result icon
              if (icon != null) ...[
                const SizedBox(width: 12),
                Icon(
                  icon,
                  color: borderColor,
                  size: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // 색상을 더 어둡게 만드는 헬퍼 메서드
  Color _getDarkerColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      color.opacity,
    );
  }
}

// Part 7용 개선된 답안 섹션
class _ImprovedAnswerSection extends ConsumerWidget {
  final String setId;
  final int questionSeq;
  final String? selectedChoice;
  final List<Choice> choices;

  const _ImprovedAnswerSection({
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
        final correctChoice = choices.firstWhere((c) => c.id == answer.answer);

        return Column(
          children: [
            // Correct/Incorrect indicator
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isCorrect 
                      ? [Colors.green.withOpacity(0.1), Colors.green.withOpacity(0.05)]
                      : [Colors.red.withOpacity(0.1), Colors.red.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCorrect ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      isCorrect ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCorrect ? '정답입니다! 🎉' : '아쉽네요 😔',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isCorrect ? _getDarkerColor(Colors.green) : _getDarkerColor(Colors.red),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '정답: ',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${answer.answer}. ${correctChoice.text}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: _getDarkerColor(Colors.green),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (correctChoice.translation.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Text(
                                '(${correctChoice.translation})',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: _getDarkerColor(Colors.green),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (selectedChoice != null && !isCorrect) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '선택: ',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '$selectedChoice. ${choices.firstWhere((c) => c.id == selectedChoice).text}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: _getDarkerColor(Colors.red),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.lightbulb,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '해설',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                        height: 1.6,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: 12),
            
            // 독해 팁 (Part 7 특화)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.purple.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tips_and_updates,
                    color: Colors.purple,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isCorrect 
                          ? '잘했어요! 지문의 핵심 내용을 정확히 파악했습니다.'
                          : '지문을 다시 읽어보고 키워드를 찾아보세요.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getDarkerColor(Colors.purple),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('정답과 해설을 불러오는 중...'),
          ],
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
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '정답을 불러올 수 없습니다: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 색상을 더 어둡게 만드는 헬퍼 메서드
  Color _getDarkerColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      color.opacity,
    );
  }
}

// Part 7용 개선된 네비게이션 바
class _ImprovedNavigationBar extends StatelessWidget {
  final bool hasAnswer;
  final bool showAnswer;
  final VoidCallback onShowAnswer;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isLastQuestion;
  final VoidCallback onComplete;

  const _ImprovedNavigationBar({
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
                  icon: const Icon(Icons.check_circle),
                  onPressed: onShowAnswer,
                ),
              ),
            
            if (showAnswer)
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: _getDarkerColor(Colors.green), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '정답 확인됨',
                        style: TextStyle(
                          color: _getDarkerColor(Colors.green),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            if (onPrevious != null) const SizedBox(width: 12),
            
            Expanded(
              child: AppButton(
                text: isLastQuestion ? '완료' : '다음',
                icon: Icon(isLastQuestion ? Icons.flag : Icons.arrow_forward),
                onPressed: hasAnswer ? (isLastQuestion ? onComplete : onNext) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 색상을 더 어둡게 만드는 헬퍼 메서드
  Color _getDarkerColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      color.opacity,
    );
  }
}

// 기존 Empty/Error 상태는 유지
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
