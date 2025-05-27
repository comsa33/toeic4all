import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/themes/typography.dart';
import '../../../../shared/widgets/common_widgets.dart';

class ProfileHeader extends StatelessWidget {
  final dynamic user; // User type from auth domain

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          // Profile Image and Edit Button
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: user.profile.profileImageUrl != null
                    ? ClipOval(
                        child: Image.network(
                          user.profile.profileImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildInitialAvatar(),
                        ),
                      )
                    : _buildInitialAvatar(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => context.push('/profile/edit'),
                    icon: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // User Name
          Text(
            user.profile.name,
            style: AppTypography.headingL,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 4),
          
          // Email
          Text(
            user.email,
            style: AppTypography.bodyM.secondary,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // User Level and Target Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoChip(
                icon: Icons.school,
                label: user.profile.currentLevel ?? '초급',
                color: AppColors.primary,
              ),
              _buildInfoChip(
                icon: Icons.flag,
                label: '목표 ${user.profile.targetScore ?? "900"}점',
                color: AppColors.secondary,
              ),
            ],
          ),
          
          // Bio (if available)
          if (user.profile.bio != null && user.profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                user.profile.bio!,
                style: AppTypography.bodyM,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInitialAvatar() {
    return Center(
      child: Text(
        user.profile.name.isNotEmpty 
            ? user.profile.name.substring(0, 1).toUpperCase()
            : 'U',
        style: AppTypography.headingXL.white,
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.bodyS.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
