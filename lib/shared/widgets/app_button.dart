import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../themes/typography.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final Widget? icon;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = false,
  });

  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = false,
  }) : type = AppButtonType.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = false,
  }) : type = AppButtonType.secondary;

  const AppButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = false,
  }) : type = AppButtonType.outline;

  const AppButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = false,
  }) : type = AppButtonType.text;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final padding = _getPadding();
    final textStyle = _getTextStyle();

    Widget child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                type == AppButtonType.primary ? Colors.white : AppColors.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(text, style: textStyle),
            ],
          );

    Widget button = switch (type) {
      AppButtonType.primary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
      AppButtonType.secondary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
      AppButtonType.outline => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
      AppButtonType.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
    };

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  ButtonStyle _getButtonStyle() {
    final padding = _getPadding();
    
    return switch (type) {
      AppButtonType.primary => ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      AppButtonType.secondary => ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      AppButtonType.outline => OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: AppColors.primary),
        ),
      AppButtonType.text => TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: padding,
        ),
    };
  }

  EdgeInsets _getPadding() {
    return switch (size) {
      AppButtonSize.small => const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      AppButtonSize.medium => const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      AppButtonSize.large => const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    };
  }

  TextStyle _getTextStyle() {
    return switch (size) {
      AppButtonSize.small => AppTypography.buttonS,
      AppButtonSize.medium => AppTypography.buttonM,
      AppButtonSize.large => AppTypography.buttonL,
    };
  }
}

enum AppButtonType { primary, secondary, outline, text }
enum AppButtonSize { small, medium, large }
