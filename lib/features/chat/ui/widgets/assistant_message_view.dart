import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../domain/chat_message.dart';
import 'message_actions.dart';
import 'reasoning_chip.dart';

class AssistantMessageView extends StatelessWidget {
  const AssistantMessageView({
    super.key,
    required this.message,
    this.onCopy,
    this.onRegenerate,
  });

  final ChatMessage message;
  final VoidCallback? onCopy;
  final VoidCallback? onRegenerate;

  @override
  Widget build(BuildContext context) {
    final reasoning = message.reasoning;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (reasoning != null) ...[
          ReasoningChip(
            reasoning: reasoning,
            duration: message.reasoningDuration,
          ),
          const SizedBox(height: 10),
        ],
        // SelectionArea mantém o texto selecionável e copiável.
        SelectionArea(
          child: GptMarkdown(
            message.content,
            style: AppTextStyles.assistantBody,
          ),
        ),
        const SizedBox(height: 10),
        MessageActions(onCopy: onCopy, onRegenerate: onRegenerate),
      ],
    );
  }
}
