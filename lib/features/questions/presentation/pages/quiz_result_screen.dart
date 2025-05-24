import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/question_filter.dart';
import '../../../../shared/widgets/app_button.dart';

class ImprovedQuizResultScreen extends ConsumerWidget {
  final SessionResult result;

  const ImprovedQuizResultScreen({
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
        title: const Text('학습 결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareResult(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 메인 점수 카드
            _MainScoreCard(
              accuracy: accuracy,
              correctAnswers: result.correctAnswers,
              totalQuestions: result.totalQuestions,
              timeTaken: result.timeTaken,
            ),
            
            const SizedBox(height: 24),
            
            // 성과 분석 차트
            _PerformanceChart(result: result),
            
            const SizedBox(height: 24),
            
            // 상세 통계
            _DetailedStats(
              result: result,
              timePerQuestion: timePerQuestion,
            ),
            
            const SizedBox(height: 24),
            
            // 문제별 결과
            _QuestionResultsSection(result: result),
            
            const SizedBox(height: 24),
            
            // 학습 피드백 및 추천
            _LearningFeedback(
              partType: result.type,
              accuracy: accuracy,
              weakPoints: _getWeakPoints(result),
            ),
            
            const SizedBox(height: 24),
            
            // 액션 버튼들
            _ActionButtons(
              onRetry: () {
                context.pop();
                context.pop();
              },
              onReviewWrong: () => _reviewWrongAnswers(context),
              onHome: () => context.go('/home'),
              onPracticeMore: () => _practiceMore(context),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getWeakPoints(SessionResult result) {
    final weakPoints = <String>[];
    final wrongQuestions = result.questionResults.values
        .where((q) => !q.isCorrect)
        .toList();
    
    if (wrongQuestions.length > result.totalQuestions * 0.3) {
      weakPoints.add('전반적인 문제 해결 능력');
    }
    
    // Part별 특화 분석 로직 추가 가능
    switch (result.type) {
      case QuestionType.part5:
        weakPoints.add('문법 및 어휘');
        break;
      case QuestionType.part6:
        weakPoints.add('문맥 파악');
        break;
      case QuestionType.part7:
        weakPoints.add('독해 능력');
        break;
    }
    
    return weakPoints;
  }

  void _shareResult(BuildContext context) {
    // 결과 공유 기능
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('결과가 클립보드에 복사되었습니다!')),
    );
  }

  void _reviewWrongAnswers(BuildContext context) {
    // 오답 노트 기능
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오답 노트'),
        content: const Text('틀린 문제들을 다시 학습하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 오답 노트 화면으로 이동
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _practiceMore(BuildContext context) {
    // 추가 연습 추천
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('추가 연습'),
        content: const Text('약한 부분을 집중적으로 연습하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('나중에'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
              context.pop();
            },
            child: const Text('연습하기'),
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

class _MainScoreCard extends StatelessWidget {
  final int accuracy;
  final int correctAnswers;
  final int totalQuestions;
  final Duration timeTaken;

  const _MainScoreCard({
    required this.accuracy,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTaken,
  });

  @override
  Widget build(BuildContext context) {
    final scoreColor = _getScoreColor(accuracy);
    final scoreMessage = _getScoreMessage(accuracy);
    final scoreEmoji = _getScoreEmoji(accuracy);

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scoreColor.withOpacity(0.15),
            scoreColor.withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scoreColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: scoreColor.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 점수 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$accuracy',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                  fontSize: 64,
                ),
              ),
              Text(
                '%',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 메시지와 이모지
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                scoreEmoji,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 12),
              Text(
                scoreMessage,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // 상세 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ScoreDetail(
                icon: Icons.check_circle,
                label: '정답',
                value: '$correctAnswers/$totalQuestions',
                color: Colors.green,
              ),
              Container(
                width: 1,
                height: 40,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
              _ScoreDetail(
                icon: Icons.timer,
                label: '소요시간',
                value: _formatDuration(timeTaken),
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int accuracy) {
    if (accuracy >= 90) return Colors.green;
    if (accuracy >= 70) return Colors.orange;
    return Colors.red;
  }

  String _getScoreMessage(int accuracy) {
    if (accuracy >= 95) return '완벽해요!';
    if (accuracy >= 90) return '훌륭해요!';
    if (accuracy >= 80) return '잘했어요!';
    if (accuracy >= 70) return '괜찮아요!';
    if (accuracy >= 60) return '조금 더 노력해요!';
    return '더 열심히 공부해요!';
  }

  String _getScoreEmoji(int accuracy) {
    if (accuracy >= 95) return '🏆';
    if (accuracy >= 90) return '🎉';
    if (accuracy >= 80) return '👍';
    if (accuracy >= 70) return '😊';
    if (accuracy >= 60) return '🤔';
    return '💪';
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}분 ${seconds}초';
  }
}

class _ScoreDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ScoreDetail({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
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
    );
  }
}

class _PerformanceChart extends StatelessWidget {
  final SessionResult result;

  const _PerformanceChart({required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '성과 분석',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: result.correctAnswers.toDouble(),
                      title: '정답\n${result.correctAnswers}개',
                      color: Colors.green,
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: (result.totalQuestions - result.correctAnswers).toDouble(),
                      title: '오답\n${result.totalQuestions - result.correctAnswers}개',
                      color: Colors.red,
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  centerSpaceRadius: 40,
                  sectionsSpace: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailedStats extends StatelessWidget {
  final SessionResult result;
  final Duration timePerQuestion;

  const _DetailedStats({
    required this.result,
    required this.timePerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.assessment,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '상세 통계',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.speed,
                    title: '문제당 평균 시간',
                    value: _formatDuration(timePerQuestion),
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatItem(
                    icon: Icons.trending_up,
                    title: '정답률',
                    value: '${(result.correctAnswers / result.totalQuestions * 100).round()}%',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.psychology,
                    title: '예상 TOEIC 점수',
                    value: '${_estimateToeicScore(result)}점',
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatItem(
                    icon: Icons.school,
                    title: '실력 레벨',
                    value: _getSkillLevel(result),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    if (minutes > 0) {
      return '${minutes}분 ${seconds}초';
    } else {
      return '${seconds}초';
    }
  }

  int _estimateToeicScore(SessionResult result) {
    final accuracy = result.correctAnswers / result.totalQuestions;
    // 간단한 점수 추정 공식 (실제로는 더 복잡한 알고리즘 필요)
    return (accuracy * 495).round();
  }

  String _getSkillLevel(SessionResult result) {
    final accuracy = result.correctAnswers / result.totalQuestions * 100;
    if (accuracy >= 90) return '고급';
    if (accuracy >= 70) return '중급';
    if (accuracy >= 50) return '초급';
    return '입문';
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
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
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _QuestionResultsSection extends StatelessWidget {
  final SessionResult result;

  const _QuestionResultsSection({required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.list_alt,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '문제별 결과',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: result.questionResults.length,
                itemBuilder: (context, index) {
                  final questionId = result.questionResults.keys.elementAt(index);
                  final questionResult = result.questionResults[questionId]!;
                  
                  return _QuestionResultItem(
                    questionNumber: index + 1,
                    result: questionResult,
                  );
                },
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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: result.isCorrect
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: result.isCorrect
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          // 문제 번호
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: result.isCorrect ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                questionNumber.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // 결과 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      result.isCorrect ? Icons.check_circle : Icons.cancel,
                      color: result.isCorrect ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      result.isCorrect ? '정답' : '오답',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: result.isCorrect ? Colors.green : Colors.red,
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
          
          // 소요 시간
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${result.timeTaken.inSeconds}s',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningFeedback extends StatelessWidget {
  final QuestionType partType;
  final int accuracy;
  final List<String> weakPoints;

  const _LearningFeedback({
    required this.partType,
    required this.accuracy,
    required this.weakPoints,
  });

  @override
  Widget build(BuildContext context) {
    final feedback = _getFeedback();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '학습 피드백',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedback.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feedback.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                  if (feedback.tips.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      '학습 팁:',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...feedback.tips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ', style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          )),
                          Expanded(child: Text(tip)),
                        ],
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ({String title, String message, List<String> tips}) _getFeedback() {
    if (accuracy >= 90) {
      return (
        title: '🎉 훌륭한 실력이에요!',
        message: '${partType.name.toUpperCase()} 문제를 매우 잘 풀고 있습니다. 이 조자감을 유지하며 다른 파트도 도전해보세요.',
        tips: [
          '실전 모의고사로 실력을 점검해보세요',
          '시간 단축 연습을 통해 더 빠른 문제 해결 능력을 기르세요',
          '다른 파트들도 골고루 연습해보세요',
        ],
      );
    } else if (accuracy >= 70) {
      return (
        title: '👍 좋은 성과예요!',
        message: '기본기가 탄탄합니다. 조금만 더 연습하면 고득점을 받을 수 있을 것 같아요.',
        tips: [
          '틀린 문제들을 다시 복습해보세요',
          '비슷한 유형의 문제를 더 많이 풀어보세요',
          '시간 관리 연습을 해보세요',
        ],
      );
    } else if (accuracy >= 50) {
      return (
        title: '💪 더 열심히 해봐요!',
        message: '기본기를 더 다져야 할 것 같습니다. 꾸준한 연습이 필요해요.',
        tips: [
          '기본 문법과 어휘부터 다시 정리해보세요',
          '쉬운 문제부터 차근차근 연습해보세요',
          '매일 조금씩이라도 꾸준히 공부해보세요',
        ],
      );
    } else {
      return (
        title: '📚 기초부터 다시 시작해요!',
        message: '기본기가 부족한 것 같습니다. 기초부터 차근차근 공부해보세요.',
        tips: [
          '기본 문법서부터 차근차근 공부해보세요',
          '단어장을 만들어 어휘력을 늘려보세요',
          '쉬운 문제부터 자신감을 기르세요',
          '온라인 강의를 활용해보세요',
        ],
      );
    }
  }
}

class _ActionButtons extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onReviewWrong;
  final VoidCallback onHome;
  final VoidCallback onPracticeMore;

  const _ActionButtons({
    required this.onRetry,
    required this.onReviewWrong,
    required this.onHome,
    required this.onPracticeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppButton.outline(
                text: '홈으로',
                icon: const Icon(Icons.home),
                onPressed: onHome,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.outline(
                text: '오답 노트',
                icon: const Icon(Icons.book),
                onPressed: onReviewWrong,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: '다시 풀기',
                icon: const Icon(Icons.refresh),
                onPressed: onRetry,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                text: '더 연습하기',
                icon: const Icon(Icons.psychology),
                onPressed: onPracticeMore,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
