import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.orange,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 16.sp, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.black87),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.blue, width: 2.w),
        ),
      ),
    );
  }

  // Você pode adicionar um tema escuro aqui se necessário
  // static ThemeData get darkTheme { ... }
}
