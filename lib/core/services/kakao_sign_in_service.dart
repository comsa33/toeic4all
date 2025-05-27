import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoSignInService {
  /// 카카오 로그인을 수행하고 액세스 토큰을 반환합니다.
  Future<String?> signIn() async {
    try {
      debugPrint('🔄 카카오 로그인 시작');
      
      OAuthToken token;
      
      // 카카오톡 앱이 설치되어 있으면 앱으로 로그인, 없으면 웹으로 로그인
      if (await isKakaoTalkInstalled()) {
        debugPrint('📱 카카오톡 앱으로 로그인 시도');
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        debugPrint('🌐 카카오 웹으로 로그인 시도');
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      debugPrint('✅ 카카오 로그인 성공');
      debugPrint('🔑 액세스 토큰 획득: ${token.accessToken.substring(0, 20)}...');
      
      return token.accessToken;
      
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELED') {
        debugPrint('❌ 카카오 로그인 취소됨');
        return null;
      }
      
      debugPrint('❌ 카카오 로그인 오류: $error');
      return null;
    }
  }

  /// 카카오 로그아웃을 수행합니다.
  Future<void> signOut() async {
    try {
      debugPrint('🔄 카카오 로그아웃 시작');
      await UserApi.instance.logout();
      debugPrint('✅ 카카오 로그아웃 완료');
    } catch (error) {
      debugPrint('❌ 카카오 로그아웃 오류: $error');
    }
  }

  /// 카카오 계정 연결을 해제합니다.
  Future<void> unlink() async {
    try {
      debugPrint('🔄 카카오 계정 연결 해제 시작');
      await UserApi.instance.unlink();
      debugPrint('✅ 카카오 계정 연결 해제 완료');
    } catch (error) {
      debugPrint('❌ 카카오 계정 연결 해제 오류: $error');
    }
  }

  /// 현재 로그인 상태를 확인합니다.
  Future<bool> isLoggedIn() async {
    try {
      final tokenInfo = await TokenManagerProvider.instance.manager.getToken();
      return tokenInfo != null;
    } catch (e) {
      return false;
    }
  }

  /// 현재 사용자 정보를 가져옵니다.
  Future<User?> getCurrentUser() async {
    try {
      if (await isLoggedIn()) {
        return await UserApi.instance.me();
      }
      return null;
    } catch (error) {
      debugPrint('❌ 카카오 사용자 정보 조회 오류: $error');
      return null;
    }
  }
}