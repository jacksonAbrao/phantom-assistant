import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Interruptor do modo de pensar (liga/desliga o raciocínio do modelo).
class ThinkingToggle extends StatelessWidget {
  const ThinkingToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(AppStrings.thinkingMode, style: AppTextStyles.label),
          const SizedBox(width: 10),
          Switch(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            thumbColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? AppColors.onPrimary
                  : AppColors.textSecondary,
            ),
            trackColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? AppColors.primary
                  : AppColors.switchOffTrack,
            ),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 28,
            child: Text(
              value ? AppStrings.on : AppStrings.off,
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }
}
