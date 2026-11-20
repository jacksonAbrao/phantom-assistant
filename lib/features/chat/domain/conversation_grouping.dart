import 'conversation.dart';

/// Agrupa as conversas (já ordenadas da mais recente) em Hoje, Ontem e Anteriores.
List<ConversationGroup> groupConversationsByDay(
  List<Conversation> conversations, {
  DateTime? now,
}) {
  final reference = now ?? DateTime.now();
  final today = DateTime(reference.year, reference.month, reference.day);
  final yesterday = DateTime(today.year, today.month, today.day - 1);

  final groups = <String, List<Conversation>>{
    'Hoje': [],
    'Ontem': [],
    'Anteriores': [],
  };

  for (final conversation in conversations) {
    final date = conversation.updatedAt;
    final day = DateTime(date.year, date.month, date.day);
    if (day == today) {
      groups['Hoje']!.add(conversation);
    } else if (day == yesterday) {
      groups['Ontem']!.add(conversation);
    } else {
      groups['Anteriores']!.add(conversation);
    }
  }

  return [
    for (final entry in groups.entries)
      if (entry.value.isNotEmpty)
        ConversationGroup(label: entry.key, conversations: entry.value),
  ];
}
