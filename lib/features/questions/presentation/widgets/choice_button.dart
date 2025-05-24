import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String label;
  final String text;
  final String translation;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback? onTap;

  const ChoiceButton({
    super.key,
    required this.label,
    required this.text,
    required this.translation,
    required this.isSelected,
    this.isCorrect,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? borderColor;
    Color? textColor;
    IconData? icon;

    if (isCorrect != null) {
      // Show result state
      if (isCorrect!) {
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        borderColor = Theme.of(context).colorScheme.primary;
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
        icon = Icons.check_circle;
      } else if (isSelected) {
        backgroundColor = Theme.of(context).colorScheme.errorContainer;
        borderColor = Theme.of(context).colorScheme.error;
        textColor = Theme.of(context).colorScheme.onErrorContainer;
        icon = Icons.cancel;
      } else {
        backgroundColor = Theme.of(context).colorScheme.surface;
        borderColor = Theme.of(context).colorScheme.outline;
        textColor = Theme.of(context).colorScheme.onSurface;
      }
    } else {
      // Normal state
      if (isSelected) {
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        borderColor = Theme.of(context).colorScheme.primary;
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
      } else {
        backgroundColor = Theme.of(context).colorScheme.surface;
        borderColor = Theme.of(context).colorScheme.outline;
        textColor = Theme.of(context).colorScheme.onSurface;
      }
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor!, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Choice label
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: borderColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: borderColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Choice content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (translation.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        translation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: textColor?.withOpacity(0.7),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Result icon
              if (icon != null) ...[
                const SizedBox(width: 12),
                Icon(
                  icon,
                  color: borderColor,
                  size: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
