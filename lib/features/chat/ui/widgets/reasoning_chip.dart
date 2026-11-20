import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Pílula recolhida com o raciocínio do modelo; abre ao clicar.
class ReasoningChip extends StatefulWidget {
  const ReasoningChip({super.key, required this.reasoning, this.duration});

  final String reasoning;
  final Duration? duration;

  @override
  State<ReasoningChip> createState() => _ReasoningChipState();
}

class _ReasoningChipState extends State<ReasoningChip> {
  bool _open = false;

  String get _label {
    final seconds = widget.duration?.inSeconds;
    return seconds == null
        ? AppStrings.reasoning
        : '${AppStrings.reasoning} · $seconds s';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: () => setState(() => _open = !_open),
          icon: Icon(
            _open ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
            size: 14,
          ),
          label: Text(_label),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textMuted,
            side: const BorderSide(color: AppColors.border),
            minimumSize: const Size(0, 32),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            textStyle: AppTextStyles.caption,
            shape: const StadiumBorder(),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.topLeft,
          child: _open
              ? Container(
                  margin: const EdgeInsets.only(top: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: SelectableText(
                    widget.reasoning,
                    style: AppTextStyles.caption.copyWith(height: 1.5),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
