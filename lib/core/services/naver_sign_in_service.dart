import 'package:flutter/foundation.dart';
// TODO: 네이버 로그인 플러그인 API 호환성 문제로 임시 비활성화
// import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverSignInService {
  /// 네이버 로그인을 수행하고 액세스 토큰을 반환합니다.
  /// TODO: 네이버 로그인 플러그인 API 호환성 문제로 임시 비활성화
  Future<String?> signIn() async {
    debugPrint('⚠️ 네이버 로그인 임시 비활성화됨 - 플러그인 API 호환성 문제');
    return null;

    /*
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
    */
  }

  /// 네이버 로그아웃을 수행합니다.
  Future<void> signOut() async {
    debugPrint('⚠️ 네이버 로그아웃 임시 비활성화됨');

    /*
    try {
      debugPrint('🔄 네이버 로그아웃 시작');
      await FlutterNaverLogin.logOut();
      debugPrint('✅ 네이버 로그아웃 완료');
    } catch (error) {
      debugPrint('❌ 네이버 로그아웃 오류: $error');
    }
    */
  }

  /// 현재 로그인 상태를 확인합니다.
  Future<bool> isLoggedIn() async {
    return false; // 임시 비활성화

    /*
    try {
      final bool isLoggedIn = await FlutterNaverLogin.isLoggedIn;
      return isLoggedIn;
    } catch (error) {
      debugPrint('❌ 네이버 로그인 상태 확인 오류: $error');
      return false;
    }
    */
  }

  /// 현재 액세스 토큰을 가져옵니다.
  Future<String?> getAccessToken() async {
    return null; // 임시 비활성화

    /*
    try {
      final NaverAccessToken? token = await FlutterNaverLogin.currentAccessToken;
      return token?.accessToken;
    } catch (error) {
      debugPrint('❌ 네이버 액세스 토큰 조회 오류: $error');
      return null;
    }
    */
  }

  /// 현재 사용자 정보를 가져옵니다.
  Future<Map<String, dynamic>?> getCurrentUser() async {
    return null; // 임시 비활성화

    /*
    try {
      if (await isLoggedIn()) {
        final result = await FlutterNaverLogin.currentAccount();
        // 결과를 Map으로 변환하여 반환
        if (result != null) {
          return {
            'id': result.id,
            'nickname': result.nickname,
            'name': result.name,
            'email': result.email,
            'profileImage': result.profileImage,
            'age': result.age,
            'gender': result.gender,
            'birthday': result.birthday,
            'birthyear': result.birthyear,
            'mobile': result.mobile,
          };
        }
      }
      return null;
    } catch (error) {
      debugPrint('❌ 네이버 사용자 정보 조회 오류: $error');
      return null;
    }
    */
  }
}
