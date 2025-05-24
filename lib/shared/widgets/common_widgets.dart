import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../themes/typography.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;
  final double size;

  const LoadingWidget({
    super.key,
    this.message,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: color ?? AppColors.primary,
            strokeWidth: 2,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: AppTypography.bodyM.secondary,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorWidget({
    super.key,
    required this.message,
    this.buttonText,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon ?? Icons.error_outline,
          size: 64,
          color: AppColors.error,
        ).animate().scale(duration: 300.ms),
        const SizedBox(height: 16),
        Text(
          message,
          style: AppTypography.bodyM.secondary,
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 150.ms),
        if (onRetry != null) ...[
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(buttonText ?? '다시 시도'),
          ).animate().slideY(begin: 0.5, delay: 300.ms),
        ],
      ],
    );
  }
}

class EmptyWidget extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onAction;
  final IconData? icon;

  const EmptyWidget({
    super.key,
    required this.message,
    this.buttonText,
    this.onAction,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon ?? Icons.inbox_outlined,
          size: 64,
          color: AppColors.textTertiary,
        ).animate().scale(duration: 300.ms),
        const SizedBox(height: 16),
        Text(
          message,
          style: AppTypography.bodyM.secondary,
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 150.ms),
        if (onAction != null) ...[
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onAction,
            child: Text(buttonText ?? '시작하기'),
          ).animate().slideY(begin: 0.5, delay: 300.ms),
        ],
      ],
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Card(
        elevation: elevation ?? 2,
        color: backgroundColor ?? AppColors.surface,
        shadowColor: AppColors.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class AppChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final Widget? avatar;
  final bool selected;

  const AppChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.avatar,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        label,
        style: AppTypography.bodyS.copyWith(
          color: textColor ?? (selected ? Colors.white : AppColors.textPrimary),
        ),
      ),
      onPressed: onTap,
      backgroundColor: backgroundColor ?? 
          (selected ? AppColors.primary : AppColors.surfaceVariant),
      avatar: avatar,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showDragHandle;
  final double? height;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.showDragHandle = true,
    this.height,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showDragHandle = true,
    double? height,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      isScrollControlled: true,
      builder: (context) => AppBottomSheet(
        title: title,
        showDragHandle: showDragHandle,
        height: height,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDragHandle)
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title!,
                style: AppTypography.headingS,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
          ],
          Flexible(child: child),
        ],
      ),
    ).animate().slideY(begin: 1, duration: 300.ms);
  }
}
