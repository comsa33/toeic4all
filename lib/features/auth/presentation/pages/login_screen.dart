import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/auth_providers.dart';
import '../utils/auth_message_handler.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoLoginEnabled = true; // 자동 로그인 체크박스 상태
  String? _currentSocialProvider; // 현재 진행 중인 소셜 로그인 제공자

  @override
  void initState() {
    super.initState();
    _loadAutoLoginSetting();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 자동 로그인 설정 로드
  void _loadAutoLoginSetting() async {
    try {
      final authController = ref.read(authControllerProvider.notifier);
      final isEnabled = await authController.isAutoLoginEnabled();
      if (mounted) {
        setState(() {
          _autoLoginEnabled = isEnabled;
        });
      }
    } catch (e) {
      debugPrint('자동 로그인 설정 로드 실패: $e');
    }
  }

  // 로그인 시도 상태 확인
  Widget _buildLoginAttemptWarning() {
    final loginAttemptService = ref.watch(loginAttemptServiceProvider);
    final status = loginAttemptService.getStatus();
    
    if (status.isNormal) {
      return const SizedBox.shrink();
    }
    
    Color backgroundColor;
    IconData icon;
    String message;
    
    if (status.isLockedOut) {
      backgroundColor = Theme.of(context).colorScheme.errorContainer;
      icon = Icons.lock;
      message = status.getWarningMessage();
    } else if (status.isWarning) {
      backgroundColor = Colors.orange.withOpacity(0.1);
      icon = Icons.warning;
      message = status.getWarningMessage();
    } else {
      return const SizedBox.shrink();
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: status.isLockedOut 
            ? Theme.of(context).colorScheme.error
            : Colors.orange,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: status.isLockedOut 
              ? Theme.of(context).colorScheme.error
              : Colors.orange.shade700,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: status.isLockedOut 
                  ? Theme.of(context).colorScheme.error
                  : Colors.orange.shade700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text;

      debugPrint('🔄 로그인 요청 시작: $username');
      debugPrint('🔧 자동 로그인 설정: $_autoLoginEnabled');

      try {
        // 자동 로그인 설정 저장
        await ref
            .read(authControllerProvider.notifier)
            .setAutoLoginEnabled(_autoLoginEnabled);

        // 로그인 시도
        await ref
            .read(authControllerProvider.notifier)
            .signInWithUsername(username: username, password: password);

        // mounted 체크
        if (!mounted) return;

        // 상태 확인 및 네비게이션
        final authState = ref.read(authControllerProvider);
        debugPrint(
          '📊 로그인 후 상태 확인: isAuthenticated=${authState.isAuthenticated}, hasToken=${authState.accessToken != null}',
        );

        if (authState.isAuthenticated && authState.accessToken != null) {
          debugPrint('🎯 인증 성공 확인됨 - /questions로 이동');

          // 네비게이션 - replace 사용으로 뒤로가기 방지
          context.go('/questions');

          // 성공 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            AuthSnackBarHelper.success(
              AuthMessageHandler.getSuccessMessage(
                action: 'login',
                userName: authState.user?.profile.name ?? username,
              ),
            ),
          );
        } else {
          debugPrint('⚠️ 로그인 후에도 인증 상태가 false임');
        }
      } catch (e) {
        debugPrint('❌ 로그인 중 예외 발생: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthSnackBarHelper.error('로그인에 실패했습니다. 다시 시도해주세요.'),
          );
        }
      }
    }
  }

  // 소셜 로그인 처리
  Future<void> _handleSocialLogin(String provider) async {
    final authState = ref.read(authControllerProvider);
    
    // 각 소셜 로그인별 로딩 상태 확인하여 중복 실행 방지
    if ((provider == 'google' && authState.isGoogleLoading) ||
        (provider == 'apple' && authState.isAppleLoading) ||
        (provider == 'kakao' && authState.isKakaoLoading) ||
        (provider == 'naver' && authState.isNaverLoading)) {
      debugPrint('⚠️ 이미 ${provider} 로그인이 진행 중입니다');
      return;
    }
    
    try {
      // 소셜 로그인 메서드 호출
      bool success = false;
      String? userName;
      
      switch (provider) {
        case 'google':
          await ref.read(authControllerProvider.notifier).signInWithGoogle();
          break;
        case 'apple':
          await ref.read(authControllerProvider.notifier).signInWithApple();
          break;
        case 'kakao':
          await ref.read(authControllerProvider.notifier).signInWithKakao();
          break;
        case 'naver':
          await ref.read(authControllerProvider.notifier).signInWithNaver();
          break;
      }
      
      // 로그인 성공 확인
      final newAuthState = ref.read(authControllerProvider);
      if (newAuthState.isAuthenticated && !authState.isAuthenticated) {
        userName = newAuthState.user?.profile.name;
        
        if (mounted && userName != null) {
          // 성공 메시지 표시 (만약 AuthController에서 설정하지 않았다면)
          if (newAuthState.successMessage == null) {
            String providerName = '';
            switch (provider) {
              case 'google': providerName = 'Google'; break;
              case 'apple': providerName = 'Apple'; break;
              case 'kakao': providerName = '카카오'; break;
              case 'naver': providerName = '네이버'; break;
            }
            
            String message = '$providerName 계정으로 로그인되었습니다. 환영합니다, $userName님!';
            ScaffoldMessenger.of(context).showSnackBar(AuthSnackBarHelper.success(message));
          }
        }
      }
    } catch (e) {
      debugPrint('❌ ${provider} 로그인 중 오류 발생: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          AuthSnackBarHelper.error('${provider} 로그인에 실패했습니다. 다시 시도해주세요.'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // 에러/성공 메시지 표시
    ref.listen(authControllerProvider, (previous, next) {
      // 에러 메시지 처리
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthSnackBarHelper.error(next.errorMessage!),
            );
            ref.read(authControllerProvider.notifier).clearError();
          }
        });
      }
      
      // 성공 메시지 처리
      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthSnackBarHelper.success(next.successMessage!),
            );
            ref.read(authControllerProvider.notifier).clearError();
          }
        });
      }
      
      // 인증 상태 변경 처리 - 소셜 로그인 성공 시 네비게이션
      if (next.isAuthenticated && next.accessToken != null && !previous!.isAuthenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            // 소셜 로그인 성공 시에도 메인 화면으로 이동
            context.go('/questions');
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
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
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

                // Login Attempt Warning
                _buildLoginAttemptWarning(),

                // Username Field
                AppTextField.username(
                  controller: _usernameController,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: Validators.username,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                // Password Field - 수정된 부분 (커스텀 suffixIcon 제거)
                AppTextField.password(
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: Validators.password,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleLogin(),
                ),

                const SizedBox(height: 12),

                // Forgot Password & Auto Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Auto Login Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _autoLoginEnabled,
                          onChanged: (value) {
                            setState(() {
                              _autoLoginEnabled = value ?? true;
                            });
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _autoLoginEnabled = !_autoLoginEnabled;
                            });
                          },
                          child: Text(
                            '자동 로그인',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ],
                    ),
                    // Forgot Password
                    TextButton(
                      onPressed: () => context.push('/forgot-password'),
                      child: Text(AppStrings.forgotPassword),
                    ),
                  ],
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
                      onPressed: authState.isGoogleLoading ? null : () => _handleSocialLogin('google'),
                      isLoading: authState.isGoogleLoading,
                    ),
                    _SocialLoginButton(
                      icon: Icons.apple,
                      label: 'Apple',
                      onPressed: authState.isAppleLoading ? null : () => _handleSocialLogin('apple'),
                      isLoading: authState.isAppleLoading,
                    ),
                    _SocialLoginButton(
                      icon: Icons.chat_bubble,
                      label: 'Kakao',
                      onPressed: authState.isKakaoLoading ? null : () => _handleSocialLogin('kakao'),
                      isLoading: authState.isKakaoLoading,
                    ),
                    _SocialLoginButton(
                      icon: Icons.language,
                      label: 'Naver',
                      onPressed: authState.isNaverLoading ? null : () => _handleSocialLogin('naver'),
                      isLoading: authState.isNaverLoading,
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
  final VoidCallback? onPressed;
  final bool isLoading;

  const _SocialLoginButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
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
          child: isLoading 
            ? Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            : IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
