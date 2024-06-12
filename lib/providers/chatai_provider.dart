import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatAIProvider = AsyncNotifierProvider<GeminiNotifier, List<ChatMessage>>(
    GeminiNotifier.new);

class GeminiNotifier extends AsyncNotifier<List<ChatMessage>> {
  @override
  List<ChatMessage> build() =>
      [ChatMessage(message: 'Hola bro, en que te ayudo?', isUser: false)];

  Future<void> send(String message) async {
    final currentMessages = await future;
    currentMessages.add(
      ChatMessage(message: message, isUser: true),
    );
    state = AsyncValue.data([...currentMessages]);

    final candidates = await Gemini.instance.text(message);
    final response = candidates?.output ?? 'Sin respuesta';
    state = AsyncValue.data([
      ...currentMessages,
      ChatMessage(
        message: response,
        isUser: false,
      ),
    ]);
  }
}

class ChatMessage {
  final String message;
  final bool isUser;

  ChatMessage({
    required this.message,
    required this.isUser,
  });
}
