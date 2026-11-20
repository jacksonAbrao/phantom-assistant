import 'package:drift/drift.dart';

@DataClassName('ConversationRow')
class Conversations extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MessageRow')
class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get conversationId =>
      text().references(Conversations, #id, onDelete: KeyAction.cascade)();

  /// Posição da mensagem na conversa (0, 1, 2...). Define a ordem.
  IntColumn get position => integer()();

  /// 'user' ou 'assistant'.
  TextColumn get role => text()();
  TextColumn get content => text()();
  TextColumn get reasoning => text().nullable()();
  IntColumn get reasoningMs => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Notas fixas sobre o usuário, enviadas em toda conversa.
@DataClassName('NoteRow')
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get content => text()();

  /// 'manual' (escrita pelo usuário) ou, no futuro, 'auto'.
  TextColumn get source => text().withDefault(const Constant('manual'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
