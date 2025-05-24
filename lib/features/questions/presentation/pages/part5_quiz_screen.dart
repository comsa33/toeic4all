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
  bool _showTranslations = false; // 번역 표시 여부
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
              ImprovedQuestionProgressBar(
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
                      // Question info (개선됨)
                      _QuestionInfoCard(
                        question: currentQuestion,
                        questionNumber: session.currentIndex + 1,
                        totalQuestions: questions.length,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Question text (번역 토글 기능 추가)
                      _QuestionTextCard(
                        question: currentQuestion,
                        showTranslation: _showTranslations,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Choices (번역 토글 기능 추가)
                      ...currentQuestion.choices.asMap().entries.map((entry) {
                        final index = entry.key;
                        final choice = entry.value;
                        final choiceLabel = String.fromCharCode(65 + index); // A, B, C, D
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _ImprovedChoiceButton(
                            label: choiceLabel,
                            text: choice.text,
                            translation: choice.translation,
                            showTranslation: _showTranslations,
                            isSelected: _selectedChoice == choice.id,
                            isCorrect: _showAnswer ? _getChoiceCorrectness(choice.id, userAnswer) : null,
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
                      
                      // Answer section (개선됨)
                      if (_showAnswer) 
                        _ImprovedAnswerSection(
                          questionId: currentQuestion.id,
                          selectedChoice: _selectedChoice,
                          choices: currentQuestion.choices,
                        ),
                    ],
                  ),
                ),
              ),
              
              // Bottom navigation (개선됨)
              _ImprovedBottomNavigation(
                hasAnswer: userAnswer != null,
                showAnswer: _showAnswer,
                onShowAnswer: () {
                  setState(() {
                    _showAnswer = true;
                    _showTranslations = true; // 정답 확인 시 번역도 보여줌
                  });
                },
                onNext: () {
                  sessionController.nextQuestion();
                  setState(() {
                    _showAnswer = false;
                    _selectedChoice = null;
                    _showTranslations = false; // 번역 초기화
                  });
                },
                onPrevious: session.currentIndex > 0 ? () {
                  sessionController.previousQuestion();
                  setState(() {
                    _showAnswer = false;
                    _selectedChoice = sessionController.getCurrentUserAnswer();
                    _showTranslations = false; // 번역 초기화
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

  bool? _getChoiceCorrectness(String choiceId, String? userAnswer) {
    if (userAnswer == null) return null;
    return choiceId == userAnswer;
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
            Text('Part 5는 문법 및 어휘 문제입니다.'),
            SizedBox(height: 12),
            Text('• 문장의 빈 칸에 들어갈 가장 적절한 답을 선택하세요'),
            Text('• 문법과 어휘 지식을 활용하세요'),
            Text('• 번역 버튼으로 해석을 확인할 수 있습니다'),
            Text('• 답안 확인 후 해설을 참고하세요'),
            SizedBox(height: 12),
            Text('팁:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• 먼저 번역 없이 문제를 풀어보세요'),
            Text('• 문법 구조를 파악한 후 답을 선택하세요'),
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

// 새로운 위젯들
class _QuestionInfoCard extends StatelessWidget {
  final Part5Question question;
  final int questionNumber;
  final int totalQuestions;

  const _QuestionInfoCard({
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.1),
            Colors.blue.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.text_fields,
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
                      'Part 5 - 문제 $questionNumber/$totalQuestions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.category,
                          label: question.questionCategory,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          icon: Icons.subdirectory_arrow_right,
                          label: question.questionSubType,
                          color: Colors.purple,
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          icon: Icons.trending_up,
                          label: question.difficulty,
                          color: _getDifficultyColor(question.difficulty),
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
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

class _QuestionTextCard extends StatelessWidget {
  final Part5Question question;
  final bool showTranslation;

  const _QuestionTextCard({
    required this.question,
    required this.showTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.quiz,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '문제',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question.questionText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showTranslation && question.questionTranslation.isNotEmpty) ...[
              const SizedBox(height: 16),
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
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

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
        textColor = Colors.green.shade800;
        icon = Icons.check_circle;
      } else if (isSelected) {
        backgroundColor = Colors.red.withOpacity(0.1);
        borderColor = Colors.red;
        textColor = Colors.red.shade800;
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
}

class _ImprovedAnswerSection extends ConsumerWidget {
  final String questionId;
  final String? selectedChoice;
  final List<Choice> choices;

  const _ImprovedAnswerSection({
    required this.questionId,
    required this.selectedChoice,
    required this.choices,
  });

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
                            color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
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
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (correctChoice.translation.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Text(
                                '(${correctChoice.translation})',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.green.shade600,
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
                                    color: Colors.red.shade700,
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
                        '정답 및 해설',
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
                  if (answer.vocabulary != null && answer.vocabulary!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
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
                                Icons.book,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '핵심 어휘',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...answer.vocabulary!.map((vocab) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(6),
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
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          vocab.partOfSpeech,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        vocab.meaning,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (vocab.example.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
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
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
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
                '해설을 불러올 수 없습니다: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImprovedBottomNavigation extends StatelessWidget {
  final bool hasAnswer;
  final bool showAnswer;
  final VoidCallback onShowAnswer;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isLastQuestion;
  final VoidCallback onComplete;

  const _ImprovedBottomNavigation({
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
                      Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '정답 확인됨',
                        style: TextStyle(
                          color: Colors.green.shade700,
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