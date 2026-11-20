import '../features/chat/domain/chat_message.dart';
import 'chat_event.dart';

/// Interface única para qualquer IA (Ollama agora; Claude e GPT depois).
abstract interface class AiProvider {
  String get label;

  /// Se o provedor consegue enviar o raciocínio separado da resposta.
  bool get supportsThinking;

  Future<List<String>> listModels();

  /// [system] é a instrução de sistema (quem o assistente é e o que sabe
  /// sobre o usuário). [messages] é o histórico da conversa.
  Stream<ChatEvent> chat({
    required String model,
    required List<ChatMessage> messages,
    String? system,
    bool think = false,
  });
}
