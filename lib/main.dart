import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
// import 'package:flutter_naver_login/flutter_naver_login.dart'; // 임시 비활성화
import 'core/constants/app_strings.dart';
import 'shared/themes/app_theme.dart';
import 'core/routing/app_router.dart';
import 'features/auth/presentation/providers/auth_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Kakao SDK
  KakaoSdk.init(nativeAppKey: '39460d79912e5b0a6518a8c86237771d');

  // Initialize Naver SDK - 임시 비활성화
  // await FlutterNaverLogin.initSdk(
  //   clientId: 'dPEWiT72BQLlRtc_u4qN',
  //   clientSecret: 'C0di8yXCtB',
  //   clientName: 'TOEIC4ALL',
  // );

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const ToeicApp(),
    ),
  );
}

class ToeicApp extends ConsumerWidget {
  const ToeicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
