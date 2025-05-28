import 'package:flutter/material.dart';
import '../../../../core/errors/failures.dart';

/// 인증 관련 에러 메시지를 사용자 친화적으로 변환하는 유틸리티 클래스
class AuthMessageHandler {
  /// API 응답 메시지를 기반으로 사용자 친화적인 메시지 반환
  static String getErrorMessage(dynamic failure) {
    if (failure is Failure) {
      return failure.when(
        server: (message, statusCode) => _handleServerError(message, statusCode),
        auth: (message, code) => _handleAuthError(message, code),
        network: (message) => '인터넷 연결을 확인해주세요. 네트워크 상태를 점검하고 다시 시도해주세요.',
        validation: (message, errors) => _handleValidationError(message, errors),
        unauthorized: (message) => '인증 정보가 올바르지 않습니다. 다시 로그인해주세요.',
        forbidden: (message) => '접근 권한이 없습니다. 관리자에게 문의하세요.',
        timeout: (message) => '요청 시간이 초과되었습니다. 잠시 후 다시 시도해주세요.',
        notFound: (message) => '요청한 정보를 찾을 수 없습니다.',
        cache: (message) => '데이터 로딩 중 문제가 발생했습니다. 다시 시도해주세요.',
        unknown: (message) => '알 수 없는 오류가 발생했습니다. 지속적으로 문제가 발생하면 고객센터에 문의하세요.',
      );
    }
    
    return '요청 처리 중 오류가 발생했습니다. 다시 시도해주세요.';
  }

  /// 서버 에러 메시지 처리
  static String _handleServerError(String message, int? statusCode) {
    switch (statusCode) {
      case 400:
        return _handleBadRequestError(message);
      case 401:
        return _handleUnauthorizedError(message);
      case 403:
        return _handleForbiddenError(message);
      case 404:
        return '요청한 정보를 찾을 수 없습니다. 다시 시도해주세요.';
      case 409:
        return '이미 존재하는 정보입니다. 다른 값으로 시도해주세요.';
      case 422:
        return _handleValidationErrorFromMessage(message);
      case 429:
        return '너무 많은 요청이 발생했습니다. 잠시 후 다시 시도해주세요.';
      case 500:
        return '서버에 일시적인 문제가 발생했습니다. 잠시 후 다시 시도해주세요.';
      case 502:
      case 503:
      case 504:
        return '서비스가 일시적으로 사용할 수 없습니다. 잠시 후 다시 시도해주세요.';
      default:
        return message.isNotEmpty ? message : '서버 오류가 발생했습니다. 다시 시도해주세요.';
    }
  }

  /// 400 Bad Request 에러 처리
  static String _handleBadRequestError(String message) {
    // 로그인 API 관련 400 에러
    if (message.contains('잘못된 사용자 이름') || message.contains('잘못된 이메일')) {
      return '아이디 또는 이메일을 확인해주세요.';
    }
    
    // 회원가입 API 관련 400 에러
    if (message.contains('이미 사용 중인 username')) {
      return '이미 사용 중인 사용자명입니다. 다른 사용자명을 입력해주세요.';
    }
    if (message.contains('이미 사용 중인 email')) {
      return '이미 가입된 이메일입니다. 다른 이메일을 사용하거나 로그인을 시도해주세요.';
    }
    
    // 소셜 로그인 관련 400 에러
    if (message.contains('올바른 Google ID Token 형식이 아닙니다')) {
      return 'Google 로그인에 실패했습니다. 다시 시도해주세요.';
    }
    
    // 일반적인 400 에러
    if (message.contains('username') || message.contains('사용자명')) {
      return '사용자명을 확인해주세요. 올바른 형식으로 입력해주세요.';
    }
    if (message.contains('password') || message.contains('비밀번호')) {
      return '비밀번호를 확인해주세요. 8자 이상 입력해주세요.';
    }
    if (message.contains('email') || message.contains('이메일')) {
      return '이메일 주소를 확인해주세요. 올바른 형식으로 입력해주세요.';
    }
    
    return message.isNotEmpty ? message : '입력한 정보를 다시 확인해주세요.';
  }

