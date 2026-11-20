import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/chat_message.dart';
import 'assistant_message_view.dart';
import 'user_message_bubble.dart';

class MessageList extends StatefulWidget {
  const MessageList({
    super.key,
    required this.messages,
    this.conversationId,
    this.onCopy,
    this.onRegenerate,
  });

  final List<ChatMessage> messages;

  /// Quando muda, a lista pula para o fim (ao abrir outra conversa).
  final String? conversationId;
  final ValueChanged<ChatMessage>? onCopy;
  final ValueChanged<ChatMessage>? onRegenerate;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  /// Distância do fim (em pixels) que ainda conta como "estou no fim".
  static const _bottomThreshold = 48.0;

  final _controller = ScrollController();
  bool _stickToBottom = true;
  bool _scrollScheduled = false;
  bool _programmaticScroll = false;
  int _lastCount = 0;

  @override
  void initState() {
    super.initState();
    _lastCount = widget.messages.length;
    _scheduleScrollToBottom();
  }

  @override
  void didUpdateWidget(covariant MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final conversationChanged =
        widget.conversationId != oldWidget.conversationId;
    final newMessage = widget.messages.length > _lastCount;
    _lastCount = widget.messages.length;

    // Nova conversa ou nova pergunta: volta a seguir o fim.
    if (conversationChanged || newMessage) _stickToBottom = true;
    if (_stickToBottom) _scheduleScrollToBottom();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Agenda um único pulo para o fim, depois que o frame atual for montado.
  void _scheduleScrollToBottom() {
    if (_scrollScheduled) return;
    _scrollScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollScheduled = false;
      if (!mounted || !_stickToBottom || !_controller.hasClients) return;

      final position = _controller.position;
      if (position.pixels >= position.maxScrollExtent) return;

      _programmaticScroll = true;
      _controller.jumpTo(position.maxScrollExtent);
      _programmaticScroll = false;
    });
  }

  /// Se a pessoa rolou para longe do fim, para de seguir; se voltou, segue.
  bool _onScroll(ScrollNotification notification) {
    if (_programmaticScroll || notification.depth != 0) return false;
    if (notification is ScrollUpdateNotification) {
      _stickToBottom = notification.metrics.extentAfter < _bottomThreshold;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizes.chatMaxWidth),
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: ListView.separated(
            controller: _controller,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xxl,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            itemCount: widget.messages.length,
            separatorBuilder: (_, __) => const SizedBox(height: 22),
            itemBuilder: (context, index) {
              final message = widget.messages[index];
              return switch (message.role) {
                MessageRole.user => UserMessageBubble(text: message.content),
                MessageRole.assistant => AssistantMessageView(
                  message: message,
                  onCopy: widget.onCopy == null
                      ? null
                      : () => widget.onCopy!(message),
                  onRegenerate: widget.onRegenerate == null
                      ? null
                      : () => widget.onRegenerate!(message),
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}
