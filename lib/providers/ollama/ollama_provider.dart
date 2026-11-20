import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../features/chat/domain/chat_message.dart';
import '../ai_provider.dart';
import '../chat_event.dart';

/// Conversa com o Ollama local pela API HTTP (http://127.0.0.1:11434).
class OllamaProvider implements AiProvider {
  OllamaProvider({
    http.Client? client,
    this.baseUrl = 'http://127.0.0.1:11434',
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  @override
  String get label => 'Local · Ollama';

  @override
  bool get supportsThinking => true;

  @override
  Future<List<String>> listModels() async {
    final response = await _client.get(Uri.parse('$baseUrl/api/tags'));
    if (response.statusCode != 200) {
      throw HttpException('Ollama respondeu ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final models = (json['models'] as List<dynamic>? ?? const []);
    return [
      for (final model in models)
        (model as Map<String, dynamic>)['name'] as String,
    ];
  }

  @override
  Stream<ChatEvent> chat({
    required String model,
    required List<ChatMessage> messages,
    String? system,
    bool think = false,
  }) async* {
    final request = http.Request('POST', Uri.parse('$baseUrl/api/chat'))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'model': model,
        'messages': [
          if (system != null && system.isNotEmpty)
            {'role': 'system', 'content': system},
          for (final m in messages) {'role': m.role.name, 'content': m.content},
        ],
        'stream': true,
        'think': think,
      });

    try {
      final response = await _client.send(request);

      if (response.statusCode != 200) {
        final body = await response.stream.bytesToString();
        yield ChatFailure(_friendlyError(response.statusCode, body, model));
        return;
      }

      // A resposta chega em linhas JSON (uma por pedaço).
      final lines = response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in lines) {
        if (line.trim().isEmpty) continue;

        final json = jsonDecode(line) as Map<String, dynamic>;

        if (json['error'] != null) {
          yield ChatFailure(json['error'].toString());
          return;
        }

        final message = json['message'] as Map<String, dynamic>?;
        final thinking = message?['thinking'] as String?;
        final content = message?['content'] as String?;

        if (thinking != null && thinking.isNotEmpty) {
          yield ThinkingDelta(thinking);
        }
        if (content != null && content.isNotEmpty) {
          yield ContentDelta(content);
        }
        if (json['done'] == true) {
          yield const ChatDone();
          return;
        }
      }
      yield const ChatDone();
    } on SocketException {
      yield const ChatFailure(
        'Não consegui falar com o Ollama. Confira se o app está aberto.',
      );
    } on http.ClientException {
      yield const ChatFailure(
        'Não consegui falar com o Ollama. Confira se o app está aberto.',
      );
    } catch (error) {
      yield ChatFailure('Erro inesperado: $error');
    }
  }

  String _friendlyError(int status, String body, String model) {
    if (status == 404) {
      return 'Modelo "$model" não encontrado. Rode: ollama pull $model';
    }
    return 'O Ollama respondeu $status: $body';
  }
}
