import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/auth/presentation/pages/forgot_password_screen.dart';
import '../../features/auth/presentation/pages/settings_screen.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/test/test_screen.dart';
import '../../features/questions/presentation/pages/questions_main_screen.dart';
import '../../features/questions/presentation/pages/part5_filter_screen.dart';
import '../../shared/widgets/app_button.dart';

// GoRouter 라우팅을 위한 상태 변경 알림 클래스
class AuthStateNotifier extends ChangeNotifier {
  final Ref _ref;
  AuthState? _previousAuthState;

  AuthStateNotifier(this._ref) {
    _ref.listen<AuthState>(authControllerProvider, (previous, next) {
      final isLoggedInChanged =
          previous?.isAuthenticated != next.isAuthenticated;
      final tokenChanged = previous?.accessToken != next.accessToken;
      final initializationChanged =
          previous?.isInitialized != next.isInitialized;

      if (isLoggedInChanged || tokenChanged || initializationChanged) {
        debugPrint(
          '⚡ 인증 상태 변경 감지됨: isAuth=${next.isAuthenticated}, hasToken=${next.accessToken != null}, isInit=${next.isInitialized}',
        );
        _previousAuthState = next;
        notifyListeners();
      }
    });
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final notifier = AuthStateNotifier(ref);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {
      debugPrint('🧭 라우터 리디렉션: 경로=${state.uri.path}');
      debugPrint(
        '🔑 인증상태: isAuth=${authState.isAuthenticated}, hasToken=${authState.accessToken != null}, isInit=${authState.isInitialized}',
      );

      final currentPath = state.uri.path;
      final isAuthenticated =
          authState.isAuthenticated && authState.accessToken != null;

      // 앱이 아직 초기화되지 않았으면 스플래시 화면에서 대기
      if (!authState.isInitialized && currentPath != '/') {
        debugPrint('⏳ 앱 초기화 대기 중 - 스플래시로 리디렉션');
        return '/';
      }

      // 로딩 중에는 현재 화면 유지
      if (authState.isLoading && currentPath == '/') {
        debugPrint('⏳ 로딩 중 - 현재 화면 유지');
        return null;
      }

      // 스플래시 화면은 자체적으로 네비게이션 처리
      if (currentPath == '/') {
        debugPrint('🚀 스플래시 화면 - 자체 네비게이션 사용');
        return null;
      }

      // 로그인/회원가입/비밀번호 찾기 페이지인지 확인
      final isOnAuthPage =
          currentPath == '/login' ||
          currentPath == '/signup' ||
          currentPath == '/forgot-password';

      // 1. 인증된 사용자가 인증 페이지 접근 시 문제 서비스로 리디렉션
      if (isAuthenticated && isOnAuthPage) {
        debugPrint('🔄 인증된 사용자가 인증 페이지 접근 - 문제 서비스로 리디렉션');
        return '/questions';
      }

      // 2. 인증되지 않은 사용자가 보호된 페이지 접근 시 로그인으로 리디렉션
      // (테스트 페이지는 예외)
      if (!isAuthenticated && !isOnAuthPage && currentPath != '/test') {
        debugPrint('🔒 비인증 사용자가 보호된 페이지 접근 - 로그인으로 리디렉션');
        return '/login';
      }

      // 리디렉션 필요 없음
      debugPrint('✅ 현재 경로 유지: $currentPath');
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/test',
        builder: (context, state) => const SimpleTestScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      // 새로 추가된 비밀번호 찾기 경로
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/questions',
        builder: (context, state) => const QuestionsMainScreen(),
        routes: [
          GoRoute(
            path: '/part5/filter',
            builder: (context, state) => const Part5FilterScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/statistics',
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});

// Home Screen with logout functionality
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TOEIC4ALL'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutDialog(context, ref);
            },
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (authState.user != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          authState.user!.profile.name
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '환영합니다, ${authState.user!.profile.name}님!',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        authState.user!.email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],

            // Feature buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _FeatureCard(
                    icon: Icons.quiz,
                    title: '문제 풀이',
                    subtitle: 'TOEIC 문제 연습',
                    onTap: () => context.push('/questions'),
                  ),
                  _FeatureCard(
                    icon: Icons.analytics,
                    title: '통계',
                    subtitle: '학습 진도 확인',
                    onTap: () => context.push('/statistics'),
                  ),
                  _FeatureCard(
                    icon: Icons.person,
                    title: '프로필',
                    subtitle: '내 정보 관리',
                    onTap: () => context.push('/profile'),
                  ),
                  _FeatureCard(
                    icon: Icons.settings,
                    title: '설정',
                    subtitle: '앱 설정',
                    onTap: () => context.push('/settings'),
                  ),
                ],
              ),
            ),

            AppButton.outline(
              text: '로그아웃',
              onPressed: () => _showLogoutDialog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말로 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            AppButton.primary(
              text: '로그아웃',
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(authControllerProvider.notifier).signOut();
              },
            ),
          ],
        );
      },
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder screens
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('통계')),
      body: const Center(
        child: Text(
          '통계 화면\n곧 업데이트됩니다!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프로필')),
      body: const Center(
        child: Text(
          '프로필 화면\n곧 업데이트됩니다!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
