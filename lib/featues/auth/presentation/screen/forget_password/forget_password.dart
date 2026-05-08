// lib/features/auth/presentation/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/auth/presentation/screen/reset_password/reset_password.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../providers/forgot_password_provider.dart';


class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "");

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final forgetAsync = ref.watch(forgotPasswordProvider);
    final forgotState  = forgetAsync.value ?? ForgotPasswordState();
    final notifier = ref.read(forgotPasswordProvider.notifier);
    final theme = Theme.of(context);


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
                color: AppColors.lightGreen,
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
              'Forgot Password',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Enter your email address and we'll send you instructions to reset your password.",
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
                  key: _formKey,
                  onChanged: () => notifier.validateForm(_formKey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email Address', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          final trimmedValue = value?.trim() ?? '';
                          if (trimmedValue == null || trimmedValue.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (trimmedValue.length < 8) {
                            return 'Please enter a valid email address';
                          }
                          if (!regex.hasMatch(trimmedValue)) {
                            return 'Please enter a valid email address';
                          }
                          else{
                            return null; // Return null if the input is valid
                          }
                        },
                        cursorColor: Colors.black,
                        keyboardType:TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'name@company.com',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Send Reset Link Button

                      SizedBox(
                        width: double.infinity,
                        child: forgotState.isLoading
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
                          onPressed: forgotState.isButtonEnabled
                              ? () => notifier.sendResetLink(
                            email: _emailController.text,
                            context: context,
                          )
                              : null,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Send Reset Link'),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),


                      const SizedBox(height: 20),

                      Divider(),

                      const SizedBox(height: 20),

                      // Back to Login
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_back, size: 18),
                              SizedBox(width: 6),
                              Text(
                                'Back to Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Security Note
         Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/shield_mark.png',
                      height: 15,
                      width: 12,
                    ),
                    const SizedBox(width: 8),
                  const Text(
                        'End-to-end encrypted password recovery',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0),
                      ),

                  ],
                ),
              ),


            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('images/logo_one.png',
                  height: 25,
                  width: 25,
                ),

                const SizedBox(width: 30),

                Image.asset('images/logo_two.png',
                  height: 25,
                  width: 25,
                ),

              ],
            ),

            const SizedBox(height: 70),

            // Footer
            SafeArea(
              top: false,
              child: Column(
                children: [
                  Text(
                    '© 2024 Secure Velocity. All rights reserved.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Privacy Policy', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      const SizedBox(width: 16),
                      Text('Terms of Service', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      const SizedBox(width: 16),
                      Text('Contact Support', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}