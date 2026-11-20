import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Botão que mostra o modelo atual e o provedor (ex.: "Local · Ollama").
class ModelSelectorButton extends StatelessWidget {
  const ModelSelectorButton({
    super.key,
    required this.modelName,
    required this.providerLabel,
    required this.onPressed,
  });

  final String modelName;
  final String providerLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        minimumSize: const Size(0, AppSizes.controlHeight),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(modelName, style: AppTextStyles.label),
          const SizedBox(width: 10),
          Text(providerLabel, style: AppTextStyles.caption),
          const SizedBox(width: 10),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
