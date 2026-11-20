import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phantom_assistant/app.dart';
import 'package:phantom_assistant/app_dependencies.dart';

void main() {
  testWidgets('renderiza a tela inicial do Phantom', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      PhantomApp(dependencies: AppDependencies.inMemory()),
    );
    await tester.pump();

    expect(find.text('Phantom'), findsOneWidget);
    expect(find.text('Nova conversa'), findsOneWidget);
    expect(find.text('Modo de pensar'), findsOneWidget);
    expect(find.text('Memória: vazia'), findsOneWidget);
  });
}
