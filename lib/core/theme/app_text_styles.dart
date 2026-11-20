import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Estilos de texto reutilizáveis.
abstract final class AppTextStyles {
  static const title = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const assistantBody = TextStyle(
    fontSize: 14,
    height: 1.6,
    color: AppColors.textPrimary,
  );

  static const label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const secondary = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const caption = TextStyle(
    fontSize: 13,
    color: AppColors.textMuted,
  );

  static const overline = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );
}
