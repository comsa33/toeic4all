// lib/features/auth/presentation/pages/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/themes/typography.dart';
import '../providers/auth_providers.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _hasNavigated = false; // 네비게이션 중복 실행 방지
  bool _isInitializing = false; // 초기화 중복 실행 방지

  @override
  void initState() {
    super.initState();
    // 앱 시작 시 한 번만 자동 초기화
    if (!_isInitializing && !_hasNavigated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeApp();
      });
    }
  }

  Future<void> _initializeApp() async {
    if (_isInitializing || _hasNavigated) {
      debugPrint('⚠️ 이미 초기화 중이거나 네비게이션됨 - 건너뛰기');
      return;
    }

    _isInitializing = true;
    debugPrint('🚀 앱 초기화 시작');

    try {
      // 스플래시 화면 최소 표시 시간
      final splashDelay = Future.delayed(const Duration(seconds: 2));

      // 자동 로그인 체크 시작 (한 번만)
      final authController = ref.read(authControllerProvider.notifier);
      final currentState = ref.read(authControllerProvider);

      if (!currentState.isInitialized) {
        debugPrint('🔍 자동 로그인 체크 시작');
        await authController.checkAuthStatus();
      } else {
        debugPrint('✅ 이미 초기화됨 - 인증 체크 건너뛰기');
      }

      // 스플래시 최소 시간 대기
      await splashDelay;

      if (mounted && !_hasNavigated) {
        _navigateToNextScreen();
      }
    } catch (e) {
      debugPrint('❌ 앱 초기화 중 오류: $e');
      if (mounted && !_hasNavigated) {
        // 오류가 발생해도 로그인 화면으로 이동
        _navigateToNextScreen(forceLogin: true);
      }
    } finally {
      _isInitializing = false;
    }
  }

  void _navigateToNextScreen({bool forceLogin = false}) {
    if (_hasNavigated) {
      debugPrint('⚠️ 이미 네비게이션됨 - 건너뛰기');
      return;
    }

    _hasNavigated = true;

    final authState = ref.read(authControllerProvider);

    debugPrint('🧭 스플래시 화면 - 네비게이션 결정');
    debugPrint('   - isInitialized: ${authState.isInitialized}');
    debugPrint('   - isAuthenticated: ${authState.isAuthenticated}');
    debugPrint('   - hasToken: ${authState.accessToken != null}');
    debugPrint('   - user: ${authState.user?.username}');
    debugPrint('   - forceLogin: $forceLogin');

    if (!forceLogin &&
        authState.isAuthenticated &&
        authState.accessToken != null) {
      debugPrint('✅ 자동 로그인 성공 - 문제 서비스로 이동');
      context.go('/questions');
    } else {
      debugPrint('🔑 로그인 필요 - 로그인 화면으로 이동');
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen 제거 - _initializeApp()에서만 네비게이션 처리하여 중복 방지

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 앱 로고
                Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.easeOutBack)
                    .then(delay: 200.ms)
                    .shimmer(duration: 1000.ms),

                const SizedBox(height: 32),

                // 앱 이름
                Text(
                      AppStrings.appName,
                      style: AppTypography.headingXL.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 8),

                // 앱 설명
                Text(
                      AppStrings.appDescription,
                      style: AppTypography.bodyL.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    )
                    .animate(delay: 600.ms)
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 80),

                // 로딩 인디케이터와 상태 메시지
                Consumer(
                  builder: (context, ref, child) {
                    final authState = ref.watch(authControllerProvider);

                    return Column(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.8),
                            ),
                            strokeWidth: 3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getLoadingMessage(authState),
                          style: AppTypography.bodyM.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ).animate(delay: 1200.ms).fadeIn(duration: 600.ms),

                const SizedBox(height: 40),

                // 버전 정보 (선택사항)
                Text(
                  'v1.0.0',
                  style: AppTypography.bodyS.copyWith(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ).animate(delay: 1500.ms).fadeIn(duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getLoadingMessage(AuthState authState) {
    if (!authState.isInitialized) {
      if (authState.isLoading) {
        return '로그인 상태를 확인하고 있습니다...';
      } else {
        return '앱을 시작하고 있습니다...';
      }
    } else if (authState.isAuthenticated) {
      return '환영합니다! 앱을 준비하고 있습니다...';
    } else {
      return '로그인 화면으로 이동합니다...';
    }
  }
}
