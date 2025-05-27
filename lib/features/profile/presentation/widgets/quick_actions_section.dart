import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/themes/typography.dart';
import '../../../../shared/widgets/common_widgets.dart';

class QuickActionsSection extends StatelessWidget {
  final dynamic user; // User type from auth domain

  const QuickActionsSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.flash_on,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '빠른 액션',
                    style: AppTypography.headingS,
                  ),
                  Text(
                    '바로 시작할 수 있는 학습 메뉴',
                    style: AppTypography.bodyS.secondary,
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Quick Action Grid (2x2)
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.quiz,
                  title: 'Part 5',
                  subtitle: '문법·어휘',
                  color: const Color(0xFF3B82F6),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => context.push('/questions/part5/filter'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.article,
                  title: 'Part 6',
                  subtitle: '장문 빈칸',
                  color: const Color(0xFFF59E0B),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => context.push('/questions/part6/filter'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.menu_book,
                  title: 'Part 7',
                  subtitle: '독해',
                  color: const Color(0xFF8B5CF6),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => context.push('/questions/part7/filter'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.assessment,
                  title: '통계',
                  subtitle: '학습 분석',
                  color: const Color(0xFF06B6D4),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF06B6D4), Color(0xFF22D3EE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => context.push('/statistics'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Additional Actions Row
          Row(
            children: [
              Expanded(
                child: _OutlineActionButton(
                  icon: Icons.shuffle,
                  title: '랜덤 문제',
                  onTap: () => _showRandomPracticeDialog(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OutlineActionButton(
                  icon: Icons.settings,
                  title: '설정',
                  onTap: () => context.push('/settings'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRandomPracticeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.shuffle, color: AppColors.primary),
            SizedBox(width: 8),
            Text('랜덤 문제 풀이'),
          ],
        ),
        content: const Text(
          '모든 파트에서 무작위로 선별된 문제들로 실력을 테스트해보세요.\n'
          '이 기능은 곧 추가될 예정입니다!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Gradient gradient;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodyM.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.bodyS.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
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

class _OutlineActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _OutlineActionButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.outline.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTypography.bodyM.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
