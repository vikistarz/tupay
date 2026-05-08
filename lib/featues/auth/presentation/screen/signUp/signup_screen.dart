import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/signup_provider.dart';
import '../login/login_screen.dart';


class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final _phoneController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");


  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupAsync = ref.watch(signupProvider);
    final signupState = signupAsync.value ?? SignupState();
    final notifier = ref.read(signupProvider.notifier);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            // Form wrapped in Card
            Card(
              elevation: 2,
                color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      'Create Account',
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Join global citizens managing finance with speed and security.',
                      style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                    ),

                    Form(
                      key: _formKey,
                      onChanged: () => notifier.validateForm(_formKey),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                           height: 20.0,
                          ),
                          // Full Name
                          Text('Full Name', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (value) {
                              final trimmedValue = value?.trim() ?? '';

                              // Allow letters, spaces, apostrophes, and hyphens
                              final regex = RegExp(r"^[a-zA-Z]+([ '-][a-zA-Z]+)*$");

                              if (trimmedValue.isEmpty) {
                                return 'Enter full name';
                              }

                              if (trimmedValue.length < 3) {
                                return 'Name is too short';
                              }

                              if (!regex.hasMatch(trimmedValue)) {
                                return 'Enter a valid full name';
                              }

                              return null;
                            },
                            controller: _fullNameController,
                            keyboardType:TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(hintText: 'John Doe'),
                          ),
                          const SizedBox(height: 24),

                          // Email Address
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
                            decoration: const InputDecoration(hintText: 'name@company.com'),
                          ),
                          const SizedBox(height: 24),

                          // Phone Number
                          Text('Phone Number', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  width: 55,
                                  child: Container(
                                     padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.border),
                                      color: AppColors.cutColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text('+234', style: TextStyle(fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    final regex = RegExp(r'^[+-]?\d+(\.\d+)?$');
                                    final trimmedValue = value?.trim() ?? '';
                                    if (trimmedValue == null || trimmedValue.isEmpty) {
                                      return 'Enter phone Number';
                                    }
                                    if (trimmedValue.length < 10) {
                                      return 'Enter a valid Phone Number';
                                    }
                                    if (!regex.hasMatch(trimmedValue)) {
                                      return 'Enter a valid Phone Number';
                                    } else {
                                      return null; // Return null if the input is valid
                                    }
                                  },
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  decoration: const InputDecoration(hintText: '(555) 000-0000'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Password
                          Text('Password', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (value) {
                              final trimmedValue = value?.trim() ?? '';

                              final hasUppercase = RegExp(r'[A-Z]').hasMatch(trimmedValue);
                              final hasDigit = RegExp(r'\d').hasMatch(trimmedValue);
                              final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]=+;]').hasMatch(trimmedValue);

                              if (trimmedValue.isEmpty) {
                                return 'Enter your password';
                              }

                              if (trimmedValue.length < 8) {
                                return 'Must be at least 8 characters long';
                              }

                              if (!hasUppercase) {
                                return 'Must contain at least one uppercase letter';
                              }

                              if (!hasDigit) {
                                return 'Must contain at least one number';
                              }

                              if (!hasSpecialChar) {
                                return 'Must contain at least one special character';
                              }

                              return null;
                            },
                            controller: _passwordController,
                            obscureText: !signupState.passwordVisible,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              errorMaxLines: 3, // 👈 THIS FIXES IT
                              suffixIcon: IconButton(
                                icon: Icon(signupState.passwordVisible
                                    ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                onPressed: notifier.togglePassword,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Create Account Button
                          SizedBox(
                            width: double.infinity,
                            child: signupState.isLoading
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
                                onPressed: signupState.isButtonEnabled
                                    ? () => notifier.createAccount(
                                  fullName: _fullNameController.text,
                                  email: _emailController.text,
                                  phone: '+234 ${_phoneController.text}',
                                  password: _passwordController.text,
                                  context: context,
                                )
                                    : null,
                                child: const Text('Create Account'),
                              ),
                          ),
                        ],
                      ),
                    ),



                    const SizedBox(height: 32),

                    // OR Divider
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR CONTINUE WITH', style: TextStyle(color: AppColors.textSecondary)),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),


                    // Social Login Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Image(
                              image: AssetImage('images/google_icon.png'),
                              height: 21.0,
                              width: 21.0,
                            ),
                            label: const Text('Google', style: TextStyle(color: AppColors.textPrimary)),
                            onPressed: () {},
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
                            icon: const Image(
                              image: AssetImage('images/ios_icon.png'),
                              height: 14,
                              width: 14,
                            ),
                            label: const Text('Apple', style: TextStyle(color: AppColors.textPrimary)),
                            onPressed: () {},
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

                    const SizedBox(height: 40),

                    // Login Link
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: AppColors.textSecondary),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5.0),

                  ],
                ),
              ),
            ),


            const SizedBox(height: 40),

            // Footer
            SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/shield_mark.png',
                    height: 15,
                    width: 12,
                  ),
                  const SizedBox(width: 6),
                  const Text('Bank-grade Security', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const SizedBox(width: 24),
                  const Icon(Icons.public, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  const Text('GDPR Compliant', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}