  /// 401 Unauthorized 에러 처리
  static String _handleUnauthorizedError(String message) {
    // 로그인 API 관련 401 에러
    if (message.contains('잘못된 비밀번호')) {
      // 로그인 실패 횟수 포함된 메시지 처리
      if (message.contains('(') && message.contains('/5회 실패)')) {
        return message; // 이미 포맷된 메시지 그대로 사용
      }
      return '비밀번호가 틀렸습니다.';
    }
    
    // 소셜 로그인 관련 401 에러
    if (message.contains('Google 인증에 실패했습니다')) {
      return 'Google 로그인에 실패했습니다. 다시 시도해주세요.';
    }
    if (message.contains('유효하지 않은 Google ID 토큰')) {
      return 'Google 로그인 인증에 실패했습니다. 다시 시도해주세요.';
    }
    if (message.contains('Kakao 인증에 실패했습니다')) {
      return '카카오 로그인에 실패했습니다. 다시 시도해주세요.';
    }
    if (message.contains('유효하지 않은 카카오 액세스 토큰')) {
      return '카카오 로그인 인증에 실패했습니다. 다시 시도해주세요.';
    }
    if (message.contains('Naver 인증에 실패했습니다')) {
      return '네이버 로그인에 실패했습니다. 다시 시도해주세요.';
    }
    if (message.contains('유효하지 않은 네이버 액세스 토큰')) {
      return '네이버 로그인 인증에 실패했습니다. 다시 시도해주세요.';
    }
    
    // 일반적인 401 에러
    if (message.contains('invalid_credentials') || message.contains('잘못된 인증')) {
      return '아이디 또는 비밀번호가 올바르지 않습니다. 다시 확인해주세요.';
    }
    if (message.contains('account_disabled') || message.contains('계정 비활성화')) {
      return '비활성화된 계정입니다. 관리자에게 문의하세요.';
    }
    if (message.contains('email_not_verified') || message.contains('이메일 미인증')) {
      return '이메일 인증이 필요합니다. 이메일을 확인하고 인증을 완료해주세요.';
    }
    if (message.contains('too_many_attempts') || message.contains('시도 횟수 초과')) {
      return '로그인 시도 횟수가 초과되었습니다. 잠시 후 다시 시도해주세요.';
    }
    if (message.contains('token_expired') || message.contains('토큰 만료')) {
      return '로그인 세션이 만료되었습니다. 다시 로그인해주세요.';
    }
    if (message.contains('token_invalid') || message.contains('토큰 무효')) {
      return '인증 정보가 올바르지 않습니다. 다시 로그인해주세요.';
    }
    
    return message.isNotEmpty ? message : '인증에 실패했습니다. 아이디와 비밀번호를 확인해주세요.';
  }

  /// 403 Forbidden 에러 처리
  static String _handleForbiddenError(String message) {
    // 로그인 API 관련 403 에러
    if (message.contains('5회 이상 로그인에 실패하여 계정이 30분 동안 잠겼습니다')) {
      return '로그인 시도 횟수를 초과했습니다. 30분 후 다시 시도해주세요.';
    }
    if (message.contains('계정이 잠겼습니다') && message.contains('분 후에 다시 시도')) {
      return message; // 이미 포맷된 메시지 그대로 사용
    }
    if (message.contains('계정이 비활성화되었습니다')) {
      return '계정이 비활성화되었습니다. 고객센터에 문의해주세요.';
    }
    
    // 일반적인 403 에러
    if (message.contains('account_locked') || message.contains('계정 잠금')) {
      return '계정이 잠겨있습니다. 관리자에게 문의하거나 잠시 후 다시 시도해주세요.';
    }
    if (message.contains('admin_disabled') || message.contains('관리자 비활성화')) {
      return '관리자에 의해 계정이 비활성화되었습니다. 고객센터에 문의하세요.';
    }
    if (message.contains('permission_denied') || message.contains('권한 없음')) {
      return '접근 권한이 없습니다. 필요한 권한을 확인해주세요.';
    }
    if (message.contains('region_blocked') || message.contains('지역 차단')) {
      return '현재 지역에서는 서비스를 이용할 수 없습니다.';
    }
    
    return message.isNotEmpty ? message : '접근이 거부되었습니다. 권한을 확인해주세요.';
  }

