import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

/// 로그인 상태와 인증 토큰을 디버그 로깅하는 헬퍼 함수
void logAuthStatus(WidgetRef ref) {
  final authState = ref.read(authControllerProvider);
  debugPrint('=== 인증 상태 ===');
  debugPrint('인증됨: ${authState.isAuthenticated}');
  debugPrint('액세스 토큰: ${authState.accessToken?.substring(0, 10)}...');
  debugPrint('리프레시 토큰: ${authState.refreshToken?.substring(0, 10)}...');
  debugPrint('사용자: ${authState.user?.username ?? 'null'}');
  debugPrint('================');
}
