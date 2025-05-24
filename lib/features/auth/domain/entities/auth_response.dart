
import 'user.dart';

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User user;
  final int expiresIn;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.expiresIn,
  });

  AuthResponse copyWith({
    String? accessToken,
    String? refreshToken,
    User? user,
    int? expiresIn,
  }) {
    return AuthResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}


