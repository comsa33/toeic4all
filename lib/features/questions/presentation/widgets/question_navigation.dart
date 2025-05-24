import 'package:flutter/material.dart';

class QuestionNavigation extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;
  final List<bool> answeredQuestions;
  final ValueChanged<int> onQuestionSelected;

  const QuestionNavigation({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.answeredQuestions,
    required this.onQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: totalQuestions,
        itemBuilder: (context, index) {
          final isAnswered = index < answeredQuestions.length ? answeredQuestions[index] : false;
          final isCurrent = index == currentIndex;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _QuestionNumberButton(
              number: index + 1,
              isAnswered: isAnswered,
              isCurrent: isCurrent,
              onTap: () => onQuestionSelected(index),
            ),
          );
        },
      ),
    );
  }
}

class _QuestionNumberButton extends StatelessWidget {
  final int number;
  final bool isAnswered;
  final bool isCurrent;
  final VoidCallback onTap;

  const _QuestionNumberButton({
    required this.number,
    required this.isAnswered,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (isCurrent) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      textColor = Theme.of(context).colorScheme.onPrimary;
      borderColor = Theme.of(context).colorScheme.primary;
    } else if (isAnswered) {
      backgroundColor = Theme.of(context).colorScheme.primaryContainer;
      textColor = Theme.of(context).colorScheme.onPrimaryContainer;
      borderColor = Theme.of(context).colorScheme.primary;
    } else {
      backgroundColor = Theme.of(context).colorScheme.surface;
      textColor = Theme.of(context).colorScheme.onSurface;
      borderColor = Theme.of(context).colorScheme.outline;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
