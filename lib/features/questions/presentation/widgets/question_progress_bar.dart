import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImprovedQuestionProgressBar extends StatefulWidget {
  final int current;
  final int total;
  final int answered;
  final int correct;
  final Duration? timeRemaining;
  final bool showTimeRemaining;
  final VoidCallback? onQuestionTap;

  const ImprovedQuestionProgressBar({
    super.key,
    required this.current,
    required this.total,
    required this.answered,
    this.correct = 0,
    this.timeRemaining,
    this.showTimeRemaining = false,
    this.onQuestionTap,
  });

  @override
  State<ImprovedQuestionProgressBar> createState() => _ImprovedQuestionProgressBarState();
}

class _ImprovedQuestionProgressBarState extends State<ImprovedQuestionProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _progressAnimationController;
  late AnimationController _pulseAnimationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseAnimationController,
      curve: Curves.easeInOut,
    ));

    _progressAnimationController.forward();
    
    // 현재 문제에서 맥박 효과
    _pulseAnimationController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(ImprovedQuestionProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.current != widget.current) {
      _progressAnimationController.forward();
      HapticFeedback.selectionClick();
    }
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _pulseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.current / widget.total;
    final answerProgress = widget.answered / widget.total;
    final correctProgress = widget.correct / widget.total;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 진행 상황
              Column(
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
                        '문제 ${widget.current} / ${widget.total}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _StatusChip(
                        icon: Icons.check_circle,
                        label: '답안 ${widget.answered}개',
                        color: Colors.blue,
                      ),
                      if (widget.correct > 0) ...[
                        const SizedBox(width: 8),
                        _StatusChip(
                          icon: Icons.verified,
                          label: '정답 ${widget.correct}개',
                          color: Colors.green,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              
              // 시간 정보 (옵션)
              if (widget.showTimeRemaining && widget.timeRemaining != null)
                _TimeRemainingCard(timeRemaining: widget.timeRemaining!),
              
              // 진행률 퍼센트
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(progress * 100).round()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // 메인 프로그레스 바
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return _MultiLayerProgressBar(
                progress: progress * _progressAnimation.value,
                answerProgress: answerProgress * _progressAnimation.value,
                correctProgress: correctProgress * _progressAnimation.value,
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // 문제 번호 표시 (미니 네비게이션)
          if (widget.total <= 20) // 문제가 20개 이하일 때만 표시
            _QuestionNumberIndicator(
              current: widget.current,
              total: widget.total,
              answered: widget.answered,
              onQuestionTap: widget.onQuestionTap,
              pulseAnimation: _pulseAnimation,
            ),
          
          const SizedBox(height: 12),
          
          // 상태 설명
          _ProgressLegend(),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusChip({
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

class _TimeRemainingCard extends StatefulWidget {
  final Duration timeRemaining;

  const _TimeRemainingCard({required this.timeRemaining});

  @override
  State<_TimeRemainingCard> createState() => _TimeRemainingCardState();
}

class _TimeRemainingCardState extends State<_TimeRemainingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _warningAnimationController;
  
  @override
  void initState() {
    super.initState();
    _warningAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    // 시간이 5분 미만이면 경고 애니메이션
    if (widget.timeRemaining.inMinutes < 5) {
      _warningAnimationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _warningAnimationController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final isWarning = widget.timeRemaining.inMinutes < 5;
    final minutes = widget.timeRemaining.inMinutes;
    final seconds = widget.timeRemaining.inSeconds % 60;

    return AnimatedBuilder(
      animation: _warningAnimationController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isWarning 
                ? Colors.red.withOpacity(0.1 + 0.1 * _warningAnimationController.value)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isWarning ? Colors.red : Colors.orange,
              width: isWarning ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer,
                size: 16,
                color: isWarning ? Colors.red : Colors.orange,
              ),
              const SizedBox(width: 6),
              Text(
                '${minutes}:${seconds.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isWarning ? Colors.red : Colors.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MultiLayerProgressBar extends StatelessWidget {
  final double progress;
  final double answerProgress;
  final double correctProgress;

  const _MultiLayerProgressBar({
    required this.progress,
    required this.answerProgress,
    required this.correctProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // 배경
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            
            // 정답 진행률 (가장 아래층)
            if (correctProgress > 0)
              FractionallySizedBox(
                widthFactor: correctProgress.clamp(0.0, 1.0),
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            
            // 답안 진행률 (중간층)
            if (answerProgress > 0)
              FractionallySizedBox(
                widthFactor: answerProgress.clamp(0.0, 1.0),
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            
            // 현재 진행률 (최상층)
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // 진행률 텍스트
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(progress * 100).round()}% 진행',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (answerProgress > 0)
              Text(
                '${(answerProgress * 100).round()}% 답안 작성',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _QuestionNumberIndicator extends StatelessWidget {
  final int current;
  final int total;
  final int answered;
  final VoidCallback? onQuestionTap;
  final Animation<double> pulseAnimation;

  const _QuestionNumberIndicator({
    required this.current,
    required this.total,
    required this.answered,
    this.onQuestionTap,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: total,
        itemBuilder: (context, index) {
          final questionNumber = index + 1;
          final isCurrent = questionNumber == current;
          final isAnswered = questionNumber <= answered;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: onQuestionTap,
              child: AnimatedBuilder(
                animation: pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isCurrent ? pulseAnimation.value : 1.0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? Theme.of(context).colorScheme.primary
                            : isAnswered
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCurrent
                              ? Theme.of(context).colorScheme.primary
                              : isAnswered
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
                          width: isCurrent ? 2 : 1,
                        ),
                        boxShadow: isCurrent
                            ? [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          questionNumber.toString(),
                          style: TextStyle(
                            color: isCurrent
                                ? Theme.of(context).colorScheme.onPrimary
                                : isAnswered
                                    ? Theme.of(context).colorScheme.onPrimaryContainer
                                    : Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LegendItem(
          color: Theme.of(context).colorScheme.primary,
          label: '현재 진행',
          icon: Icons.play_arrow,
        ),
        _LegendItem(
          color: Theme.of(context).colorScheme.secondary,
          label: '답안 작성',
          icon: Icons.edit,
        ),
        _LegendItem(
          color: Colors.green,
          label: '정답',
          icon: Icons.check,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 6),
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
