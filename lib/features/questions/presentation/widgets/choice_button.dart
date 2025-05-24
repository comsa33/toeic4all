import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImprovedChoiceButton extends StatefulWidget {
  final String label;
  final String text;
  final String translation;
  final bool showTranslation;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback? onTap;
  final bool isDisabled;

  const ImprovedChoiceButton({
    super.key,
    required this.label,
    required this.text,
    required this.translation,
    this.showTranslation = false,
    required this.isSelected,
    this.isCorrect,
    this.onTap,
    this.isDisabled = false,
  });

  @override
  State<ImprovedChoiceButton> createState() => _ImprovedChoiceButtonState();
}

class _ImprovedChoiceButtonState extends State<ImprovedChoiceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
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

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null && !widget.isDisabled) {
      setState(() => _isPressed = true);
      _animationController.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    IconData? statusIcon;
    Color? statusIconColor;

    // 상태별 색상 결정
    if (widget.isCorrect != null) {
      // 정답 확인 후 상태
      if (widget.isCorrect!) {
        backgroundColor = Colors.green.withOpacity(0.15);
        borderColor = Colors.green;
        textColor = Colors.green.shade800;
        statusIcon = Icons.check_circle;
        statusIconColor = Colors.green;
      } else if (widget.isSelected) {
        backgroundColor = Colors.red.withOpacity(0.15);
        borderColor = Colors.red;
        textColor = Colors.red.shade800;
        statusIcon = Icons.cancel;
        statusIconColor = Colors.red;
      } else {
        backgroundColor = Theme.of(context).colorScheme.surface;
        borderColor = Theme.of(context).colorScheme.outline.withOpacity(0.5);
        textColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.7);
      }
    } else {
      // 일반 상태
      if (widget.isSelected) {
        backgroundColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8);
        borderColor = Theme.of(context).colorScheme.primary;
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
      } else {
        backgroundColor = Theme.of(context).colorScheme.surface;
        borderColor = Theme.of(context).colorScheme.outline;
        textColor = Theme.of(context).colorScheme.onSurface;
      }
    }

    // Disabled 상태 처리
    if (widget.isDisabled) {
      backgroundColor = Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);
      borderColor = Theme.of(context).colorScheme.outline.withOpacity(0.3);
      textColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.4);
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.isDisabled ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: widget.isSelected || widget.isCorrect != null ? 2.5 : 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: widget.isSelected && widget.isCorrect == null
                ? [
                    BoxShadow(
                      color: borderColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : widget.isCorrect == true
                    ? [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
          ),
          child: Row(
            children: [
              // 선택지 라벨
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.isSelected || widget.isCorrect != null
                      ? borderColor
                      : borderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.isSelected || widget.isCorrect != null
                          ? Colors.white
                          : borderColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // 선택지 내용
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    if (widget.showTranslation && widget.translation.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: textColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: textColor.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.translate,
                              size: 16,
                              color: textColor.withOpacity(0.7),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.translation,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: textColor.withOpacity(0.8),
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    // 정답/오답 피드백
                    if (widget.isCorrect != null && widget.isSelected) ...[
                      const SizedBox(height: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: widget.isCorrect!
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: widget.isCorrect!
                                ? Colors.green.withOpacity(0.3)
                                : Colors.red.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.isCorrect! ? Icons.check : Icons.close,
                              size: 16,
                              color: widget.isCorrect!
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.isCorrect! ? '정답입니다!' : '오답입니다',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: widget.isCorrect!
                                    ? Colors.green.shade700
                                    : Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // 상태 아이콘
              if (statusIcon != null) ...[
                const SizedBox(width: 12),
                AnimatedScale(
                  scale: widget.isCorrect != null ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: statusIconColor!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      statusIcon,
                      color: statusIconColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
