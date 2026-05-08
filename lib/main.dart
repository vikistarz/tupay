import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/ui/dashboard_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/widget/privacy_overlay.dart';
import 'featues/auth/presentation/screen/signUp/signup_screen.dart';


void main() {
  runApp(const ProviderScope(child: TuPayApp()));
}

class TuPayApp extends StatelessWidget {
  const TuPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TuPay',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const PrivacyOverlay(
        child: SignupScreen(),
      ),
    );
  }
}

