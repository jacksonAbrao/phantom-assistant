import 'package:flutter/material.dart';

import 'app_dependencies.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/chat/ui/chat_page.dart';

class PhantomApp extends StatelessWidget {
  const PhantomApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: ChatPage(dependencies: dependencies),
    );
  }
}
