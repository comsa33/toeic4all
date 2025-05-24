import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_providers.dart';

/// 로그인 상태에서 즉시 문제 서비스로 이동시키는 위젯
class AuthRedirectHandler extends ConsumerWidget {
  const AuthRedirectHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    
    // 인증 상태가 변경되면 자동으로 리디렉션
    // 이 위젯은 LoginScreen 위에 배치하거나 래핑하여 사용
    if (authState.isAuthenticated && authState.accessToken != null) {
      debugPrint('⭐️ 인증됨 - 문제 서비스로 리디렉션 시작');
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/questions');
      });
    }
    
    return const SizedBox.shrink(); // 실제 UI를 렌더링하지 않음
  }
}

/// 로그인 화면에서 사용할 AuthRedirect를 포함하는 래퍼
class LoginWithRedirect extends ConsumerWidget {
  final Widget child;
  
  const LoginWithRedirect({
    Key? key, 
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        const AuthRedirectHandler(),
      ],
    );
  }
}
