class Conversation {
  const Conversation({
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final DateTime updatedAt;
}

/// Conversas agrupadas por período ("Hoje", "Ontem"...).
class ConversationGroup {
  const ConversationGroup({required this.label, required this.conversations});

  final String label;
  final List<Conversation> conversations;
}
