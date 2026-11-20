import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SidebarSectionLabel extends StatelessWidget {
  const SidebarSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Text(text, style: AppTextStyles.overline),
    );
  }
}
