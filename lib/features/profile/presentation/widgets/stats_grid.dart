import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/themes/typography.dart';
import '../../../../shared/widgets/common_widgets.dart';

class StatsGrid extends StatelessWidget {
  final dynamic stats; // UserStats type from auth domain

  const StatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.analytics,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '학습 통계',
              style: AppTypography.headingM,
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Stats Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _buildStatCard(
              title: '총 테스트',
              value: '${stats.totalTestsTaken}',
              unit: '회',
              icon: Icons.quiz,
              color: AppColors.primary,
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            _buildStatCard(
              title: '평균 점수',
              value: '${stats.averageScore}',
              unit: '점',
              icon: Icons.grade,
              color: AppColors.secondary,
              gradient: LinearGradient(
                colors: [AppColors.secondary, AppColors.secondaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            _buildStatCard(
              title: '최고 점수',
              value: '${stats.bestScore}',
              unit: '점',
              icon: Icons.star,
              color: AppColors.success,
              gradient: LinearGradient(
                colors: [AppColors.success, const Color(0xFF34D399)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            _buildStatCard(
              title: '연속 학습',
              value: '${stats.studyStreak}',
              unit: '일',
              icon: Icons.local_fire_department,
              color: const Color(0xFFEF4444),
              gradient: const LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFF87171)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ],
        ),
        
        // Additional Stats
        const SizedBox(height: 16),
        
        AppCard(
          backgroundColor: AppColors.surfaceVariant.withOpacity(0.5),
          child: Row(
            children: [
              Expanded(
                child: _buildInlineStatItem(
                  icon: Icons.access_time,
                  label: '총 학습 시간',
                  value: _formatStudyTime(stats.totalStudyTime),
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.textTertiary.withOpacity(0.3),
              ),
              Expanded(
                child: _buildInlineStatItem(
                  icon: Icons.calendar_today,
                  label: '마지막 학습',
                  value: _formatLastStudyDate(stats.lastStudyDate),
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required Gradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: Colors.white.withOpacity(0.9),
                  size: 24,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    unit,
                    style: AppTypography.caption.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTypography.headingL.white.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: AppTypography.bodyS.white.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInlineStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.bodyM.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: AppTypography.bodyS.secondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatStudyTime(int totalMinutes) {
    if (totalMinutes == 0) return '0분';
    
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    
    if (hours == 0) {
      return '${minutes}분';
    } else if (minutes == 0) {
      return '${hours}시간';
    } else {
      return '${hours}시간 ${minutes}분';
    }
  }

  String _formatLastStudyDate(DateTime? lastStudyDate) {
    if (lastStudyDate == null) return '기록 없음';
    
    final now = DateTime.now();
    final difference = now.difference(lastStudyDate).inDays;
    
    if (difference == 0) {
      return '오늘';
    } else if (difference == 1) {
      return '어제';
    } else if (difference < 7) {
      return '${difference}일 전';
    } else {
      return '${lastStudyDate.month}/${lastStudyDate.day}';
    }
  }
}
