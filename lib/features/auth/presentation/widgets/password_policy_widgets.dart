import 'package:flutter/material.dart';

/// 비밀번호 정책 검증 결과를 담는 클래스
class PasswordPolicyResult {
  final bool isValid;
  final List<String> failedRules;
  final List<String> passedRules;
  final int strengthScore; // 0-5 점

  const PasswordPolicyResult({
    required this.isValid,
    required this.failedRules,
    required this.passedRules,
    required this.strengthScore,
  });
}

/// 비밀번호 정책 규칙을 나타내는 클래스
class PasswordRule {
  final String name;
  final String description;
  final bool Function(String) validator;
  final IconData icon;

  const PasswordRule({
    required this.name,
    required this.description,
    required this.validator,
    required this.icon,
  });
}

/// 비밀번호 정책 검증 및 피드백을 제공하는 유틸리티 클래스
class PasswordPolicyValidator {
  /// 비밀번호 정책 규칙들
  static final List<PasswordRule> rules = [
    PasswordRule(
      name: 'length',
      description: '최소 8자 이상',
      validator: (password) => password.length >= 8,
      icon: Icons.straighten,
    ),
    PasswordRule(
      name: 'uppercase',
      description: '영문 대문자 포함',
      validator: (password) => password.contains(RegExp(r'[A-Z]')),
      icon: Icons.text_fields,
    ),
    PasswordRule(
      name: 'lowercase',
      description: '영문 소문자 포함',
      validator: (password) => password.contains(RegExp(r'[a-z]')),
      icon: Icons.text_fields,
    ),
    PasswordRule(
      name: 'number',
      description: '숫자 포함',
      validator: (password) => password.contains(RegExp(r'[0-9]')),
      icon: Icons.numbers,
    ),
    PasswordRule(
      name: 'special',
      description: '특수문자 포함',
      validator: (password) => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      icon: Icons.key,
    ),
  ];

  /// 비밀번호 검증 수행
  static PasswordPolicyResult validatePassword(String password) {
    final failedRules = <String>[];
    final passedRules = <String>[];

    for (final rule in rules) {
      if (rule.validator(password)) {
        passedRules.add(rule.name);
      } else {
        failedRules.add(rule.name);
      }
    }

    final strengthScore = _calculateStrengthScore(password, passedRules.length);
    final isValid = failedRules.isEmpty;

    return PasswordPolicyResult(
      isValid: isValid,
      failedRules: failedRules,
      passedRules: passedRules,
      strengthScore: strengthScore,
    );
  }

  /// 비밀번호 강도 점수 계산 (0-5)
  static int _calculateStrengthScore(String password, int passedRulesCount) {
    int score = passedRulesCount; // 기본 점수는 통과한 규칙 수

    // 길이 보너스
    if (password.length >= 12) {
      score = (score + 0.5).round();
    }

    // 다양성 보너스 (연속된 같은 문자가 적을 때)
    if (!password.contains(RegExp(r'(.)\1{2,}'))) {
      score = (score + 0.3).round();
    }

    return score.clamp(0, 5);
  }

  /// 강도 텍스트 반환
  static String getStrengthText(int score) {
    switch (score) {
      case 0:
      case 1:
        return '매우 약함';
      case 2:
        return '약함';
      case 3:
        return '보통';
      case 4:
        return '강함';
      case 5:
        return '매우 강함';
      default:
        return '알 수 없음';
    }
  }

  /// 강도 색상 반환
  static Color getStrengthColor(int score) {
    switch (score) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow.shade700;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// 정책 위반 메시지 생성
  static String getValidationMessage(PasswordPolicyResult result) {
    if (result.isValid) {
      return '비밀번호가 모든 정책을 만족합니다.';
    }

    final failedDescriptions = result.failedRules
        .map((ruleName) => rules.firstWhere((rule) => rule.name == ruleName).description)
        .toList();

    if (failedDescriptions.length == 1) {
      return '${failedDescriptions.first}이 필요합니다.';
    } else if (failedDescriptions.length == 2) {
      return '${failedDescriptions.join('과 ')}이 필요합니다.';
    } else {
      return '${failedDescriptions.take(failedDescriptions.length - 1).join(', ')} 및 ${failedDescriptions.last}이 필요합니다.';
    }
  }
}

/// 비밀번호 강도 표시 위젯
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final bool showDetails;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final result = PasswordPolicyValidator.validatePassword(password);
    
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 강도 바
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: result.strengthScore / 5.0,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  PasswordPolicyValidator.getStrengthColor(result.strengthScore),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              PasswordPolicyValidator.getStrengthText(result.strengthScore),
              style: TextStyle(
                fontSize: 12,
                color: PasswordPolicyValidator.getStrengthColor(result.strengthScore),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        
        if (showDetails) ...[
          const SizedBox(height: 8),
          // 정책 상세
          ...PasswordPolicyValidator.rules.map((rule) {
            final isPassed = result.passedRules.contains(rule.name);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(
                    isPassed ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 16,
                    color: isPassed ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    rule.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isPassed ? Colors.green : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ],
    );
  }
}

/// 향상된 비밀번호 입력 필드 위젯
class EnhancedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final Function(String)? onSubmitted;
  final bool showStrengthIndicator;
  final bool showPolicyDetails;

  const EnhancedPasswordField({
    super.key,
    required this.controller,
    this.label = '비밀번호',
    this.hint = '비밀번호를 입력하세요',
    this.validator,
    this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.showStrengthIndicator = true,
    this.showPolicyDetails = true,
  });

  @override
  State<EnhancedPasswordField> createState() => _EnhancedPasswordFieldState();
}

class _EnhancedPasswordFieldState extends State<EnhancedPasswordField> {
  bool _isObscured = true;
  String _password = '';

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onPasswordChanged);
    super.dispose();
  }

  void _onPasswordChanged() {
    final newPassword = widget.controller.text;
    if (newPassword != _password) {
      setState(() {
        _password = newPassword;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        if (widget.showStrengthIndicator && _password.isNotEmpty) ...[
          const SizedBox(height: 8),
          PasswordStrengthIndicator(
            password: _password,
            showDetails: widget.showPolicyDetails,
          ),
        ],
      ],
    );
  }
}
