import 'package:flutter/material.dart';

/// 비밀번호 정책 검증 결과
class PasswordPolicyResult {
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasDigit;
  final bool hasSpecialChar;
  
  const PasswordPolicyResult({
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasDigit,
    required this.hasSpecialChar,
  });
  
  /// 모든 정책을 만족하는지 확인
  bool get isValid => hasMinLength && hasUppercase && hasLowercase && hasDigit && hasSpecialChar;
  
  /// 만족한 정책의 개수
  int get satisfiedCount {
    int count = 0;
    if (hasMinLength) count++;
    if (hasUppercase) count++;
    if (hasLowercase) count++;
    if (hasDigit) count++;
    if (hasSpecialChar) count++;
    return count;
  }
  
  /// 강도 점수 (0.0 ~ 1.0)
  double get strengthScore => satisfiedCount / 5.0;
}

/// 비밀번호 강도 레벨
enum PasswordStrength {
  none,
  weak,
  medium,
  strong,
}

/// 비밀번호 정책 검증기
class PasswordPolicyValidator {
  static const int minLength = 8;
  static const String uppercasePattern = r'[A-Z]';
  static const String lowercasePattern = r'[a-z]';
  static const String digitPattern = r'[0-9]';
  static const String specialCharPattern = r'[!@#$%^&*(),.?":{}|<>]';
  
  /// 비밀번호 정책 검증
  static PasswordPolicyResult validatePassword(String password) {
    return PasswordPolicyResult(
      hasMinLength: password.length >= minLength,
      hasUppercase: RegExp(uppercasePattern).hasMatch(password),
      hasLowercase: RegExp(lowercasePattern).hasMatch(password),
      hasDigit: RegExp(digitPattern).hasMatch(password),
      hasSpecialChar: RegExp(specialCharPattern).hasMatch(password),
    );
  }
  
  /// 비밀번호 강도 계산
  static PasswordStrength getPasswordStrength(String password) {
    final result = validatePassword(password);
    
    if (result.satisfiedCount <= 1) {
      return PasswordStrength.none;
    } else if (result.satisfiedCount <= 3) {
      return PasswordStrength.weak;
    } else if (result.satisfiedCount == 4) {
      return PasswordStrength.medium;
    } else {
      return PasswordStrength.strong;
    }
  }
  
  /// 정책 항목별 설명 텍스트
  static List<PolicyRequirement> getPolicyRequirements(String password) {
    final result = validatePassword(password);
    
    return [
      PolicyRequirement(
        text: '최소 8자 이상',
        satisfied: result.hasMinLength,
        icon: Icons.straighten,
      ),
      PolicyRequirement(
        text: '대문자 1개 이상 포함 (A-Z)',
        satisfied: result.hasUppercase,
        icon: Icons.keyboard_arrow_up,
      ),
      PolicyRequirement(
        text: '소문자 1개 이상 포함 (a-z)',
        satisfied: result.hasLowercase,
        icon: Icons.keyboard_arrow_down,
      ),
      PolicyRequirement(
        text: '숫자 1개 이상 포함 (0-9)',
        satisfied: result.hasDigit,
        icon: Icons.numbers,
      ),
      PolicyRequirement(
        text: '특수문자 1개 이상 포함 (!@#\$%^&*)',
        satisfied: result.hasSpecialChar,
        icon: Icons.password,
      ),
    ];
  }
  
  /// 강도별 색상
  static Color getStrengthColor(PasswordStrength strength) {
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
  
  /// 강도별 텍스트
  static String getStrengthText(PasswordStrength strength) {
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
}

/// 정책 요구사항 모델
class PolicyRequirement {
  final String text;
  final bool satisfied;
  final IconData icon;
  
  const PolicyRequirement({
    required this.text,
    required this.satisfied,
    required this.icon,
  });
}
