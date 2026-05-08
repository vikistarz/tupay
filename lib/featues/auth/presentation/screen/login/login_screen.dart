// lib/features/auth/presentation/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/login_provider.dart';
import '../forget_password/forget_password.dart';
import '../signUp/signup_screen.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "");
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginAsync = ref.watch(loginProvider);
    final loginState = loginAsync.value ?? LoginState();
    final notifier = ref.read(loginProvider.notifier);
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async{
        SystemNavigator.pop();
      },
      child: Scaffold(
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
          // padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 24),
              Center(
                child: const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  'Institutional-grade security for your digital assets.', textAlign: TextAlign.center  ,
                  style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 27),

              // Login Form Card
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Card(
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
                          // Email or Username
                          Text('Email or Username', style: theme.textTheme.titleMedium),
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
                          const SizedBox(height: 24),

                          // Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Password', style: theme.textTheme.titleMedium),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (value) {
                              final trimmedValue = value?.trim() ?? '';
                              if (trimmedValue == null || trimmedValue.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (trimmedValue.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            controller: _passwordController,
                            obscureText: loginState.passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              errorMaxLines: 3,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(loginState.passwordVisible
                                    ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                onPressed: notifier.togglePassword,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Log In Button

                          SizedBox(
                            width: double.infinity,
                            child: loginState.isLoading
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
                              onPressed: loginState.isButtonEnabled
                                  ? () => notifier.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                                context: context,
                              )
                                  : null,
                              child: const Text('Log In'),
                            ),
                          ),


                          const SizedBox(height: 32),

                          // OR Divider
                          const Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text('OR LOGIN WITH', style: TextStyle(color: AppColors.textSecondary)),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 24),


                          // Biometric & Face ID
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.fingerprint, size: 28, color:  AppColors.textPrimary),
                                  label: const Text('Biometric', style: TextStyle(color:  AppColors.textPrimary),),
                                  onPressed: () {
                                  notifier.handleBiometricLogin(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    side: const BorderSide(color: AppColors.border),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // 👈 adjust this
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.face_outlined, size: 28, color:  AppColors.textPrimary),
                                  label: const Text('Face ID', style: TextStyle(color:  AppColors.textPrimary),),
                                  onPressed: () {
                                    notifier.handleBiometricLogin(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    side: const BorderSide(color: AppColors.border),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // 👈 adjust this
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 20),

              // Sign Up Link
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: AppColors.textSecondary),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),


              // Security Badges
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSecurityBadge('images/shield_mark.png', 'ISO 27001'),
                  const SizedBox(width: 20),
                  _buildSecurityBadge('images/shield_lock.png', 'PCI DSS'),
                  const SizedBox(width: 20),
                  _buildSecurityBadge('images/shield_strike.png', 'Instant'),
                ],
              ),

              const SizedBox(height: 42),

              Divider(),

              const SizedBox(height: 42),

              // Encrypted Footer
              SafeArea(
                top: false,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline_rounded, size: 11, color: AppColors.textSecondary),
                    SizedBox(width: 6),
                    Text(
                      'Your connection to Tupay is encrypted and secure.',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityBadge(String imagePath, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.cutColor,
          child: Image.asset(
            imagePath,
            height: 20,
            width: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}