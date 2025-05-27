import 'package:flutter/foundation.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverSignInService {
  /// 네이버 로그인을 수행하고 액세스 토큰을 반환합니다.
  Future<String?> signIn() async {
    try {
      debugPrint('🔄 네이버 로그인 시작');
      
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      
      if (result.status == NaverLoginStatus.loggedIn) {
        debugPrint('✅ 네이버 로그인 성공');
        debugPrint('🔑 액세스 토큰 획득: ${result.accessToken.toString().substring(0, 20)}...');
        
        return result.accessToken.toString();
      } else if (result.status == NaverLoginStatus.cancelledByUser) {
        debugPrint('❌ 네이버 로그인 취소됨');
        return null;
      } else {
        debugPrint('❌ 네이버 로그인 실패: ${result.errorMessage}');
        return null;
      }
      
    } catch (error) {
      debugPrint('❌ 네이버 로그인 오류: $error');
      return null;
    }
  }

  /// 네이버 로그아웃을 수행합니다.
  Future<void> signOut() async {
    try {
      debugPrint('🔄 네이버 로그아웃 시작');
      await FlutterNaverLogin.logOut();
      debugPrint('✅ 네이버 로그아웃 완료');
    } catch (error) {
      debugPrint('❌ 네이버 로그아웃 오류: $error');
    }
  }

  /// 현재 로그인 상태를 확인합니다.
  Future<bool> isLoggedIn() async {
    try {
      final bool isLoggedIn = await FlutterNaverLogin.isLoggedIn;
      return isLoggedIn;
    } catch (error) {
      debugPrint('❌ 네이버 로그인 상태 확인 오류: $error');
      return false;
    }
  }

  /// 현재 액세스 토큰을 가져옵니다.
  Future<String?> getAccessToken() async {
    try {
      final NaverAccessToken? token = await FlutterNaverLogin.currentAccessToken;
      return token?.accessToken;
    } catch (error) {
      debugPrint('❌ 네이버 액세스 토큰 조회 오류: $error');
      return null;
    }
  }

  /// 현재 사용자 정보를 가져옵니다.
  Future<NaverAccountResult?> getCurrentUser() async {
    try {
      if (await isLoggedIn()) {
        return await FlutterNaverLogin.currentAccount();
      }
      return null;
    } catch (error) {
      debugPrint('❌ 네이버 사용자 정보 조회 오류: $error');
      return null;
    }
  }
}