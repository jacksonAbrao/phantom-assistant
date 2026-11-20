import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Conversations, Messages, Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      // v1 -> v2: tabela de notas da memória.
      if (from < 2) await migrator.createTable(notes);
    },
    beforeOpen: (details) async {
      // Faz o "apagar conversa" levar as mensagens junto.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Arquivo local: phantom.sqlite, na pasta de suporte do app (fora do projeto).
  static QueryExecutor _open() {
    return driftDatabase(
      name: 'phantom',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
