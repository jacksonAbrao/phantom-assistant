import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_dependencies.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/ids.dart';
import '../../../providers/ai_provider.dart';
import '../../../providers/chat_event.dart';
import '../../../providers/ollama/ollama_provider.dart';
import '../../memory/domain/memory_note.dart';
import '../../memory/ui/notes_dialog.dart';
import '../domain/chat_message.dart';
import '../domain/conversation.dart';
import '../domain/conversation_grouping.dart';
import 'widgets/chat_header.dart';
import 'widgets/conversation_sidebar.dart';
import 'widgets/message_composer.dart';
import 'widgets/message_list.dart';

/// Tela inicial do Phantom: conversas salvas e memória de notas fixas.
///
/// O estado ainda é local. Quando entrar o Riverpod, a lógica de `_send`
/// e das conversas migra para um ViewModel.
class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const _model = 'qwen3.5:4b';

  final AiProvider _provider = OllamaProvider();

  StreamSubscription<ChatEvent>? _generation;
  StreamSubscription<List<Conversation>>? _conversationsSubscription;
  StreamSubscription<List<MemoryNote>>? _notesSubscription;

  List<Conversation> _conversations = const [];
  int _noteCount = 0;
  final List<ChatMessage> _messages = [];
  String? _selectedId;

  bool _thinkingEnabled = false;
  bool _generating = false;
  String? _generatingConversationId;
  String? _generatingMessageId;

  @override
  void initState() {
    super.initState();
    _conversationsSubscription = widget.dependencies.chatRepository
        .watchConversations()
        .listen((conversations) {
          if (mounted) setState(() => _conversations = conversations);
        });
    _notesSubscription = widget.dependencies.memoryRepository
        .watchNotes()
        .listen((notes) {
          if (mounted) setState(() => _noteCount = notes.length);
        });
  }

  @override
  void dispose() {
    _generation?.cancel();
    _conversationsSubscription?.cancel();
    _notesSubscription?.cancel();
    super.dispose();
  }

  String _titleFrom(String text) {
    final firstLine = text.trim().split('\n').first;
    return firstLine.length <= 40
        ? firstLine
        : '${firstLine.substring(0, 40)}…';
  }

  Future<void> _send(String text) async {
    if (_generating) return;

    final repository = widget.dependencies.chatRepository;
    final conversationId =
        _selectedId ?? await repository.createConversation(_titleFrom(text));
    if (!mounted) return;

    final userMessage = ChatMessage(
      id: newId(),
      role: MessageRole.user,
      content: text,
    );
    final assistantMessage = ChatMessage(
      id: newId(),
      role: MessageRole.assistant,
      content: '',
    );

    final history = [..._messages, userMessage];
    final userPosition = _messages.length;

    setState(() {
      _selectedId = conversationId;
      _messages
        ..add(userMessage)
        ..add(assistantMessage);
      _generating = true;
      _generatingConversationId = conversationId;
      _generatingMessageId = assistantMessage.id;
    });

    await repository.saveMessage(
      conversationId,
      userMessage,
      position: userPosition,
    );

    // Notas da memória + últimas mensagens da conversa.
    final built = await widget.dependencies.contextBuilder.build(
      history: history,
      question: text,
    );
    if (!mounted) return;

    final assistantId = assistantMessage.id;
    final stopwatch = Stopwatch()..start();
    Duration? reasoningTime;
    var failed = false;

    _generation = _provider
        .chat(
          model: _model,
          messages: built.messages,
          system: built.system,
          think: _thinkingEnabled,
        )
        .listen(
          (event) {
            switch (event) {
              case ThinkingDelta(:final text):
                _updateMessage(
                  assistantId,
                  (m) => m.copyWith(reasoning: (m.reasoning ?? '') + text),
                );
              case ContentDelta(:final text):
                // O primeiro pedaço da resposta marca o fim do raciocínio.
                reasoningTime ??= stopwatch.elapsed;
                _updateMessage(
                  assistantId,
                  (m) => m.copyWith(
                    content: m.content + text,
                    reasoningDuration: m.reasoning != null
                        ? reasoningTime
                        : null,
                  ),
                );
              case ChatFailure(:final message):
                failed = true;
                _updateMessage(
                  assistantId,
                  (m) => m.copyWith(content: message),
                );
              case ChatDone():
                break;
            }
          },
          onDone: () async {
            _generation = null;
            // Erros aparecem na tela, mas não entram no histórico salvo.
            if (!failed) await _persistAssistantMessage();
            if (mounted) setState(() => _generating = false);
          },
        );
  }

  void _updateMessage(String id, ChatMessage Function(ChatMessage) update) {
    if (!mounted) return;
    setState(() {
      final index = _messages.indexWhere((m) => m.id == id);
      if (index != -1) _messages[index] = update(_messages[index]);
    });
  }

  /// Salva a resposta do assistente (inteira ou parcial).
  Future<void> _persistAssistantMessage() async {
    final conversationId = _generatingConversationId;
    final messageId = _generatingMessageId;
    if (conversationId == null || messageId == null) return;

    final index = _messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;

    final message = _messages[index];
    if (message.content.isEmpty && message.reasoning == null) return;

    await widget.dependencies.chatRepository.saveMessage(
      conversationId,
      message,
      position: index,
    );
  }

  /// Interrompe a geração em andamento, guardando o que já chegou.
  Future<void> _stopGeneration() async {
    final subscription = _generation;
    if (subscription == null) return;
    _generation = null;
    await subscription.cancel();
    await _persistAssistantMessage();
    if (mounted) setState(() => _generating = false);
  }

  Future<void> _openConversation(String id) async {
    if (id == _selectedId) return;
    await _stopGeneration();
    final messages = await widget.dependencies.chatRepository.loadMessages(id);
    if (!mounted) return;
    setState(() {
      _selectedId = id;
      _messages
        ..clear()
        ..addAll(messages);
    });
  }

  Future<void> _newChat() async {
    await _stopGeneration();
    if (!mounted) return;
    setState(() {
      _selectedId = null;
      _messages.clear();
    });
  }

  void _openMemory() {
    showDialog<void>(
      context: context,
      builder: (_) => NotesDialog(
        repository: widget.dependencies.memoryRepository,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ConversationSidebar(
            groups: groupConversationsByDay(_conversations),
            selectedId: _selectedId,
            onSelect: _openConversation,
            onNewChat: _newChat,
            onOpenSettings: () {},
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: AppSizes.titleBarInset),
                ChatHeader(
                  modelName: _model,
                  providerLabel: _provider.label,
                  noteCount: _noteCount,
                  thinkingEnabled: _thinkingEnabled,
                  onThinkingChanged: (value) =>
                      setState(() => _thinkingEnabled = value),
                  onSelectModel: () {},
                  onOpenMemory: _openMemory,
                ),
                Expanded(
                  child: MessageList(
                    messages: _messages,
                    conversationId: _selectedId,
                  ),
                ),
                MessageComposer(onSend: _send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
