class ApiEndpoints {
  // Base URLs
  static const String baseUrl = 'https://toeic4all-apis.po24lio.com';
  static const String authVersion = '/api/v1/auth';
  static const String questionsVersion = '/api/v1/questions';
  
  // Auth endpoints
  static const String login = '$authVersion/login';
  static const String signUp = '$authVersion/signup';
  static const String signOut = '$authVersion/signout';
  static const String currentUser = '$authVersion/me';
  static const String resetPassword = '$authVersion/reset-password';
  static const String updateProfile = '$authVersion/profile';
  static const String loginOAuth2 = '$authVersion/login/oauth2';
  static const String register = '$authVersion/register';
  static const String logout = '$authVersion/logout';
  static const String refreshToken = '$authVersion/refresh-token';
  static const String passwordResetRequest = '$authVersion/password-reset/request';
  static const String passwordResetConfirm = '$authVersion/password-reset/confirm';
  static const String passwordChange = '$authVersion/password-change';
  static const String verifyEmail = '$authVersion/verify-email';
  static const String resendVerification = '$authVersion/resend-verification';
  static const String deleteAccount = '$authVersion/delete-account';
  static const String sessions = '$authVersion/sessions';
  static const String sessionById = '$authVersion/sessions/{session_id}';
  static const String passwordStatus = '$authVersion/password-status';
  static const String unlockAccount = '$authVersion/unlock-account';
  
  // Social login endpoints
  static const String googleLogin = '$authVersion/social/google';
  static const String kakaoLogin = '$authVersion/social/kakao';
  static const String naverLogin = '$authVersion/social/naver';
  
  // Auth system endpoints
  static const String authHealth = '$authVersion/health';
  
  // Questions endpoints - Part 5
  static const String part5Questions = '$questionsVersion/part5/';
  static const String part5Answer = '$questionsVersion/part5/{question_id}/answer';
  static const String part5Categories = '$questionsVersion/part5/categories';
  static const String part5Subtypes = '$questionsVersion/part5/subtypes';
  static const String part5Difficulties = '$questionsVersion/part5/difficulties';
  
  // Questions endpoints - Part 6
  static const String part6Sets = '$questionsVersion/part6/';
  static const String part6Answer = '$questionsVersion/part6/{set_id}/answers/{question_seq}';
  static const String part6PassageTypes = '$questionsVersion/part6/passage_types';
  static const String part6Difficulties = '$questionsVersion/part6/difficulties';
  
  // Questions endpoints - Part 7
  static const String part7Sets = '$questionsVersion/part7/';
  static const String part7Answer = '$questionsVersion/part7/{set_id}/answers/{question_seq}';
  static const String part7SetTypes = '$questionsVersion/part7/set_types';
  static const String part7PassageTypes = '$questionsVersion/part7/passage_types';
  static const String part7PassageCombinations = '$questionsVersion/part7/passage_combinations';
  static const String part7Difficulties = '$questionsVersion/part7/difficulties';
  
  // System endpoints
  static const String systemHealth = '$questionsVersion/system/health';
  static const String cacheStats = '$questionsVersion/system/cache-stats';
  static const String clearCache = '$questionsVersion/admin/system/clear-cache';
  static const String root = '$questionsVersion/';
}
