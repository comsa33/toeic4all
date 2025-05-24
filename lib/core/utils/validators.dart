// 유효성 검사 유틸리티

class Validators {
  // 편의 메서드들
  static String? username(String? value) => validateUsername(value);
  static String? email(String? value) => validateRequired(value, '이메일');
  static String? password(String? value) => validatePassword(value);
  static String? name(String? value) => validateName(value);
  
  // 사용자 이름 유효성 검사
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return '사용자 이름을 입력해주세요';
    }

    final usernameRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+$',
    );

    if (!usernameRegex.hasMatch(value)) {
      return '올바른 사용자 이름 형식을 입력해주세요';
    }

    return null;
  }

  // 비밀번호 유효성 검사
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    
    if (value.length < 8) {
      return '비밀번호는 8자 이상이어야 합니다';
    }
    
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return '비밀번호에 대문자가 포함되어야 합니다';
    }
    
    if (!value.contains(RegExp(r'[a-z]'))) {
      return '비밀번호에 소문자가 포함되어야 합니다';
    }
    
    if (!value.contains(RegExp(r'[0-9]'))) {
      return '비밀번호에 숫자가 포함되어야 합니다';
    }
    
    return null;
  }

  // 비밀번호 확인 유효성 검사
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return '비밀번호 확인을 입력해주세요';
    }
    
    if (value != password) {
      return '비밀번호가 일치하지 않습니다';
    }
    
    return null;
  }

  // 이름 유효성 검사
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요';
    }
    
    if (value.length < 2) {
      return '이름은 2자 이상이어야 합니다';
    }
    
    if (value.length > 20) {
      return '이름은 20자 이하여야 합니다';
    }
    
    return null;
  }

  // 휴대폰 번호 유효성 검사
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return '휴대폰 번호를 입력해주세요';
    }
    
    final phoneRegex = RegExp(r'^010-?[0-9]{4}-?[0-9]{4}$');
    
    if (!phoneRegex.hasMatch(value.replaceAll('-', ''))) {
      return '올바른 휴대폰 번호를 입력해주세요';
    }
    
    return null;
  }

  // 필수 필드 유효성 검사
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName을(를) 입력해주세요';
    }
    return null;
  }

  // 최소 길이 유효성 검사
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.length < minLength) {
      return '$fieldName은(는) $minLength자 이상이어야 합니다';
    }
    return null;
  }

  // 최대 길이 유효성 검사
  static String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName은(는) $maxLength자 이하여야 합니다';
    }
    return null;
  }

  // 숫자만 허용하는 유효성 검사
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName을(를) 입력해주세요';
    }
    
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return '$fieldName은(는) 숫자만 입력 가능합니다';
    }
    
    return null;
  }

  // URL 유효성 검사
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL을 입력해주세요';
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return '올바른 URL을 입력해주세요';
    }
    
    return null;
  }
}
