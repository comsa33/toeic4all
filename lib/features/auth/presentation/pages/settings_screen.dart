import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/auth_providers.dart';

// 설정 상태 관리
final settingsProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      return SettingsController(prefs);
    });

class SettingsState {
  final bool autoLogin;
  final bool biometricLogin;
  final bool pushNotifications;
  final bool studyReminders;
  final String theme;
  final String language;

  const SettingsState({
    this.autoLogin = true,
    this.biometricLogin = false,
    this.pushNotifications = true,
    this.studyReminders = true,
    this.theme = 'light',
    this.language = 'ko',
  });

  SettingsState copyWith({
    bool? autoLogin,
    bool? biometricLogin,
    bool? pushNotifications,
    bool? studyReminders,
    String? theme,
    String? language,
  }) {
    return SettingsState(
      autoLogin: autoLogin ?? this.autoLogin,
      biometricLogin: biometricLogin ?? this.biometricLogin,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      studyReminders: studyReminders ?? this.studyReminders,
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  final SharedPreferences _prefs;

  SettingsController(this._prefs) : super(const SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    state = SettingsState(
      autoLogin:
          _prefs.getBool('auto_login_enabled') ??
          true, // AuthController와 동일한 키 사용
      biometricLogin: _prefs.getBool('biometric_login') ?? false,
      pushNotifications: _prefs.getBool('push_notifications') ?? true,
      studyReminders: _prefs.getBool('study_reminders') ?? true,
      theme: _prefs.getString('theme') ?? 'light',
      language: _prefs.getString('language') ?? 'ko',
    );
  }

  Future<void> setAutoLogin(bool value) async {
    await _prefs.setBool(
      'auto_login_enabled',
      value,
    ); // AuthController와 동일한 키 사용
    state = state.copyWith(autoLogin: value);
  }

  Future<void> setBiometricLogin(bool value) async {
    await _prefs.setBool('biometric_login', value);
    state = state.copyWith(biometricLogin: value);
  }

  Future<void> setPushNotifications(bool value) async {
    await _prefs.setBool('push_notifications', value);
    state = state.copyWith(pushNotifications: value);
  }

  Future<void> setStudyReminders(bool value) async {
    await _prefs.setBool('study_reminders', value);
    state = state.copyWith(studyReminders: value);
  }

  Future<void> setTheme(String value) async {
    await _prefs.setString('theme', value);
    state = state.copyWith(theme: value);
  }

  Future<void> setLanguage(String value) async {
    await _prefs.setString('language', value);
    state = state.copyWith(language: value);
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('설정'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 계정 정보 섹션
          if (authState.user != null) ...[
            _buildSectionHeader(context, '계정 정보'),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
                    authState.user!.profile.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(authState.user!.profile.name),
                subtitle: Text(authState.user!.email),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => context.push('/profile'),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // 보안 설정 섹션
          _buildSectionHeader(context, '보안 설정'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('자동 로그인'),
                  subtitle: const Text('앱 재시작 시 자동으로 로그인합니다'),
                  value: settings.autoLogin,
                  onChanged: (value) async {
                    // 설정 화면과 AuthController 모두 업데이트
                    await ref
                        .read(settingsProvider.notifier)
                        .setAutoLogin(value);
                    await ref
                        .read(authControllerProvider.notifier)
                        .setAutoLoginEnabled(value);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('생체 인증'),
                  subtitle: const Text('지문 또는 얼굴 인식으로 로그인'),
                  value: settings.biometricLogin,
                  onChanged: (value) {
                    if (value) {
                      _showBiometricSetupDialog(context, ref);
                    } else {
                      ref
                          .read(settingsProvider.notifier)
                          .setBiometricLogin(false);
                    }
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('비밀번호 변경'),
                  subtitle: Text(
                    authState.user?.isSocialLogin == true
                        ? '소셜 로그인 계정은 비밀번호 변경이 불가능합니다'
                        : '계정 비밀번호를 변경합니다',
                  ),
                  trailing: authState.user?.isSocialLogin == true
                      ? const Icon(Icons.info_outline, color: Colors.grey)
                      : const Icon(Icons.arrow_forward_ios, size: 16),
                  enabled: authState.user?.isSocialLogin != true,
                  onTap: authState.user?.isSocialLogin == true
                      ? () => _showSocialLoginPasswordDialog(context)
                      : () => _showChangePasswordDialog(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 알림 설정 섹션
          _buildSectionHeader(context, '알림 설정'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('푸시 알림'),
                  subtitle: const Text('앱 알림을 받습니다'),
                  value: settings.pushNotifications,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setPushNotifications(value);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('학습 리마인더'),
                  subtitle: const Text('규칙적인 학습을 위한 알림'),
                  value: settings.studyReminders,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setStudyReminders(value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 앱 설정 섹션
          _buildSectionHeader(context, '앱 설정'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('테마 설정'),
                  subtitle: Text(
                    settings.theme == 'light' ? '라이트 모드' : '다크 모드',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showThemeDialog(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('언어 설정'),
                  subtitle: Text(settings.language == 'ko' ? '한국어' : 'English'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showLanguageDialog(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 기타 섹션
          _buildSectionHeader(context, '기타'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('버전 정보'),
                  subtitle: const Text('v1.0.0'),
                  trailing: const Icon(Icons.info_outline),
                  onTap: () => _showVersionDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('문의하기'),
                  subtitle: const Text('고객센터 및 피드백'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showContactDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('이용약관'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showTermsDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('개인정보처리방침'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showPrivacyDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // 로그아웃 버튼
          AppButton.outline(
            text: '로그아웃',
            onPressed: () => _showLogoutDialog(context, ref),
          ),
          const SizedBox(height: 16),

          // 계정 삭제 버튼
          AppButton.text(
            text: '계정 삭제',
            onPressed: () => _showDeleteAccountDialog(context, ref),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  void _showBiometricSetupDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('생체 인증 설정'),
        content: const Text('생체 인증 기능은 아직 구현 중입니다.\n추후 업데이트에서 제공될 예정입니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showSocialLoginPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('비밀번호 변경 불가'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 32,
            ),
            SizedBox(height: 16),
            Text(
              '소셜 로그인으로 가입하신 계정은 비밀번호 변경이 불가능합니다.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '로그인 시 사용하신 소셜 계정(Google, Kakao, Naver)에서 비밀번호를 변경해주세요.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context, WidgetRef ref) {
    // 비밀번호 변경 화면으로 이동
    context.push('/change-password');
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('테마 설정'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('라이트 모드'),
              value: 'light',
              groupValue: settings.theme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).setTheme(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('다크 모드'),
              value: 'dark',
              groupValue: settings.theme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).setTheme(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('언어 설정'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('한국어'),
              value: 'ko',
              groupValue: settings.language,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).setLanguage(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: settings.language,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).setLanguage(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showVersionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('버전 정보'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TOEIC4ALL'),
            Text('버전: v1.0.0'),
            Text('빌드: 20241225'),
            SizedBox(height: 16),
            Text('최고의 토익 학습 경험을 제공합니다.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('문의하기'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이메일: support@toeic4all.com'),
            Text('전화: 02-1234-5678'),
            SizedBox(height: 16),
            Text('운영시간: 평일 09:00 - 18:00'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('이용약관'),
        content: const Text('이용약관 내용이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('개인정보처리방침'),
        content: const Text('개인정보처리방침 내용이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말로 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          AppButton.primary(
            text: '로그아웃',
            onPressed: () {
              Navigator.pop(context);
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('계정 삭제'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⚠️ 경고',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('계정을 삭제하면 모든 데이터가 영구적으로 삭제됩니다.'),
            const Text('이 작업은 되돌릴 수 없습니다.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          AppButton.primary(
            text: '삭제',
            onPressed: () {
              Navigator.pop(context);
              // 계정 삭제 로직 구현 필요
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('계정 삭제 기능은 추후 업데이트에서 제공될 예정입니다.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
