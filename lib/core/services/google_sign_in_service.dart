import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  // 플랫폼별 클라이언트 ID
  static const String _iosClientId = '492018860076-vgsfs0r9qmaihc9qp3gig8nkl9vq6ma2.apps.googleusercontent.com';
  static const String _androidClientId = '492018860076-lk51fg1p4eaedu7v02k1rjp6pdpd8map.apps.googleusercontent.com';
  
  late final GoogleSignIn _googleSignIn;

  GoogleSignInService() {
    // 플랫폼에 따라 적절한 클라이언트 ID 선택
    String clientId;
    if (Platform.isIOS) {
      clientId = _iosClientId;
      debugPrint('🍎 iOS용 Google 클라이언트 ID 사용');
    } else if (Platform.isAndroid) {
      clientId = _androidClientId;
      debugPrint('🤖 Android용 Google 클라이언트 ID 사용');
    } else {
      // 웹이나 다른 플랫폼의 경우 기본값 (보통 웹용)
      clientId = _iosClientId; // 기본값으로 iOS 사용
      debugPrint('🌐 기본 클라이언트 ID 사용 (플랫폼: ${Platform.operatingSystem})');
    }
    
    _googleSignIn = GoogleSignIn(
      clientId: clientId,
      scopes: [
        'email',
        'profile',
        'openid',
      ],
    );
  }

  /// Google Sign-In을 수행하고 ID 토큰을 반환합니다.
  Future<String?> signIn() async {
    try {
      debugPrint('🔄 Google Sign-In 시작');
      
      // 기존 로그인 상태 확인
      final GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
      
      GoogleSignInAccount? account;
      
      if (currentUser != null) {
        debugPrint('✅ 기존 Google 계정 발견: ${currentUser.email}');
        account = currentUser;
      } else {
        debugPrint('🔄 새로운 Google 로그인 시도');
        account = await _googleSignIn.signIn();
      }
      
      if (account == null) {
        debugPrint('❌ Google 로그인 취소됨');
        return null;
      }
      
      debugPrint('✅ Google 계정 선택됨: ${account.email}');
      
      // 인증 토큰 가져오기
      final GoogleSignInAuthentication auth = await account.authentication;
      
      final String? idToken = auth.idToken;
      final String? accessToken = auth.accessToken;
      
      debugPrint('🔑 ID Token 획득: ${idToken?.substring(0, 20)}...');
      debugPrint('🔑 Access Token 획득: ${accessToken?.substring(0, 20)}...');
      
      if (idToken == null) {
        debugPrint('❌ ID Token을 가져올 수 없습니다');
        return null;
      }
      
      return idToken;
      
    } catch (error) {
      debugPrint('❌ Google Sign-In 오류: $error');
      return null;
    }
  }

  /// Google Sign-Out을 수행합니다.
  Future<void> signOut() async {
    try {
      debugPrint('🔄 Google Sign-Out 시작');
      await _googleSignIn.signOut();
      debugPrint('✅ Google Sign-Out 완료');
    } catch (error) {
      debugPrint('❌ Google Sign-Out 오류: $error');
    }
  }

  /// 현재 로그인된 Google 계정을 연결 해제합니다.
  Future<void> disconnect() async {
    try {
      debugPrint('🔄 Google 계정 연결 해제 시작');
      await _googleSignIn.disconnect();
      debugPrint('✅ Google 계정 연결 해제 완료');
    } catch (error) {
      debugPrint('❌ Google 계정 연결 해제 오류: $error');
    }
  }

  /// 현재 로그인된 Google 계정 정보를 반환합니다.
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  /// Google Sign-In이 가능한지 확인합니다.
  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}
