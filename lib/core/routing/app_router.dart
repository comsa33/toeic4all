import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_app_layout.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/auth/presentation/pages/forgot_password_screen.dart';
import '../../features/auth/presentation/pages/settings_screen.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/domain/entities/user.dart';
import '../../features/test/test_screen.dart';
import '../../features/questions/presentation/pages/questions_main_screen.dart';
import '../../features/questions/presentation/pages/part5_filter_screen.dart';

// GoRouter 라우팅을 위한 상태 변경 알림 클래스
class AuthStateNotifier extends ChangeNotifier {
  final Ref _ref;

  AuthStateNotifier(this._ref) {
    _ref.listen<AuthState>(authControllerProvider, (previous, next) {
      final isLoggedInChanged =
          previous?.isAuthenticated != next.isAuthenticated;
      final tokenChanged = previous?.accessToken != next.accessToken;

      // 초기화 완료 후 인증 상태나 토큰 변경 시에만 라우터 리디렉션 실행
      if ((isLoggedInChanged || tokenChanged) && next.isInitialized) {
        debugPrint(
          '⚡ 라우터 리디렉션 트리거: isAuth=${next.isAuthenticated}, hasToken=${next.accessToken != null}',
        );
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
      // 초기화가 완료되지 않은 경우에만 스플래시 화면 유지
      if (currentPath == '/') {
        if (authState.isInitialized) {
          debugPrint('🚀 스플래시 화면 - 초기화 완료됨, 자체 네비게이션 허용');
        } else {
          debugPrint('⏳ 스플래시 화면 - 초기화 대기 중');
        }
        return null; // 스플래시 화면이 자체적으로 네비게이션 처리
      }

      // 로그인/회원가입/비밀번호 찾기 페이지인지 확인
      final isOnAuthPage =
          currentPath == '/login' ||
          currentPath == '/signup' ||
          currentPath == '/forgot-password';

      // 1. 인증된 사용자가 인증 페이지 접근 시 홈 화면으로 리디렉션
      if (isAuthenticated && isOnAuthPage) {
        debugPrint('🔄 인증된 사용자가 인증 페이지 접근 - 홈 화면으로 리디렉션');
        return '/home';
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

      // 메인 앱 레이아웃을 위한 ShellRoute
      ShellRoute(
        builder: (context, state, child) =>
            MainAppLayout(currentLocation: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
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
      ),
    ],
  );
});

// Home Screen with improved navigation
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TOEIC4ALL',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          // 설정 아이콘
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
            tooltip: '설정',
          ),
          // 프로필 아이콘
          if (authState.user != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => context.push('/profile'),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    authState.user!.profile.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 환영 메시지 카드
            if (authState.user != null) ...[
              _WelcomeCard(user: authState.user!),
              const SizedBox(height: 24),
            ],

            // 빠른 시작 섹션
            const _QuickStartSection(),

            const SizedBox(height: 32),

            // 기능 그리드
            const _FeatureGrid(),
          ],
        ),
      ),
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

// 환영 메시지 카드 위젯
class _WelcomeCard extends StatelessWidget {
  final User user;

  const _WelcomeCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(Icons.person, size: 30, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '안녕하세요, ${user.profile.name}님!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '오늘도 토익 공부를 시작해보세요',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 빠른 시작 섹션 위젯
class _QuickStartSection extends StatelessWidget {
  const _QuickStartSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '빠른 시작',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.flash_on,
                title: '모의고사',
                subtitle: '실전 연습',
                onTap: () => context.go('/questions'),
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.quiz,
                title: '파트별 문제',
                subtitle: '유형별 학습',
                onTap: () => context.go('/questions'),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 빠른 액션 카드 위젯
class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(icon, size: 24, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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

// 기능 그리드 위젯
class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주요 기능',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _FeatureCard(
              icon: Icons.quiz_outlined,
              title: '문제 풀이',
              subtitle: '다양한 토익 문제',
              onTap: () => context.go('/questions'),
            ),
            _FeatureCard(
              icon: Icons.analytics_outlined,
              title: '학습 통계',
              subtitle: '성과 분석',
              onTap: () => context.go('/statistics'),
            ),
            _FeatureCard(
              icon: Icons.bookmark_outlined,
              title: '오답 노트',
              subtitle: '틀린 문제 복습',
              onTap: () => context.go('/statistics'),
            ),
            _FeatureCard(
              icon: Icons.school_outlined,
              title: '학습 계획',
              subtitle: '맞춤 커리큘럼',
              onTap: () => context.go('/profile'),
            ),
          ],
        ),
      ],
    );
  }
}
