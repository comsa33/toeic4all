import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 폼 검증 및 UX 개선을 위한 헬퍼 클래스
class FormValidationHelper {
  // 실시간 검증을 위한 디바운서
  static Timer? _debounceTimer;

  static void debounce(
    VoidCallback callback, {
    Duration delay = const Duration(milliseconds: 500),
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  // 비밀번호 강도 체크
  static PasswordStrength checkPasswordStrength(String password) {
    if (password.isEmpty) return PasswordStrength.none;

    int score = 0;

    // 길이 체크
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;

    // 대문자 포함
    if (password.contains(RegExp(r'[A-Z]'))) score++;

    // 소문자 포함
    if (password.contains(RegExp(r'[a-z]'))) score++;

    // 숫자 포함
    if (password.contains(RegExp(r'[0-9]'))) score++;

    // 특수문자 포함
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }

  // 이메일 실시간 검증
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // 사용자명 실시간 검증
  static bool isValidUsername(String username) {
    if (username.length < 3 || username.length > 20) return false;
    return RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(username);
  }
}

enum PasswordStrength { none, weak, medium, strong }

// 비밀번호 강도 표시 위젯
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final strength = FormValidationHelper.checkPasswordStrength(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('비밀번호 강도: '),
            Text(
              _getStrengthText(strength),
              style: TextStyle(
                color: _getStrengthColor(strength),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: _getStrengthValue(strength),
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(_getStrengthColor(strength)),
        ),
        if (strength != PasswordStrength.none) ...[
          const SizedBox(height: 8),
          ...(_getPasswordTips(password, strength)),
        ],
      ],
    );
  }

  String _getStrengthText(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.none:
        return '없음';
      case PasswordStrength.weak:
        return '약함';
      case PasswordStrength.medium:
        return '보통';
      case PasswordStrength.strong:
        return '강함';
    }
  }

  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.none:
        return Colors.grey;
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.green;
    }
  }

  double _getStrengthValue(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.none:
        return 0.0;
      case PasswordStrength.weak:
        return 0.33;
      case PasswordStrength.medium:
        return 0.66;
      case PasswordStrength.strong:
        return 1.0;
    }
  }

  List<Widget> _getPasswordTips(String password, PasswordStrength strength) {
    List<String> tips = [];

    if (password.length < 8) {
      tips.add('• 8자 이상 사용하세요');
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      tips.add('• 대문자를 포함하세요');
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      tips.add('• 소문자를 포함하세요');
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      tips.add('• 숫자를 포함하세요');
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      tips.add('• 특수문자를 포함하세요');
    }

    return tips
        .map(
          (tip) => Text(
            tip,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        )
        .toList();
  }
}

// 향상된 로딩 버튼
class EnhancedLoadingButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Duration animationDuration;
  final Color? backgroundColor;
  final Color? textColor;

  const EnhancedLoadingButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<EnhancedLoadingButton> createState() => _EnhancedLoadingButtonState();
}

class _EnhancedLoadingButtonState extends State<EnhancedLoadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? _handleTapDown : null,
      onTapUp: widget.onPressed != null ? _handleTapUp : null,
      onTapCancel: widget.onPressed != null ? _handleTapCancel : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.backgroundColor,
                foregroundColor: widget.textColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.textColor ?? Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

// 폼 입력 애니메이션 헬퍼
class FormAnimationHelper {
  static void shakeField(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: Scaffold.of(context),
      );

      final animation = Tween<double>(
        begin: 0,
        end: 10,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticIn));

      controller.repeat(reverse: true);
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.dispose();
      });
    }
  }

  static void highlightField(
    GlobalKey key, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final context = key.currentContext;
    if (context != null) {
      // 필드 하이라이트 효과
      HapticFeedback.lightImpact();
    }
  }
}

// 토스트 메시지 헬퍼
class ToastHelper {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
