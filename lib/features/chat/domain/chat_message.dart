enum MessageRole { user, assistant }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    this.reasoning,
    this.reasoningDuration,
  });

  final String id;
  final MessageRole role;
  final String content;

  /// Texto de raciocínio do modelo (quando o modo de pensar está ligado).
  final String? reasoning;
  final Duration? reasoningDuration;

  ChatMessage copyWith({
    String? content,
    String? reasoning,
    Duration? reasoningDuration,
  }) {
    return ChatMessage(
      id: id,
      role: role,
      content: content ?? this.content,
      reasoning: reasoning ?? this.reasoning,
      reasoningDuration: reasoningDuration ?? this.reasoningDuration,
    );
  }
}
