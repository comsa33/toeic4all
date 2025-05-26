import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_providers.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isEmailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();

      try {
        await ref
            .read(authControllerProvider.notifier)
            .requestPasswordReset(email);

        setState(() {
          _isEmailSent = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('비밀번호 재설정 이메일을 발송했습니다. 이메일을 확인해주세요.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('오류가 발생했습니다: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // 에러 메시지 표시
    ref.listen(authControllerProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(next.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            ref.read(authControllerProvider.notifier).clearError();
          }
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 찾기'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // 아이콘
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    Icons.lock_reset,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 32),

                // 제목
                Text(
                  _isEmailSent ? '이메일을 확인하세요' : '비밀번호를 잊으셨나요?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // 설명
                Text(
                  _isEmailSent
                      ? '${_emailController.text}로 비밀번호 재설정 링크를 보냈습니다. 이메일을 확인하고 안내에 따라 비밀번호를 재설정하세요.'
                      : '등록하신 이메일 주소를 입력하시면 비밀번호 재설정 링크를 보내드립니다.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                if (!_isEmailSent) ...[
                  // 이메일 입력 필드
                  AppTextField(
                    controller: _emailController,
                    label: '이메일',
                    hint: '이메일 주소를 입력하세요',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력해주세요';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return '올바른 이메일 형식을 입력해주세요';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _handlePasswordReset(),
                  ),

                  const SizedBox(height: 32),

                  // 재설정 링크 보내기 버튼
                  AppButton.primary(
                    text: '재설정 링크 보내기',
                    onPressed: authState.isLoading
                        ? null
                        : _handlePasswordReset,
                    isLoading: authState.isLoading,
                  ),

                  const SizedBox(height: 24),

                  // 로그인으로 돌아가기
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '비밀번호가 기억나셨나요?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('로그인하기'),
                      ),
                    ],
                  ),
                ] else ...[
                  // 이메일 발송 완료 후 액션 버튼들
                  AppButton.primary(
                    text: '이메일 앱 열기',
                    onPressed: () {
                      // 이메일 앱 열기 로직 (선택사항)
                      // launch('mailto:');
                    },
                  ),

                  const SizedBox(height: 16),

                  AppButton.outline(
                    text: '다른 이메일로 재전송',
                    onPressed: () {
                      setState(() {
                        _isEmailSent = false;
                        _emailController.clear();
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('로그인 화면으로 돌아가기'),
                  ),
                ],

                const SizedBox(height: 40),

                // 도움말
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '도움말',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• 이메일이 도착하지 않으면 스팸함을 확인해주세요\n'
                        '• 재설정 링크는 24시간 후 만료됩니다\n'
                        '• 문제가 계속되면 고객센터로 문의해주세요',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
