import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/themes/typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/common_widgets.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../widgets/profile_header.dart';
import '../widgets/stats_grid.dart';
import '../widgets/achievement_section.dart';
import '../widgets/quick_actions_section.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: LoadingWidget(message: '사용자 정보를 불러오는 중...'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Gradient
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '프로필',
                  style: AppTypography.headingM.white,
                ),
                titlePadding: const EdgeInsets.only(bottom: 16),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => context.push('/settings'),
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                tooltip: '설정',
              ),
            ],
          ),

          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile Header Card
                  ProfileHeader(user: user),
                  
                  const SizedBox(height: 24),
                  
                  // Statistics Grid
                  StatsGrid(stats: user.stats),
                  
                  const SizedBox(height: 24),
                  
                  // Achievement Section
                  AchievementSection(stats: user.stats),
                  
                  const SizedBox(height: 24),
                  
                  // Quick Actions
                  QuickActionsSection(user: user),
                  
                  const SizedBox(height: 24),
                  
                  // Study Progress Card
                  _StudyProgressCard(user: user),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudyProgressCard extends StatelessWidget {
  final dynamic user; // User type from auth domain

  const _StudyProgressCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final targetScore = int.tryParse(user.profile.targetScore ?? '900') ?? 900;
    final currentScore = user.stats.averageScore;
    final progress = currentScore / targetScore;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '목표 달성도',
                    style: AppTypography.headingS,
                  ),
                  Text(
                    '목표: ${targetScore}점',
                    style: AppTypography.bodyS.secondary,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTypography.headingM.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: AppColors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
              minHeight: 8,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '현재: ${currentScore}점',
                style: AppTypography.bodyS.secondary,
              ),
              Text(
                '${targetScore - currentScore}점 남음',
                style: AppTypography.bodyS.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
