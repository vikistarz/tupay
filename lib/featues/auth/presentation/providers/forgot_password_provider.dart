// lib/features/auth/providers/forgot_password_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/auth/presentation/screen/reset_password/reset_password.dart';

class ForgotPasswordState {
  final bool isLoading;
  final String? message;
  final String? error;
  final bool isButtonEnabled;

  ForgotPasswordState({this.isLoading = false, this.message, this.error, this.isButtonEnabled = false});

  ForgotPasswordState copyWith({bool? isLoading, String? error, bool? isButtonEnabled}) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}

class ForgotPasswordNotifier extends AsyncNotifier<ForgotPasswordState> {
  @override
  Future<ForgotPasswordState> build() async => ForgotPasswordState();

  void validateForm(GlobalKey<FormState> formKey) {
    final current = state.value ?? ForgotPasswordState();

    final isValid = formKey.currentState?.validate() ?? false;

    state = AsyncData(
      current.copyWith(
        isButtonEnabled: isValid,
      ),
    );
  }

  Future<void> sendResetLink({required String email, required BuildContext context}) async {
    final current = state.value ?? ForgotPasswordState();

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
          builder: (_) => const ResetPasswordScreen(),
        ),
      );

    } catch (e) {
      print(" ERROR: $e");
      state = AsyncData(
        current.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Forget password failed")),
      );
    }
  }
}

final forgotPasswordProvider = AsyncNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
      () => ForgotPasswordNotifier(),
);