import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 로그인 시도 횟수를 관리하는 서비스
class LoginAttemptService {
  static const String _loginAttemptsKey = 'login_attempts';
  static const String _lastAttemptTimeKey = 'last_attempt_time';
  static const String _lockoutUntilKey = 'lockout_until';
  
  static const int maxAttempts = 5; // 최대 로그인 시도 횟수
  static const int lockoutDurationMinutes = 15; // 잠금 시간 (분)
  static const int attemptResetHours = 24; // 시도 횟수 리셋 시간 (시간)

  final SharedPreferences _prefs;

  LoginAttemptService(this._prefs);

  /// 현재 로그인 시도 횟수를 가져옵니다.
  int getCurrentAttempts() {
    return _prefs.getInt(_loginAttemptsKey) ?? 0;
  }

  /// 마지막 로그인 시도 시간을 가져옵니다.
  DateTime? getLastAttemptTime() {
    final timestamp = _prefs.getInt(_lastAttemptTimeKey);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
  }

  /// 계정 잠금 해제 시간을 가져옵니다.
  DateTime? getLockoutUntil() {
    final timestamp = _prefs.getInt(_lockoutUntilKey);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
  }

  /// 로그인 실패 시 시도 횟수를 증가시킵니다.
  Future<void> recordFailedAttempt() async {
    final now = DateTime.now();
    final currentAttempts = getCurrentAttempts();
    final lastAttempt = getLastAttemptTime();

    // 24시간이 지났으면 시도 횟수를 리셋
    if (lastAttempt != null && 
        now.difference(lastAttempt).inHours >= attemptResetHours) {
      await resetAttempts();
      await _prefs.setInt(_loginAttemptsKey, 1);
    } else {
      await _prefs.setInt(_loginAttemptsKey, currentAttempts + 1);
    }

    await _prefs.setInt(_lastAttemptTimeKey, now.millisecondsSinceEpoch);

    // 최대 시도 횟수에 도달하면 잠금 시간 설정
    if (getCurrentAttempts() >= maxAttempts) {
      final lockoutUntil = now.add(Duration(minutes: lockoutDurationMinutes));
      await _prefs.setInt(_lockoutUntilKey, lockoutUntil.millisecondsSinceEpoch);
      
      debugPrint('🔒 계정 잠금: ${getCurrentAttempts()}회 실패로 인해 $lockoutDurationMinutes분간 잠금');
    }
  }

  /// 로그인 성공 시 시도 횟수를 리셋합니다.
  Future<void> resetAttempts() async {
    await _prefs.remove(_loginAttemptsKey);
    await _prefs.remove(_lastAttemptTimeKey);
    await _prefs.remove(_lockoutUntilKey);
    debugPrint('✅ 로그인 시도 횟수 리셋');
  }

  /// 현재 계정이 잠금 상태인지 확인합니다.
  bool isLockedOut() {
    final lockoutUntil = getLockoutUntil();
    if (lockoutUntil == null) return false;
    
    final now = DateTime.now();
    return now.isBefore(lockoutUntil);
  }

  /// 잠금 해제까지 남은 시간(분)을 가져옵니다.
  int getRemainingLockoutMinutes() {
    final lockoutUntil = getLockoutUntil();
    if (lockoutUntil == null) return 0;
    
    final now = DateTime.now();
    if (now.isAfter(lockoutUntil)) {
      // 잠금 시간이 지났으면 잠금 해제
      _clearLockout();
      return 0;
    }
    
    return lockoutUntil.difference(now).inMinutes + 1;
  }

  /// 잠금 상태를 해제합니다.
  Future<void> _clearLockout() async {
    await _prefs.remove(_lockoutUntilKey);
  }

  /// 경고 메시지가 필요한지 확인합니다.
  bool shouldShowWarning() {
    final attempts = getCurrentAttempts();
    return attempts >= 3 && attempts < maxAttempts;
  }

  /// 남은 시도 횟수를 가져옵니다.
  int getRemainingAttempts() {
    final attempts = getCurrentAttempts();
    return (maxAttempts - attempts).clamp(0, maxAttempts);
  }

  /// 로그인 시도 상태 정보를 가져옵니다.
  LoginAttemptStatus getStatus() {
    if (isLockedOut()) {
      return LoginAttemptStatus.lockedOut(getRemainingLockoutMinutes());
    } else if (shouldShowWarning()) {
      return LoginAttemptStatus.warning(getRemainingAttempts());
    } else {
      return LoginAttemptStatus.normal();
    }
  }
}

/// 로그인 시도 상태를 나타내는 클래스
class LoginAttemptStatus {
  final LoginAttemptType type;
  final int? value;

  const LoginAttemptStatus._(this.type, this.value);

  factory LoginAttemptStatus.normal() => const LoginAttemptStatus._(LoginAttemptType.normal, null);
  factory LoginAttemptStatus.warning(int remainingAttempts) => LoginAttemptStatus._(LoginAttemptType.warning, remainingAttempts);
  factory LoginAttemptStatus.lockedOut(int remainingMinutes) => LoginAttemptStatus._(LoginAttemptType.lockedOut, remainingMinutes);

  bool get isNormal => type == LoginAttemptType.normal;
  bool get isWarning => type == LoginAttemptType.warning;
  bool get isLockedOut => type == LoginAttemptType.lockedOut;

  int get remainingAttempts => value ?? 0;
  int get remainingMinutes => value ?? 0;

  String getWarningMessage() {
    switch (type) {
      case LoginAttemptType.warning:
        return '로그인에 $remainingAttempts회 더 실패하면 계정이 15분간 잠깁니다.';
      case LoginAttemptType.lockedOut:
        return '너무 많은 로그인 시도로 계정이 잠겼습니다. ${remainingMinutes}분 후에 다시 시도해주세요.';
      case LoginAttemptType.normal:
        return '';
    }
  }
}

enum LoginAttemptType {
  normal,
  warning,
  lockedOut,
}
