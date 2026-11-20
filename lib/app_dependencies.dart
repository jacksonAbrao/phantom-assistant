import 'core/database/app_database.dart';
import 'features/chat/data/chat_repository.dart';
import 'features/chat/data/drift_chat_repository.dart';
import 'features/chat/data/in_memory_chat_repository.dart';
import 'features/memory/context/context_builder.dart';
import 'features/memory/context/fixed_notes_source.dart';
import 'features/memory/data/drift_memory_repository.dart';
import 'features/memory/data/in_memory_memory_repository.dart';
import 'features/memory/data/memory_repository.dart';

/// Reúne os serviços do app. Quando entrar o Riverpod, isto vira providers.
class AppDependencies {
  AppDependencies({
    required this.chatRepository,
    required this.memoryRepository,
  }) : contextBuilder = ContextBuilder(
          sources: [FixedNotesSource(memoryRepository)],
        );

  /// Versão de produção: tudo salvo no banco local.
  factory AppDependencies.local(AppDatabase database) => AppDependencies(
        chatRepository: DriftChatRepository(database),
        memoryRepository: DriftMemoryRepository(database),
      );

  /// Versão para testes: tudo em memória.
  factory AppDependencies.inMemory() => AppDependencies(
        chatRepository: InMemoryChatRepository(),
        memoryRepository: InMemoryMemoryRepository(),
      );

  final ChatRepository chatRepository;
  final MemoryRepository memoryRepository;
  final ContextBuilder contextBuilder;
}
