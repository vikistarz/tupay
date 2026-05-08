import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF00A86B);
  static const primaryDark = Color(0xFF006C49);
  static const background = Color(0xFFF8F9FA);
  static const blue = Color(0xFF3980F4);
  static const lightGreen = Color(0xFF6CF8BB);
  static const veryLightGreen = Color(0xFF00E5B0);
  static const cardBackground = Colors.white;
  static const cutColor = Color(0xFFECEEF0);
  static const newCutColor = Color(0xFFC6C6CD);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
  static const success = Color(0xFF00A86B);

  static const balanceCardOne = Color(0xFF1A1F2E);
  static const balanceCardTwo = Color(0xFF0F1629);
  static const balanceCardThree = Color(0xFF7C839B);
  static const balanceCardFour = Color(0xFF006C49);
  static const balanceCardFive = Color(0xFF6FFBBE);

  static const walletOne = Color(0xFFF1F5F9);

  static const bottomNavEnable = Color(0xFF10B981);
  static const bottomNavDisabled = Color(0xFF94A3B8);

  static const transactionHistoryOne= Color(0xFF6CF8BB);

  static const transactionHistoryTwo= Color(0xFFE6E8EA);

  static const transactionHistoryThree= Color(0xFF475569);
  static const transactionHistoryFour= Color(0xFFD8E2FF);
  static const transactionHistoryFive = Color(0xFF6CF8BB);

  static const chartOne= Color(0xFFF2F4F6);

  static const pendingTrans = Color(0xFF64748B);
  static const pendingTransTwo = Color(0xFFF59E0B);

  static const recentAct = Color(0xFFF1F5F9);
  static const recentActTwo = Color(0xFFBA1A1A);
  static const recentActThree = Color(0xFF006C49);

  static const recentActFour = Color(0xFFFEF3C7);

  static const visualCard = Color(0xFF131B2E);
  static const visualCardOne = Color(0xFF1E293B);

  static const cardSecurity = Color(0xFFF7F9FB);
  static const cardSecurityOne = Color(0xFFE0E3E5);

  static const recentCard = Color(0xFF45464D);

  static const transfer_stepper = Color(0xFF76777D);

  static const transfer_stepperOne = Color(0xFFF2F4F6);
  static const transfer_stepperTwo = Color(0xFFC6C6CD);

  static const paymentMeth = Color(0xFF6CF8BB);

  static const transferSum = Color(0xFF3F465C);

  static const logout = Color(0xFFFFDAD6);

  static const linkDev = Color(0xFF0F172A);


}





final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.cardBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    foregroundColor: AppColors.textPrimary,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    filled: true,
    fillColor: AppColors.cardBackground,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
  ),
);