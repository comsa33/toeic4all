import 'package:flutter/material.dart';
import '../../core/utils/password_policy_validator.dart';
import '../../core/constants/app_colors.dart';

/// 비밀번호 강도 표시기
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final bool showDetails;
  
  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final strength = PasswordPolicyValidator.getPasswordStrength(password);
    final result = PasswordPolicyValidator.validatePassword(password);
    final strengthColor = PasswordPolicyValidator.getStrengthColor(strength);
    final strengthText = PasswordPolicyValidator.getStrengthText(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 강도 표시바
        Row(
          children: [
            Expanded(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: result.strengthScore,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              strengthText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: strengthColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        if (showDetails && password.isNotEmpty) ...[
          const SizedBox(height: 16),
          // 정책 요구사항 목록
          ...PasswordPolicyValidator.getPolicyRequirements(password).map(
            (requirement) => _PolicyRequirementItem(requirement: requirement),
          ),
        ],
      ],
    );
  }
}

/// 정책 요구사항 항목 위젯
class _PolicyRequirementItem extends StatelessWidget {
  final PolicyRequirement requirement;
  
  const _PolicyRequirementItem({required this.requirement});

  @override
  Widget build(BuildContext context) {
    final color = requirement.satisfied ? Colors.green : Colors.grey;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            requirement.satisfied ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Icon(
            requirement.icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              requirement.text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                decoration: requirement.satisfied ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 개선된 비밀번호 입력 필드
class EnhancedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmitted;
  final bool showStrengthIndicator;
  final bool showPolicyDetails;
  
  const EnhancedPasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.textInputAction,
    this.onSubmitted,
    this.showStrengthIndicator = false,
    this.showPolicyDetails = false,
  });

  @override
  State<EnhancedPasswordField> createState() => _EnhancedPasswordFieldState();
}

class _EnhancedPasswordFieldState extends State<EnhancedPasswordField> {
  bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted != null ? (_) => widget.onSubmitted!() : null,
          onChanged: widget.showStrengthIndicator ? (_) => setState(() {}) : null,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
        ),
        
        if (widget.showStrengthIndicator && widget.controller.text.isNotEmpty) ...[
          const SizedBox(height: 12),
          PasswordStrengthIndicator(
            password: widget.controller.text,
            showDetails: widget.showPolicyDetails,
          ),
        ],
      ],
    );
  }
}