  /// 422 Validation 에러 처리 (메시지에서)
  static String _handleValidationErrorFromMessage(String message) {
    // 사용자명 검증 오류
    if (message.contains('사용자 이름은 최소 3자 이상이어야 합니다')) {
      return '사용자명은 3자 이상이어야 합니다.';
    }
    if (message.contains('사용자 이름은 알파벳, 숫자, 밑줄, 하이픈만 포함할 수 있습니다')) {
      return '사용자명은 영문, 숫자, 밑줄(_), 하이픈(-)만 사용할 수 있습니다.';
    }
    
    // 비밀번호 검증 오류
    if (message.contains('비밀번호는 최소 8자 이상이어야 합니다')) {
      return '비밀번호는 8자 이상이어야 합니다.';
    }
    if (message.contains('비밀번호는 최소 1개 이상의 대문자를 포함해야 합니다')) {
      return '비밀번호에 대문자를 포함해주세요.';
    }
    if (message.contains('비밀번호는 최소 1개 이상의 소문자를 포함해야 합니다')) {
      return '비밀번호에 소문자를 포함해주세요.';
    }
    if (message.contains('비밀번호는 최소 1개 이상의 숫자를 포함해야 합니다')) {
      return '비밀번호에 숫자를 포함해주세요.';
    }
    if (message.contains('비밀번호는 최소 1개 이상의 특수문자를 포함해야 합니다')) {
      return '비밀번호에 특수문자를 포함해주세요.';
    }
    if (message.contains('비밀번호가 일치하지 않습니다')) {
      return '비밀번호가 일치하지 않습니다.';
    }
    
    // 이메일 검증 오류
    if (message.contains('value is not a valid email address')) {
      return '올바른 이메일 형식을 입력해주세요.';
    }
    
    return message.isNotEmpty ? message : '입력한 정보가 올바르지 않습니다. 다시 확인해주세요.';
  }

  /// Validation 에러 처리 (에러 맵에서)
  static String _handleValidationError(String message, Map<String, String>? errors) {
    if (errors != null && errors.isNotEmpty) {
      // 첫 번째 필드 오류를 사용자 친화적으로 변환
      final firstError = errors.entries.first;
      final field = firstError.key;
      final error = firstError.value;
      
      switch (field) {
        case 'username':
          if (error.contains('최소 3자 이상')) {
            return '사용자명은 3자 이상이어야 합니다.';
          }
          if (error.contains('알파벳, 숫자, 밑줄, 하이픈만')) {
            return '사용자명은 영문, 숫자, 밑줄(_), 하이픈(-)만 사용할 수 있습니다.';
          }
          return '사용자명: $error';
        case 'email':
          if (error.contains('valid email address')) {
            return '올바른 이메일 형식을 입력해주세요.';
          }
          return '이메일: $error';
        case 'password':
          if (error.contains('최소 8자 이상')) {
            return '비밀번호는 8자 이상이어야 합니다.';
          }
          if (error.contains('대문자를 포함')) {
            return '비밀번호에 대문자를 포함해주세요.';
          }
          if (error.contains('소문자를 포함')) {
            return '비밀번호에 소문자를 포함해주세요.';
          }
          if (error.contains('숫자를 포함')) {
            return '비밀번호에 숫자를 포함해주세요.';
          }
          if (error.contains('특수문자를 포함')) {
            return '비밀번호에 특수문자를 포함해주세요.';
          }
          return '비밀번호: $error';
        case 'confirm_password':
          if (error.contains('일치하지 않습니다')) {
            return '비밀번호가 일치하지 않습니다.';
          }
          return '비밀번호 확인: $error';
        default:
          return '$field: $error';
      }
    }
    
    return message.isNotEmpty ? message : '입력한 정보를 다시 확인해주세요.';
  }

