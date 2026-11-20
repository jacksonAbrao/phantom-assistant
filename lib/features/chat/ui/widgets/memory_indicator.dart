import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Mostra quantas notas a memória tem; clicar abre o gerenciador de notas.
class MemoryIndicator extends StatelessWidget {
  const MemoryIndicator({
    super.key,
    required this.noteCount,
    required this.onPressed,
  });

  final int noteCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textSecondary,
        minimumSize: const Size(0, AppSizes.controlHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        textStyle: AppTextStyles.secondary.copyWith(fontSize: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
      ),
      child: Text(AppStrings.memoryLabel(noteCount)),
    );
  }
}
