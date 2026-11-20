import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Indicador do Ollama (a cor nunca é a única informação: há texto).
class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({super.key, required this.connected});

  final bool connected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: connected ? AppColors.success : AppColors.textMuted,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          connected
              ? AppStrings.ollamaConnected
              : AppStrings.ollamaDisconnected,
          style: AppTextStyles.secondary.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}