  /// 인증 관련 에러 처리
  static String _handleAuthError(String message, String? code) {
    switch (code) {
      // Google 로그인 에러
      case 'GOOGLE_SIGN_IN_FAILED':
        return 'Google 로그인에 실패했습니다. 다시 시도해주세요.';
      case 'GOOGLE_SIGN_IN_CANCELLED':
        return 'Google 로그인이 취소되었습니다.';
      case 'GOOGLE_SIGN_IN_NETWORK_ERROR':
        return 'Google 로그인 중 네트워크 오류가 발생했습니다. 인터넷 연결을 확인해주세요.';
      
      // 카카오 로그인 에러
      case 'KAKAO_SIGN_IN_FAILED':
        return '카카오 로그인에 실패했습니다. 다시 시도해주세요.';
      case 'KAKAO_SIGN_IN_CANCELLED':
        return '카카오 로그인이 취소되었습니다.';
      case 'KAKAO_SIGN_IN_NETWORK_ERROR':
        return '카카오 로그인 중 네트워크 오류가 발생했습니다. 인터넷 연결을 확인해주세요.';
      
      // 네이버 로그인 에러
      case 'NAVER_SIGN_IN_FAILED':
        return '네이버 로그인에 실패했습니다. 다시 시도해주세요.';
      case 'NAVER_SIGN_IN_CANCELLED':
        return '네이버 로그인이 취소되었습니다.';
      case 'NAVER_SIGN_IN_NETWORK_ERROR':
        return '네이버 로그인 중 네트워크 오류가 발생했습니다. 인터넷 연결을 확인해주세요.';
      
      // 소셜 로그인 공통 에러
      case 'SOCIAL_LOGIN_ACCOUNT_NOT_FOUND':
        return '소셜 계정과 연결된 회원 정보가 없습니다. 먼저 회원가입을 진행해주세요.';
      case 'SOCIAL_LOGIN_ALREADY_LINKED':
        return '이미 다른 계정과 연결된 소셜 계정입니다.';
      
      // 비밀번호 변경 에러
      case 'PASSWORD_CHANGE_SOCIAL_USER':
        return '소셜 로그인 사용자는 비밀번호를 변경할 수 없습니다.';
      case 'CURRENT_PASSWORD_INCORRECT':
        return '현재 비밀번호가 올바르지 않습니다. 다시 확인해주세요.';
      
      default:
        return message.isNotEmpty ? message : '인증 과정에서 오류가 발생했습니다. 다시 시도해주세요.';
    }
  }

  /// 500 서버 에러 처리
  static String _handleServerError500(String message) {
    // 소셜 로그인 관련 500 에러
    if (message.contains('Google 로그인 설정 오류')) {
      return '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
    }
    if (message.contains('카카오 로그인 처리 중 오류')) {
      return '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
    }
    if (message.contains('네이버 로그인 처리 중 오류')) {
      return '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
    }
    
    // 회원가입 관련 500 에러
    if (message.contains('이메일 인증 토큰 생성에 실패')) {
      return '회원가입은 완료되었지만 인증 이메일 발송에 실패했습니다. 로그인 후 인증 메일을 재요청해주세요.';
    }
    
    return '서버에 일시적인 문제가 발생했습니다. 잠시 후 다시 시도해주세요.';
  }

  /// 성공 메시지 가져오기
  static String getSuccessMessage({
    required String action,
    String? userName,
    String? email,
    String? provider,
  }) {
    switch (action) {
      case 'login':
        if (provider != null) {
          return userName != null 
            ? '$provider 계정으로 로그인되었습니다. 환영합니다, $userName님!'
            : '$provider 계정으로 로그인되었습니다.';
        }
        return userName != null 
          ? '환영합니다, $userName님!' 
          : '로그인에 성공했습니다.';
      case 'signup':
        return userName != null 
          ? '$userName님, 환영합니다! TOEIC4ALL에 성공적으로 가입되었습니다.'
          : '회원가입이 완료되었습니다.';
      case 'password_reset_request':
        return email != null
          ? '$email로 비밀번호 재설정 링크를 보냈습니다.'
          : '비밀번호 재설정 이메일을 발송했습니다.';
      case 'password_change':
        return '비밀번호가 성공적으로 변경되었습니다.';
      case 'logout':
        return '안전하게 로그아웃되었습니다.';
      default:
        return '작업이 완료되었습니다.';
    }
  }
}

/// SnackBar 스타일을 위한 유틸리티 클래스
class AuthSnackBarHelper {
  /// 성공 SnackBar 생성
  static SnackBar success(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
  }

  /// 에러 SnackBar 생성
  static SnackBar error(String message, {VoidCallback? onActionPressed}) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      action: onActionPressed != null ? SnackBarAction(
        label: '닫기',
        textColor: Colors.white,
        onPressed: onActionPressed,
      ) : null,
    );
  }

  /// 경고 SnackBar 생성
  static SnackBar warning(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.warning, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
  }

  /// 정보 SnackBar 생성
  static SnackBar info(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.info, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
  }
}
