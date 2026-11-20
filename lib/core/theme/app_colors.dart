import 'package:flutter/material.dart';

/// Paleta do Phantom (tema Gengar: roxo escuro).
/// Todas as cores do app saem daqui; nenhum widget usa hex direto.
abstract final class AppColors {
  // Fundos
  static const background = Color(0xFF14111C);
  static const surface = Color(0xFF1A1625);
  static const surfaceElevated = Color(0xFF2A2240);

  // Bordas
  static const border = Color(0xFF2E2640);
  static const borderStrong = Color(0xFF3A3150);

  // Marca
  static const primary = Color(0xFF7C3AED);
  static const primaryLight = Color(0xFFA78BFA);
  static const onPrimary = Color(0xFFFFFFFF);

  // Texto
  static const textPrimary = Color(0xFFECE8F5);
  static const textSecondary = Color(0xFFCFC8DE);
  static const textMuted = Color(0xFF9A90B0);

  // Estados
  static const success = Color(0xFF4ADE80);
  static const switchOffTrack = Color(0xFF3A3150);
}
