import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class MessageActions extends StatelessWidget {
  const MessageActions({super.key, this.onCopy, this.onRegenerate});

  final VoidCallback? onCopy;
  final VoidCallback? onRegenerate;

  @override
  Widget build(BuildContext context) {
    final style = TextButton.styleFrom(
      foregroundColor: AppColors.textMuted,
      minimumSize: const Size(0, 32),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      textStyle: AppTextStyles.caption,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: AppStrings.copyAnswer,
          child: TextButton(
            onPressed: onCopy,
            style: style,
            child: const Text(AppStrings.copy),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Semantics(
          label: AppStrings.regenerateAnswer,
          child: TextButton(
            onPressed: onRegenerate,
            style: style,
            child: const Text(AppStrings.regenerate),
          ),
        ),
      ],
    );
  }
}
