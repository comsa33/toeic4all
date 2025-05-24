import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/question_filter.dart';
import '../../../../shared/widgets/app_button.dart';

class QuizResultScreen extends ConsumerWidget {
  final SessionResult result;

  const QuizResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accuracy = (result.correctAnswers / result.totalQuestions * 100).round();
    final timePerQuestion = Duration(
      milliseconds: result.timeTaken.inMilliseconds ~/ result.totalQuestions,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Score display
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _getScoreColor(accuracy).withOpacity(0.1),
                    _getScoreColor(accuracy).withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getScoreColor(accuracy).withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _getScoreIcon(accuracy),
                    size: 64,
                    color: _getScoreColor(accuracy),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$accuracy%',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getScoreColor(accuracy),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getScoreMessage(accuracy),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${result.correctAnswers}/${result.totalQuestions} 문제 정답',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Statistics
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.timer,
                    title: '총 시간',
                    value: _formatDuration(result.timeTaken),
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.speed,
                    title: '문제당 평균',
                    value: _formatDuration(timePerQuestion),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle,
                    title: '정답',
                    value: '${result.correctAnswers}개',
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.cancel,
                    title: '오답',
                    value: '${result.totalQuestions - result.correctAnswers}개',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Question results
            Expanded(
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.list,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '문제별 결과',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: result.questionResults.length,
                        itemBuilder: (context, index) {
                          final questionId = result.questionResults.keys.elementAt(index);
                          final questionResult = result.questionResults[questionId]!;
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _QuestionResultItem(
                              questionNumber: index + 1,
                              result: questionResult,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: AppButton.outline(
                    text: '홈으로',
                    icon: const Icon(Icons.home),
                    onPressed: () => context.go('/home'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: '다시 풀기',
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context.pop();
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(int accuracy) {
    if (accuracy >= 90) return Colors.green;
    if (accuracy >= 70) return Colors.orange;
    return Colors.red;
  }

  IconData _getScoreIcon(int accuracy) {
    if (accuracy >= 90) return Icons.emoji_events;
    if (accuracy >= 70) return Icons.thumb_up;
    return Icons.trending_up;
  }

  String _getScoreMessage(int accuracy) {
    if (accuracy >= 90) return '훌륭해요! 🎉';
    if (accuracy >= 70) return '잘했어요! 👍';
    return '더 노력해요! 💪';
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}분 ${seconds}초';
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionResultItem extends StatelessWidget {
  final int questionNumber;
  final QuestionResult result;

  const _QuestionResultItem({
    required this.questionNumber,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: result.isCorrect
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
            : Theme.of(context).colorScheme.errorContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Question number
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: result.isCorrect
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                questionNumber.toString(),
                style: TextStyle(
                  color: result.isCorrect
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onError,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Result info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      result.isCorrect ? Icons.check_circle : Icons.cancel,
                      color: result.isCorrect
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.error,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      result.isCorrect ? '정답' : '오답',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: result.isCorrect
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
                if (!result.isCorrect) ...[
                  const SizedBox(height: 4),
                  Text(
                    '내 답: ${result.userAnswer.isEmpty ? "미답" : result.userAnswer} • 정답: ${result.correctAnswer}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
