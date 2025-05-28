import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/password_policy_validator.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/enhanced_password_field.dart';
import '../providers/auth_providers.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleChangePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentPassword = _currentPasswordController.text.trim();
      final newPassword = _newPasswordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      // 비밀번호 정책 검증
      final policyResult = PasswordPolicyValidator.validatePassword(newPassword);
      if (!policyResult.isValid) {
        _showErrorSnackBar('새 비밀번호가 보안 정책을 만족하지 않습니다. 정책 요구사항을 확인해주세요.');
        return;
      }

      // 비밀번호 확인 검증
      if (newPassword != confirmPassword) {
        _showErrorSnackBar('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
        return;
      }

      try {
        await ref.read(authControllerProvider.notifier).changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        );
      } catch (e) {
        if (mounted) {
          _showErrorSnackBar('예상치 못한 오류가 발생했습니다: ${e.toString()}');
        }
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 48,
          ),
        ),
        title: const Text(
          '비밀번호 변경 완료',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    size: 20,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '보안을 위해 다른 기기에서도 다시 로그인해주세요.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          AppButton.primary(
            text: '확인',
            onPressed: () {
              // 성공 메시지 클리어
              ref.read(authControllerProvider.notifier).clearError();
              Navigator.of(context).pop(); // 다이얼로그 닫기
              context.pop(); // 설정 화면으로 돌아가기
            },
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: '닫기',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '새 비밀번호 확인을 입력해주세요';
    }
    if (value != _newPasswordController.text) {
      return '비밀번호가 일치하지 않습니다';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '새 비밀번호를 입력해주세요';
    }
    
    final policyResult = PasswordPolicyValidator.validatePassword(value);
    if (!policyResult.isValid) {
      return '비밀번호 정책을 확인해주세요';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // 에러 메시지 및 성공 메시지 표시
    ref.listen(authControllerProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showErrorSnackBar(next.errorMessage!);
          }
        });
      }
      
      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showSuccessDialog(next.successMessage!);
          }
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 변경'),
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
                const SizedBox(height: 32),

                // 아이콘
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    Icons.lock_person,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 32),

                // 제목
                Text(
                  '비밀번호 변경',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // 설명
                Text(
                  '보안을 위해 현재 비밀번호를 확인한 후 새로운 비밀번호로 변경할 수 있습니다.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // 현재 비밀번호 입력 필드
                EnhancedPasswordField(
                  controller: _currentPasswordController,
                  label: '현재 비밀번호',
                  hint: '현재 비밀번호를 입력하세요',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '현재 비밀번호를 입력해주세요';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  showStrengthIndicator: false, // 현재 비밀번호는 강도 표시 안 함
                  showPolicyDetails: false,     // 현재 비밀번호는 정책 체크 안 함
                ),

                const SizedBox(height: 24),

                // 새 비밀번호 입력 필드
                EnhancedPasswordField(
                  controller: _newPasswordController,
                  label: '새 비밀번호',
                  hint: '새 비밀번호를 입력하세요',
                  validator: _validateNewPassword,
                  textInputAction: TextInputAction.next,
                  showStrengthIndicator: true,
                  showPolicyDetails: true,
                ),

                const SizedBox(height: 24),

                // 새 비밀번호 확인 입력 필드
                EnhancedPasswordField(
                  controller: _confirmPasswordController,
                  label: '새 비밀번호 확인',
                  hint: '새 비밀번호를 다시 입력하세요',
                  validator: _validateConfirmPassword,
                  textInputAction: TextInputAction.done,
                  onSubmitted: () => _handleChangePassword(),
                  showStrengthIndicator: false, // 확인 필드는 강도 표시 안 함
                  showPolicyDetails: false,     // 확인 필드는 정책 체크 안 함
                ),

                const SizedBox(height: 32),

                // 비밀번호 변경 버튼
                AppButton.primary(
                  text: '비밀번호 변경',
                  onPressed: authState.isLoading ? null : _handleChangePassword,
                  isLoading: authState.isLoading,
                ),

                const SizedBox(height: 24),

                // 도움말
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                            '비밀번호 보안 안내',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• 8자 이상의 복잡한 비밀번호를 사용하세요\n'
                        '• 대문자, 소문자, 숫자, 특수문자를 포함하세요\n'
                        '• 이전에 사용한 비밀번호는 피해주세요\n'
                        '• 개인정보(이름, 생일 등)는 사용하지 마세요',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
