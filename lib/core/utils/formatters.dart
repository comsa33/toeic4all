import 'package:intl/intl.dart';

// 포맷터 유틸리티

class Formatters {
  // 날짜 포맷터
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  // 숫자 포맷터
  static String formatNumber(int number) {
    return NumberFormat('#,###').format(number);
  }

  static String formatDecimal(double number, {int decimalPlaces = 2}) {
    return number.toStringAsFixed(decimalPlaces);
  }

  static String formatPercentage(double percentage, {int decimalPlaces = 1}) {
    return '${(percentage * 100).toStringAsFixed(decimalPlaces)}%';
  }

  // 전화번호 포맷터
  static String formatPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleaned.length == 11 && cleaned.startsWith('010')) {
      return '${cleaned.substring(0, 3)}-${cleaned.substring(3, 7)}-${cleaned.substring(7)}';
    }
    
    return phoneNumber;
  }

  // 문자열 포맷터
  static String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // 파일 크기 포맷터
  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double size = bytes.toDouble();
    
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }

  // 시간 지속 시간 포맷터
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  // 통계 포맷터
  static String formatAccuracy(double accuracy) {
    return '${(accuracy * 100).toInt()}%';
  }

  static String formatScore(int score) {
    return score.toString().padLeft(3, '0');
  }

  // 통화 포맷터
  static String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'ko_KR',
      symbol: '₩',
      decimalDigits: 0,
    ).format(amount);
  }

  // TOEIC 점수 레벨 포맷터
  static String formatToeicLevel(int score) {
    if (score >= 900) return 'Advanced (900+)';
    if (score >= 800) return 'High Intermediate (800-895)';
    if (score >= 700) return 'Intermediate (700-795)';
    if (score >= 600) return 'Pre-Intermediate (600-695)';
    if (score >= 500) return 'Elementary (500-595)';
    return 'Beginner (0-495)';
  }

  // Part별 난이도 포맷터
  static String formatDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return '쉬움';
      case 'medium':
        return '보통';
      case 'hard':
        return '어려움';
      default:
        return difficulty;
    }
  }

  // 학습 연속일 포맷터
  static String formatStreak(int days) {
    if (days == 0) return '오늘부터 시작!';
    return '$days일 연속';
  }
}
