import 'package:flutter/material.dart';
import 'package:phantom_assistant/core/theme/app_colors.dart';
import 'package:phantom_assistant/features/chat/ui/widgets/phantom_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Center(
          child: PhantomLogo(
            size: 100,
          ),
        ),
      ),
    );
  }
}
