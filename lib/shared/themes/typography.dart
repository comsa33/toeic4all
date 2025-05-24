import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppTypography {
  static const fontFamily = 'Pretendard';
  
  // Heading 스타일
  static const headingXL = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );
  
  static const headingL = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );
  
  static const headingM = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.3,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );
  
  static const headingS = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );
  
  // Body 스타일
  static const bodyL = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );
  
  static const bodyM = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );
  
  static const bodyS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.3,
    fontFamily: fontFamily,
    color: AppColors.textSecondary,
  );
  
  // Caption 스타일
  static const caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    height: 1.2,
    fontFamily: fontFamily,
    color: AppColors.textTertiary,
  );
  
  // Button 스타일
  static const buttonL = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );
  
  static const buttonM = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );
  
  static const buttonS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );
  
  // Label 스타일
  static const label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    fontFamily: fontFamily,
    color: AppColors.textSecondary,
  );
}

// Typography extension for easy usage
extension TextStyleExtension on TextStyle {
  TextStyle get primary => copyWith(color: AppColors.textPrimary);
  TextStyle get secondary => copyWith(color: AppColors.textSecondary);
  TextStyle get tertiary => copyWith(color: AppColors.textTertiary);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get success => copyWith(color: AppColors.success);
  TextStyle get error => copyWith(color: AppColors.error);
}
