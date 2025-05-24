import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/themes/typography.dart';
import '../providers/auth_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // 스플래시 화면을 보여주기 위한 최소 지연
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      // 인증 상태 확인
      final authState = ref.read(authControllerProvider);
      
      if (authState.isAuthenticated) {
        // 인증된 사용자는 문제 서비스로 이동
        context.go('/questions');
      } else {
        // 인증되지 않은 사용자는 로그인 페이지로 이동
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
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
              
              // 로딩 인디케이터
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.8),
                  ),
                  strokeWidth: 3,
                ),
              )
                  .animate(delay: 1200.ms)
                  .fadeIn(duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
