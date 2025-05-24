import 'package:flutter/material.dart';

class AppColors {
  // Primary - Modern Blue (신뢰감과 전문성)
  static const primary = Color(0xFF2563EB);
  static const primaryLight = Color(0xFF60A5FA);
  static const primaryDark = Color(0xFF1E40AF);
  
  // Secondary - Vibrant Coral (에너지와 열정)
  static const secondary = Color(0xFFF97316);
  static const secondaryLight = Color(0xFFFBBF24);
  
  // Success/Correct - Modern Green
  static const success = Color(0xFF10B981);
  
  // Error/Wrong - Soft Red
  static const error = Color(0xFFEF4444);
  
  // Background
  static const background = Color(0xFFF9FAFB);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF3F4F6);
  
  // Text
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);
  
  // Gradient
  static const primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
