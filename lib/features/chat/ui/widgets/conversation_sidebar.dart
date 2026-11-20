import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/conversation.dart';
import 'connection_status.dart';
import 'conversation_tile.dart';
import 'phantom_logo.dart';
import 'sidebar_section_label.dart';

class ConversationSidebar extends StatelessWidget {
  const ConversationSidebar({
    super.key,
    required this.groups,
    required this.selectedId,
    required this.onSelect,
    required this.onNewChat,
    required this.onOpenSettings,
    this.ollamaConnected = true,
  });

  final List<ConversationGroup> groups;
  final String? selectedId;
  final ValueChanged<String> onSelect;
  final VoidCallback onNewChat;
  final VoidCallback onOpenSettings;
  final bool ollamaConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.sidebarWidth,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg + AppSizes.titleBarInset,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              children: [
                PhantomLogo(),
                SizedBox(width: 10),
                Text(AppStrings.appName, style: AppTextStyles.title),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            onPressed: onNewChat,
            icon: const Icon(Icons.add, size: 16),
            label: const Text(AppStrings.newChat),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              minimumSize: const Size.fromHeight(AppSizes.controlHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              textStyle: AppTextStyles.label,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _SearchField(),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView(
              children: [
                for (final group in groups) ...[
                  SidebarSectionLabel(group.label),
                  for (final conversation in group.conversations)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: ConversationTile(
                        title: conversation.title,
                        selected: conversation.id == selectedId,
                        onTap: () => onSelect(conversation.id),
                      ),
                    ),
                ],
              ],
            ),
          ),
          const Divider(height: AppSpacing.xl, color: AppColors.border),
          ConnectionStatus(connected: ollamaConnected),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: onOpenSettings,
            icon: const Icon(Icons.settings_outlined, size: 18),
            label: const Align(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.settings),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              alignment: Alignment.centerLeft,
              minimumSize: const Size.fromHeight(AppSizes.controlHeight),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              textStyle: AppTextStyles.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.border),
    );

    return SizedBox(
      height: AppSizes.controlHeight,
      child: TextField(
        style: AppTextStyles.body,
        decoration: InputDecoration(
          hintText: AppStrings.searchChats,
          hintStyle: AppTextStyles.secondary.copyWith(
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.background,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          enabledBorder: border(),
          focusedBorder: border().copyWith(
            borderSide: const BorderSide(color: AppColors.primaryLight),
          ),
        ),
      ),
    );
  }
}
