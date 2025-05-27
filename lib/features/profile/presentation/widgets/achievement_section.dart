import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/themes/typography.dart';
import '../../../../shared/widgets/common_widgets.dart';

class AchievementSection extends StatelessWidget {
  final dynamic stats; // UserStats type from auth domain

  const AchievementSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final achievements = _getAchievements();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: AppColors.success,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '성취 뱃지',
              style: AppTypography.headingM,
            ),
            const Spacer(),
            Text(
              '${achievements.where((a) => a.isUnlocked).length}/${achievements.length}',
              style: AppTypography.bodyM.secondary,
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Achievement Grid
        AppCard(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: achievements.map((achievement) => 
              _buildAchievementBadge(achievement)
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(Achievement achievement) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: achievement.isUnlocked 
            ? achievement.color.withOpacity(0.1)
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: achievement.isUnlocked 
              ? achievement.color.withOpacity(0.3)
              : AppColors.textTertiary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: achievement.isUnlocked 
                  ? achievement.color
                  : AppColors.textTertiary.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              achievement.icon,
              color: achievement.isUnlocked 
                  ? Colors.white
                  : AppColors.textTertiary,
              size: 20,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            achievement.title,
            style: AppTypography.caption.copyWith(
              color: achievement.isUnlocked 
                  ? AppColors.textPrimary
                  : AppColors.textTertiary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  List<Achievement> _getAchievements() {
    return [
      Achievement(
        title: '첫 도전',
        icon: Icons.play_arrow,
        color: AppColors.primary,
        isUnlocked: stats.totalTestsTaken > 0,
        description: '첫 번째 테스트 완료',
      ),
      Achievement(
        title: '꾸준함',
        icon: Icons.local_fire_department,
        color: const Color(0xFFEF4444),
        isUnlocked: stats.studyStreak >= 7,
        description: '7일 연속 학습',
      ),
      Achievement(
        title: '실력자',
        icon: Icons.star,
        color: AppColors.success,
        isUnlocked: stats.bestScore >= 700,
        description: '700점 이상 달성',
      ),
      Achievement(
        title: '고수',
        icon: Icons.workspace_premium,
        color: AppColors.secondary,
        isUnlocked: stats.bestScore >= 850,
        description: '850점 이상 달성',
      ),
      Achievement(
        title: '마라토너',
        icon: Icons.directions_run,
        color: const Color(0xFF8B5CF6),
        isUnlocked: stats.totalTestsTaken >= 50,
        description: '50회 테스트 완료',
      ),
      Achievement(
        title: '완벽주의',
        icon: Icons.diamond,
        color: const Color(0xFF06B6D4),
        isUnlocked: stats.bestScore >= 990,
        description: '990점 달성',
      ),
    ];
  }
}

class Achievement {
  final String title;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final String description;

  Achievement({
    required this.title,
    required this.icon,
    required this.color,
    required this.isUnlocked,
    required this.description,
  });
}
