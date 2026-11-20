import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'composer_icon_button.dart';

/// Campo de mensagem com anexo, microfone e envio.
class MessageComposer extends StatefulWidget {
  const MessageComposer({super.key, required this.onSend});

  final ValueChanged<String> onSend;

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSizes.chatMaxWidth),
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                10,
                10,
                10,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(color: AppColors.borderStrong),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _submit(),
                      style: AppTextStyles.body,
                      decoration: const InputDecoration(
                        hintText: AppStrings.messageHint,
                        hintStyle: AppTextStyles.secondary,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  ComposerIconButton(
                    icon: Icons.attach_file,
                    tooltip: AppStrings.attachFile,
                    onPressed: () {},
                  ),
                  ComposerIconButton(
                    icon: Icons.mic_none,
                    tooltip: AppStrings.speak,
                    onPressed: () {},
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _controller,
                    builder: (context, value, _) => ComposerIconButton(
                      icon: Icons.arrow_upward,
                      tooltip: AppStrings.send,
                      filled: true,
                      onPressed:
                          value.text.trim().isEmpty ? null : _submit,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(AppStrings.localNotice, style: AppTextStyles.overline),
        ],
      ),
    );
  }
}
