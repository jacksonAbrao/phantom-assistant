import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class ComposerIconButton extends StatelessWidget {
  const ComposerIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.filled = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  /// Botão de destaque (enviar).
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: filled ? 18 : 20),
      style: IconButton.styleFrom(
        fixedSize: const Size.square(AppSizes.controlHeight),
        backgroundColor: filled ? AppColors.primary : Colors.transparent,
        foregroundColor:
            filled ? AppColors.onPrimary : AppColors.textSecondary,
        disabledBackgroundColor:
            filled ? AppColors.borderStrong : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }
}
