// lib/features/auth/presentation/reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../providers/reset_password_provider.dart';
import '../login/login_screen.dart';


class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();



  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resetAsync = ref.watch(resetPasswordProvider);
    final resetState  = resetAsync.value ?? ResetPasswordState();
    final notifier = ref.read(resetPasswordProvider.notifier);

    final theme = Theme.of(context);

    ref.listen(resetPasswordProvider, (previous, next) {
      final data = next.value;

      if (data?.successMessage != null) {
        // ✅ Navigate to login after success
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      }

      if (data?.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data!.error!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon:  Icon(Icons.arrow_back, size: 32.0, color: theme.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('TuPay'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Help',
                style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [

            const SizedBox(height: 24),

            // Reset Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.veryLightGreen.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.lock_reset,
                size: 40,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Enter your new password below.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 40),

            // Form Card
            Card(
              elevation: 2,
              color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // key: _formKey,
                  // onChanged: () => notifier.validateForm(_formKey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // New Password
                      Text('New Password', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (value) {
                          notifier.onPasswordChanged(
                            value,
                            _confirmPasswordController.text,
                          );
                        },
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: _newPasswordController,
                        obscureText: !resetState.passwordVisible,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: const Icon(Icons.lock_outline),
                          errorMaxLines: 3, // 👈 THIS FIXES IT
                          suffixIcon: IconButton(
                            icon: Icon(resetState.passwordVisible
                                ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                            onPressed: notifier.togglePassword,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Confirm New Password
                      Text('Confirm New Password', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          final trimmedValue = value?.trim() ?? '';
                          if (trimmedValue == null || trimmedValue.isEmpty) {
                            return 'Enter confirm  password';
                            return null;
                          }
                          if (trimmedValue.length < 8) {
                            return 'must be at least 8 characters long';
                          }
                          if (trimmedValue != _newPasswordController.text) {
                            return 'Confirm Passwords do not match with new password';
                          }
                          else{
                            return null; // Return null if the input is valid
                          }
                        },
                        onChanged: (value) {
                          notifier.onConfirmPasswordChanged(
                            value,
                            _newPasswordController.text,
                          );
                        },
                        controller: _confirmPasswordController,
                        obscureText: !resetState.confirmPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: const Icon(Icons.lock_outline),
                          errorMaxLines: 3, // 👈 THIS FIXES IT
                          suffixIcon: IconButton(
                            icon: Icon(resetState.confirmPasswordVisible
                                ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                            onPressed: notifier.toggleConfirmPassword,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Password Requirements
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Expanded(child: _buildRequirementRow('Min. 8 characters', resetState.hasMinLength)),
                          Expanded(child: _buildRequirementRow('One number', resetState.hasNumber)),

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Expanded(child:  _buildRequirementRow('One uppercase', resetState.hasUppercase)),
                          Expanded(child: _buildRequirementRow('Special character', resetState.hasSpecialChar)),

                        ],
                      ),

                      const SizedBox(height: 32),

                      // Update Password Button

                      SizedBox(
                        width: double.infinity,
                        child: resetState.isLoading
                            ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                            :
                        ElevatedButton(
                          onPressed: resetState.isButtonEnabled
                              ? () => notifier.updatePassword(
                            context: context,
                            newPassword: _newPasswordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          )
                              : null,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Update Password'),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Security Note
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                color: AppColors.cutColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('images/green_shield.png',
                    height: 15,
                    width: 12,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'End-to-end encrypted session',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Support Link
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Having trouble? ',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.0),
                  children: [
                    TextSpan(
                      text: 'Contact Security Support',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Footer
            SafeArea(
              top: false,
              child: const Text(
                '© 2024 Tupay Global. Secure Velocity and Tupay are registered trademarks.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.newCutColor, fontSize: 13),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle_outline : Icons.radio_button_unchecked,
            size: 15,
            color: isMet ? AppColors.primaryDark : AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: isMet ? AppColors.textPrimary : AppColors.textSecondary, fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}