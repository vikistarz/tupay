
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:tupay_app/featues/auth/presentation/screen/login/login_screen.dart';

enum SignupStatus { initial, loading, success, error, passwordVisible, buttonEnabled}

class SignupState {
  final SignupStatus status;
  final String? errorMessage;
  final bool isLoading;
  final bool passwordVisible;
  final bool isButtonEnabled;


  SignupState({this.status = SignupStatus.initial, this.errorMessage, this.isLoading = false, this.passwordVisible = false, this.isButtonEnabled = false});

  SignupState copyWith({SignupStatus? status, String? errorMessage, bool? isLoading,  bool? passwordVisible,  bool? isButtonEnabled}) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}

class SignupNotifier extends AsyncNotifier<SignupState> {
  @override
  Future<SignupState> build() async {
    return SignupState();
  }

  /// Toggle password
  void togglePassword() {
    final current = state.value ?? SignupState();

    state = AsyncData(
      current.copyWith(
        passwordVisible: !current.passwordVisible,
      ),
    );
  }

  void validateForm(GlobalKey<FormState> formKey) {
    final current = state.value ?? SignupState();

    final isValid = formKey.currentState?.validate() ?? false;

    state = AsyncData(
      current.copyWith(
        isButtonEnabled: isValid,
      ),
    );
  }





  Future<void> createAccount({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required BuildContext context
  }) async {

    final current = state.value ?? SignupState();

    state = AsyncData(
      current.copyWith(isLoading: true),
    );

    try {
      await Future.delayed(const Duration(seconds: 2));

      /// stop loading
      state = AsyncData(
        current.copyWith(
          isLoading: false,
          status: SignupStatus.success,
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
          status: SignupStatus.error,
          errorMessage: e.toString(),
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign Up failed")),
      );
    }
  }


}

final signupProvider = AsyncNotifierProvider<SignupNotifier, SignupState>(() => SignupNotifier());