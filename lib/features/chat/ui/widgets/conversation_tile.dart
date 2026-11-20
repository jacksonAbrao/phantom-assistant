import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.sm);

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.surfaceElevated : Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: SizedBox(
            height: AppSizes.controlHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: selected
                      ? AppTextStyles.body
                      : AppTextStyles.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
