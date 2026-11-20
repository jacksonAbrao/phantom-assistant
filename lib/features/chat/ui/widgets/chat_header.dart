import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'memory_indicator.dart';
import 'model_selector_button.dart';
import 'thinking_toggle.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.modelName,
    required this.providerLabel,
    required this.noteCount,
    required this.thinkingEnabled,
    required this.onThinkingChanged,
    required this.onSelectModel,
    required this.onOpenMemory,
  });

  final String modelName;
  final String providerLabel;
  final int noteCount;
  final bool thinkingEnabled;
  final ValueChanged<bool> onThinkingChanged;
  final VoidCallback onSelectModel;
  final VoidCallback onOpenMemory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          ModelSelectorButton(
            modelName: modelName,
            providerLabel: providerLabel,
            onPressed: onSelectModel,
          ),
          const Spacer(),
          MemoryIndicator(noteCount: noteCount, onPressed: onOpenMemory),
          const SizedBox(width: AppSpacing.md),
          ThinkingToggle(
            value: thinkingEnabled,
            onChanged: onThinkingChanged,
          ),
        ],
      ),
    );
  }
}
