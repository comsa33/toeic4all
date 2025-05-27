import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/themes/typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/common_widgets.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late final TextEditingController _targetScoreController;
  
  String? _selectedLevel;
  bool _isLoading = false;
  
  final List<String> _levels = [
    '초급',
    '중급',
    '고급',
    '전문가',
  ];

  @override
  void initState() {
    super.initState();
    final user = ref.read(authControllerProvider).user;
    
    _nameController = TextEditingController(text: user?.profile.name ?? '');
    _bioController = TextEditingController(text: user?.profile.bio ?? '');
    _targetScoreController = TextEditingController(
      text: user?.profile.targetScore ?? '900',
    );
    _selectedLevel = user?.profile.currentLevel ?? '초급';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _targetScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: const Text('프로필 편집'),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: Text(
              '저장',
              style: TextStyle(
                color: _isLoading ? AppColors.textSecondary : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Picture Section
            _ProfilePictureSection(user: user),
            
            const SizedBox(height: 32),
            
            // Basic Information
            _SectionHeader(
              icon: Icons.person,
              title: '기본 정보',
            ),
            const SizedBox(height: 16),
            
            AppCard(
              child: Column(
                children: [
                  _InputField(
                    label: '이름',
                    controller: _nameController,
                    hintText: '이름을 입력하세요',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  _DropdownField(
                    label: '현재 수준',
                    value: _selectedLevel,
                    items: _levels,
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value;
                      });
                    },
                    prefixIcon: Icons.school,
                  ),
                  const SizedBox(height: 20),
                  _InputField(
                    label: '목표 점수',
                    controller: _targetScoreController,
                    hintText: '목표 점수를 입력하세요',
                    prefixIcon: Icons.flag,
                    keyboardType: TextInputType.number,
                    suffix: const Text('점'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Bio Section
            _SectionHeader(
              icon: Icons.edit_note,
              title: '자기소개',
            ),
            const SizedBox(height: 16),
            
            AppCard(
              child: _InputField(
                label: '자기소개',
                controller: _bioController,
                hintText: '간단한 자기소개를 작성해보세요 (선택사항)',
                prefixIcon: Icons.notes,
                maxLines: 4,
                isOptional: true,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Study Preferences Section
            _SectionHeader(
              icon: Icons.settings_outlined,
              title: '학습 설정',
            ),
            const SizedBox(height: 16),
            
            AppCard(
              child: Column(
                children: [
                  _PreferenceItem(
                    icon: Icons.notifications_outlined,
                    title: '학습 알림',
                    subtitle: '매일 정해진 시간에 학습 알림을 받습니다',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // TODO: Implement notification preference
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  _PreferenceItem(
                    icon: Icons.translate,
                    title: '번역 자동 표시',
                    subtitle: '문제 풀이 시 번역을 자동으로 표시합니다',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {
                        // TODO: Implement translation preference
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Save Button
            AppButton.primary(
              text: '변경사항 저장',
              onPressed: _isLoading ? null : _saveProfile,
              isLoading: _isLoading,
              icon: const Icon(Icons.save),
            ),
            
            const SizedBox(height: 16),
            
            // Cancel Button
            AppButton.outline(
              text: '취소',
              onPressed: () => context.pop(),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.trim().isEmpty) {
      _showErrorSnackBar('이름을 입력해주세요.');
      return;
    }

    final targetScore = int.tryParse(_targetScoreController.text);
    if (targetScore == null || targetScore < 0 || targetScore > 990) {
      _showErrorSnackBar('유효한 목표 점수를 입력해주세요. (0-990점)');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement profile update logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('프로필이 성공적으로 업데이트되었습니다.'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('프로필 업데이트에 실패했습니다: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }
}

class _ProfilePictureSection extends StatelessWidget {
  final dynamic user;

  const _ProfilePictureSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
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
              width: 36,
              height: 36,
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
                onPressed: () => _showImagePickerDialog(context),
                icon: const Icon(
                  Icons.camera_alt,
                  size: 18,
                  color: Colors.white,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialAvatar() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: Text(
          user.profile.name.isNotEmpty
              ? user.profile.name.substring(0, 1).toUpperCase()
              : 'U',
          style: AppTypography.headingXL.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('프로필 사진 변경'),
        content: const Text(
          '프로필 사진 변경 기능은 추후 업데이트에서 제공될 예정입니다.',
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTypography.headingS.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final int maxLines;
  final bool isOptional;

  const _InputField({
    required this.label,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.suffix,
    this.maxLines = 1,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTypography.bodyM.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isOptional) ...[
              const SizedBox(width: 4),
              Text(
                '(선택)',
                style: AppTypography.bodyS.secondary,
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
            suffix: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final IconData prefixIcon;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodyM.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}

class _PreferenceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  const _PreferenceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: AppTypography.bodyM.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodyS.secondary,
      ),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
