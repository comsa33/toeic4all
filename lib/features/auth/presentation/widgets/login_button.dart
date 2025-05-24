import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_providers.dart';
import '../utils/auth_status.dart';

/// 로그인 버튼 컴포넌트
/// 로그인 처리와 상태 확인을 포함
class LoginButton extends ConsumerWidget {
  final String text;
  final String username;
  final String password;
  
  const LoginButton({
    super.key, 
    required this.text,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    
    return ElevatedButton(
      onPressed: authState.isLoading 
          ? null 
          : () => _handleLogin(ref, context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: authState.isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
    );
  }
  
  Future<void> _handleLogin(WidgetRef ref, BuildContext context) async {
    // 디버그 로깅
    debugPrint('로그인 시도: $username');
    
    // 로그인 요청
    await ref.read(authControllerProvider.notifier).signInWithUsername(
      username: username,
      password: password,
    );
    
    // 인증 상태 확인
    logAuthStatus(ref);
    
    // 로그인 성공 여부 확인
    final authState = ref.read(authControllerProvider);
    if (authState.isAuthenticated && authState.accessToken != null) {
      // 로그인 완료 후 이동할 화면 설정
      debugPrint('로그인 성공 감지 - 화면 이동');
      if (context.mounted) {
        context.go('/questions');
      }
    }
  }
}
