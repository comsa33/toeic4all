import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text;
      
      debugPrint('🔄 로그인 요청 시작: $username');
      
      try {
        // 로그인 시도
        await ref.read(authControllerProvider.notifier).signInWithUsername(
          username: username,
          password: password,
        );
        
        // mounted 체크
        if (!mounted) return;
        
        // 상태 확인 및 네비게이션
        final authState = ref.read(authControllerProvider);
        debugPrint('📊 로그인 후 상태 확인: isAuthenticated=${authState.isAuthenticated}, hasToken=${authState.accessToken != null}');
        
        if (authState.isAuthenticated && authState.accessToken != null) {
          debugPrint('🎯 인증 성공 확인됨 - /questions로 이동');
          
          // 네비게이션 - replace 사용으로 뒤로가기 방지
          context.go('/questions');
          
          // 성공 메시지 표시 (선택사항)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('로그인되었습니다!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          debugPrint('⚠️ 로그인 후에도 인증 상태가 false임');
          debugPrint('🔍 AuthState 상세: ${authState.toString()}');
        }
      } catch (e) {
        debugPrint('❌ 로그인 중 예외 발생: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('로그인 중 오류가 발생했습니다: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _handleSocialLogin(String provider) {
    switch (provider) {
      case 'google':
        ref.read(authControllerProvider.notifier).signInWithGoogle();
        break;
      case 'apple':
        ref.read(authControllerProvider.notifier).signInWithApple();
        break;
      case 'kakao':
        ref.read(authControllerProvider.notifier).signInWithKakao();
        break;
      case 'naver':
        ref.read(authControllerProvider.notifier).signInWithNaver();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    
    // 상태 변경 감지와 화면 전환 처리는 _handleLogin에서 직접 처리하도록 변경
    // 에러 메시지 표시만 여기서 처리
    ref.listen(authControllerProvider, (previous, next) {
      debugPrint('🔑 Auth state changed: isAuthenticated=${next.isAuthenticated}, tokens=${next.accessToken != null}');
      
      // 상태 변경에 따른 디버그 로깅
      if (previous?.isAuthenticated != next.isAuthenticated || 
          (previous?.accessToken != null) != (next.accessToken != null)) {
        debugPrint('🔄 인증 상태 변경: ${next.isAuthenticated}, 토큰존재: ${next.accessToken != null}');
      }

      // Show error messages (only if they've changed)
      if (!identical(previous, next) && next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(next.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            // 에러 메시지 초기화
            ref.read(authControllerProvider.notifier).clearError();
          }
        });
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                
                // Logo and Title
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppStrings.appName,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.welcomeMessage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                
                const SizedBox(height: 48),
                
                // Username Field
                AppTextField(
                  controller: _usernameController,
                  label: AppStrings.username,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: Validators.username,
                  textInputAction: TextInputAction.next,
                ),
                
                const SizedBox(height: 16),
                
                // Password Field
                AppTextField(
                  controller: _passwordController,
                  label: AppStrings.password,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: Validators.password,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleLogin(),
                ),
                
                const SizedBox(height: 12),
                
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/forgot-password'),
                    child: Text(AppStrings.forgotPassword),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Login Button
                AppButton.primary(
                  text: AppStrings.signIn,
                  onPressed: authState.isLoading ? null : _handleLogin,
                  isLoading: authState.isLoading,
                ),
                
                const SizedBox(height: 24),
                
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.orContinueWith,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Social Login Buttons
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _SocialLoginButton(
                      icon: Icons.g_mobiledata,
                      label: 'Google',
                      onPressed: () => _handleSocialLogin('google'),
                    ),
                    _SocialLoginButton(
                      icon: Icons.apple,
                      label: 'Apple',
                      onPressed: () => _handleSocialLogin('apple'),
                    ),
                    _SocialLoginButton(
                      icon: Icons.chat_bubble,
                      label: 'Kakao',
                      onPressed: () => _handleSocialLogin('kakao'),
                    ),
                    _SocialLoginButton(
                      icon: Icons.language,
                      label: 'Naver',
                      onPressed: () => _handleSocialLogin('naver'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 48),
                
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => context.push('/signup'),
                      child: Text(AppStrings.signUp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 28,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
