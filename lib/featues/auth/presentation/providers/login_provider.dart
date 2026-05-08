// lib/features/auth/providers/login_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/ui/dashboard_screen.dart';

import '../../../../core/services/biometricService.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final bool passwordVisible;
  final bool isButtonEnabled;

  LoginState({this.isLoading = false, this.error, this.passwordVisible = false, this.isButtonEnabled = false});

  LoginState copyWith({bool? isLoading, String? error, bool? passwordVisible,  bool? isButtonEnabled}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}

class LoginNotifier extends AsyncNotifier<LoginState> {
  @override
  Future<LoginState> build() async => LoginState();

  final BiometricService _biometricService = BiometricService();



  /// Toggle password
  void togglePassword() {
    final current = state.value ?? LoginState();

    state = AsyncData(
      current.copyWith(
        passwordVisible: !current.passwordVisible,
      ),
    );
  }

  void validateForm(GlobalKey<FormState> formKey) {
    final current = state.value ?? LoginState();

    final isValid = formKey.currentState?.validate() ?? false;

    state = AsyncData(
      current.copyWith(
        isButtonEnabled: isValid,
      ),
    );
  }





  Future<void> login({required String email, required String password, required BuildContext context}) async {
    final current = state.value ?? LoginState();

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
          builder: (_) => const DashboardScreen(),
        ),
      );

    } catch (e) {
      print("LOGIN ERROR: $e");
      state = AsyncData(
        current.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed")),
      );
    }
  }

  Future<void> handleBiometricLogin(BuildContext context) async {
    final isAvailable =
    await _biometricService.isBiometricAvailable();



    if (!isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biometric authentication not available'),
        ),
      );
      return;
    }

    final isAuthenticated =
    await _biometricService.authenticate();

    print("Authenticated: $isAuthenticated");

    if (isAuthenticated) {

      // TODO:
      // Navigate directly OR
      // Trigger saved login credentials

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication successful'),
        ),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed'),
        ),
      );
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginNotifier, LoginState>(() => LoginNotifier());


// Example in any notifier
// Future<void> processTransaction() async {
//   // ... after successful transaction
//   await SecureStorage.saveTransactionId("TXN_${DateTime.now().millisecondsSinceEpoch}");
// }