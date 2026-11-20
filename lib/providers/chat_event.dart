/// Eventos que um provedor de IA emite durante uma resposta (em stream).
sealed class ChatEvent {
  const ChatEvent();
}

/// Pedaço do raciocínio do modelo (modo de pensar).
class ThinkingDelta extends ChatEvent {
  const ThinkingDelta(this.text);
  final String text;
}

/// Pedaço da resposta final.
class ContentDelta extends ChatEvent {
  const ContentDelta(this.text);
  final String text;
}

/// Fim da resposta.
class ChatDone extends ChatEvent {
  const ChatDone();
}

/// Algo deu errado (Ollama fechado, modelo inexistente etc.).
class ChatFailure extends ChatEvent {
  const ChatFailure(this.message);
  final String message;
}
