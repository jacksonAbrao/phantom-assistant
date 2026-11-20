/// Textos da interface em um só lugar (facilita trocar o nome ou traduzir).
abstract final class AppStrings {
  static const appName = 'Phantom';

  // Barra lateral
  static const newChat = 'Nova conversa';
  static const searchChats = 'Buscar conversas';
  static const conversations = 'Conversas';
  static const ollamaConnected = 'Ollama conectado';
  static const ollamaDisconnected = 'Ollama desconectado';
  static const settings = 'Configurações';

  // Cabeçalho
  static const thinkingMode = 'Modo de pensar';
  static const on = 'On';
  static const off = 'Off';

  static String memoryLabel(int count) => switch (count) {
    0 => 'Memória: vazia',
    1 => 'Memória: 1 nota',
    _ => 'Memória: $count notas',
  };

  // Mensagens
  static const reasoning = 'Raciocínio';
  static const copy = 'Copiar';
  static const regenerate = 'Gerar de novo';
  static const copyAnswer = 'Copiar resposta';
  static const regenerateAnswer = 'Gerar novamente';

  // Campo de mensagem
  static const messageHint = 'Pergunte ou peça algo ao Phantom';
  static const message = 'Mensagem';
  static const attachFile = 'Anexar arquivo';
  static const speak = 'Falar';
  static const send = 'Enviar';
  static const localNotice = 'Rodando localmente. Nada sai do seu Mac.';

  // Memória (notas fixas)
  static const memoryTitle = 'Memória';
  static const memoryDescription =
      'Fatos que o Phantom lembra em todas as conversas. Eles vão junto de '
      'cada pergunta, então prefira notas curtas.';
  static const noteHint = 'Ex.: Prefiro respostas curtas e diretas';
  static const addNote = 'Adicionar';
  static const saveNote = 'Salvar';
  static const cancel = 'Cancelar';
  static const editNote = 'Editar nota';
  static const deleteNote = 'Apagar nota';
  static const close = 'Fechar';
  static const noNotes =
      'Nenhuma nota ainda. Adicione fatos sobre você para o Phantom lembrar.';
}
