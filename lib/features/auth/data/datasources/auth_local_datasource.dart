import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../models/auth_response_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuthResponse(AuthResponseModel authResponse);
  Future<AuthResponseModel?> getCachedAuthResponse();
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  Future<void> clearTokens();

  // 자동 로그인 설정 관련 메서드 추가
  Future<void> setAutoLoginEnabled(bool enabled);
  Future<bool> isAutoLoginEnabled();

  Future<void> clearAuthData() async {
    // Clear all authentication-related data
    await clearCache();
    await clearTokens();
  }
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;

  @override
  Future<void> clearAuthData() async {
    await clearCache();
    await clearTokens();
  }

  static const String _keyAuthResponse = 'auth_response';
  static const String _keyUser = 'user';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyAutoLoginEnabled = 'auto_login_enabled';

  AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<void> cacheAuthResponse(AuthResponseModel authResponse) async {
    final jsonString = json.encode(authResponse.toJson());
    await _prefs.setString(_keyAuthResponse, jsonString);

    // Also save tokens separately for easier access
    await saveTokens(
      accessToken: authResponse.accessToken,
      refreshToken: authResponse.refreshToken,
    );

    // Note: AuthResponseModel no longer contains user object directly
    // User info should be cached separately when getCurrentUser is called
  }

  @override
  Future<AuthResponseModel?> getCachedAuthResponse() async {
    final jsonString = _prefs.getString(_keyAuthResponse);
    if (jsonString == null) return null;

    try {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return AuthResponseModel.fromJson(jsonMap);
    } catch (e) {
      // If parsing fails, clear the corrupted data
      await clearCache();
      return null;
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = json.encode(user.toJson());
    await _prefs.setString(_keyUser, jsonString);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = _prefs.getString(_keyUser);
    if (jsonString == null) return null;

    try {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(jsonMap);
    } catch (e) {
      // If parsing fails, clear the corrupted data
      await _prefs.remove(_keyUser);
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    await Future.wait([
      _prefs.remove(_keyAuthResponse),
      _prefs.remove(_keyUser),
      clearTokens(),
    ]);
  }

  @override
  Future<String?> getAccessToken() async {
    return _prefs.getString(_keyAccessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _prefs.getString(_keyRefreshToken);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _prefs.setString(_keyAccessToken, accessToken),
      _prefs.setString(_keyRefreshToken, refreshToken),
    ]);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _prefs.remove(_keyAccessToken),
      _prefs.remove(_keyRefreshToken),
    ]);
  }

  @override
  Future<void> setAutoLoginEnabled(bool enabled) async {
    await _prefs.setBool(_keyAutoLoginEnabled, enabled);
  }

  @override
  Future<bool> isAutoLoginEnabled() async {
    // 기본값은 true (사용자 편의성을 위해)
    return _prefs.getBool(_keyAutoLoginEnabled) ?? true;
  }
}
