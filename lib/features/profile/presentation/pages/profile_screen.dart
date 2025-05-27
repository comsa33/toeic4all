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

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _hasTriedRefresh = false;

  @override
  void initState() {
    super.initState();
    // 위젯이 빌드된 후 사용자 정보 확인
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndRefreshUserInfo();
    });
  }

  void _checkAndRefreshUserInfo() async {
    final authState = ref.read(authControllerProvider);

    // 인증되었지만 사용자 정보가 없고 아직 재로드를 시도하지 않았다면 재로드 시도
    if (authState.isAuthenticated &&
        authState.user == null &&
        !_hasTriedRefresh &&
        !authState.isLoading) {
      debugPrint('🔄 프로필 화면: 사용자 정보 없음, 재로드 시도');
      _hasTriedRefresh = true;

      // 사용자 정보 재로드 시도
      await ref.read(authControllerProvider.notifier).refreshUserInfo();

      // 재로드 후에도 사용자 정보가 없으면 플래그 리셋 (재시도 가능하게)
      final updatedAuthState = ref.read(authControllerProvider);
      if (updatedAuthState.user == null) {
        debugPrint('🔄 프로필 화면: 사용자 정보 재로드 실패, 재시도 가능하게 설정');
        _hasTriedRefresh = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    // 사용자 정보 재확인
    if (!_hasTriedRefresh) {
      _checkAndRefreshUserInfo();
    }

    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoadingWidget(message: '사용자 정보를 불러오는 중...'),
              const SizedBox(height: 24),
              if (_hasTriedRefresh) // 재로드를 시도했는데도 실패한 경우
                AppButton(
                  text: '다시 시도',
                  onPressed: () {
                    setState(() {
                      _hasTriedRefresh = false;
                    });
                    _checkAndRefreshUserInfo();
                  },
                ),
            ],
          ),
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
                title: Text('프로필', style: AppTypography.headingM.white),
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
                  Text('목표 달성도', style: AppTypography.headingS),
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
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.secondary,
              ),
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
