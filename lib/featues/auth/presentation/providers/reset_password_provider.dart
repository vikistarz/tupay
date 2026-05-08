// lib/features/auth/providers/reset_password_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/auth/presentation/screen/login/login_screen.dart';

class ResetPasswordState {
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final bool isButtonEnabled;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool passwordMatch;

  ResetPasswordState({this.isLoading = false, this.error, this.successMessage,  this.isButtonEnabled = false,
    this.passwordVisible = false,
    this.confirmPasswordVisible = false, this.hasMinLength = false, this.hasUppercase = false,
    this.hasNumber = false, this.hasSpecialChar = false, this.passwordMatch = false});

  ResetPasswordState copyWith({
    bool? isLoading,
    String? error,
    bool? isButtonEnabled,
    bool? passwordVisible,
    bool? confirmPasswordVisible,
    bool? hasMinLength,
    bool? hasUppercase,
    bool? hasNumber,
    bool? hasSpecialChar,
    bool? passwordMatch,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible: confirmPasswordVisible ?? this.confirmPasswordVisible,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      passwordMatch: passwordMatch ?? this.passwordMatch,
    );
  }
}

class ResetPasswordNotifier extends AsyncNotifier<ResetPasswordState> {
  @override
  Future<ResetPasswordState> build() async => ResetPasswordState();



  /// Toggle password
  void togglePassword() {
    final current = state.value ??ResetPasswordState();

    state = AsyncData(
      current.copyWith(
        passwordVisible: !current.passwordVisible,
      ),
    );
  }

  /// Toggle confirm password
  void toggleConfirmPassword() {
    final current = state.value ?? ResetPasswordState();

    state = AsyncData(
      current.copyWith(
        confirmPasswordVisible: !current.confirmPasswordVisible,
      ),
    );
  }


  void validateForm(GlobalKey<FormState> formKey) {
    final current = state.value ?? ResetPasswordState();

    final isValid = formKey.currentState?.validate() ?? false;

    state = AsyncData(
      current.copyWith(
        isButtonEnabled: isValid,
      ),
    );
  }

  void onPasswordChanged(String password, String confirmPassword) {
    final current = state.value ?? ResetPasswordState();

    final hasMinLength = password.length >= 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecialChar =
    RegExp(r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]=+;]').hasMatch(password);

    final passwordMatch =
        confirmPassword.isNotEmpty && password == confirmPassword;

    final isValid = hasMinLength &&
        hasUppercase &&
        hasNumber &&
        hasSpecialChar &&
        passwordMatch;

    state = AsyncData(
      current.copyWith(
        hasMinLength: hasMinLength,
        hasUppercase: hasUppercase,
        hasNumber: hasNumber,
        hasSpecialChar: hasSpecialChar,
        passwordMatch: passwordMatch,
        isButtonEnabled: isValid,
      ),
    );
  }

  void onConfirmPasswordChanged(String confirmPassword, String password) {
    final current = state.value ?? ResetPasswordState();

    final passwordMatch =
        confirmPassword.isNotEmpty && password == confirmPassword;

    final isValid = current.hasMinLength &&
        current.hasUppercase &&
        current.hasNumber &&
        current.hasSpecialChar &&
        passwordMatch;

    state = AsyncData(
      current.copyWith(
        passwordMatch: passwordMatch,
        isButtonEnabled: isValid,
      ),
    );
  }

  Future<void> updatePassword({
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    final current = state.value ?? ResetPasswordState();

    state = AsyncData(
      current.copyWith(isLoading: true),
    );

    try {
      await Future.delayed(const Duration(seconds: 2));

      /// stop loading
      state = AsyncData(
        current.copyWith(
          isLoading: false,

        ),
      );

      /// ✅ SAFE navigation
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );

    } catch (e) {
      print("ERROR: $e");
      state = AsyncData(
        current.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reset password failed")),
      );
    }
  }
}

final resetPasswordProvider = AsyncNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
      () => ResetPasswordNotifier(),
);