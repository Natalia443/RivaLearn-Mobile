import 'package:flutter_application_1/core/data/gemini_datasource.dart';
import 'package:flutter_application_1/entities/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatAIProvider = AsyncNotifierProvider<GeminiNotifier, List<ChatMessage>>(
    GeminiNotifier.new);

class GeminiNotifier extends AsyncNotifier<List<ChatMessage>> {
  @override
  List<ChatMessage> build() =>
      [ChatMessage(message: '¡Hola! ¿En qué puedo ayudarte?', isUser: false)];

  Future<void> send(String message) async {
    final currentMessages = await future;
    currentMessages.add(
      ChatMessage(message: message, isUser: true),
    );
    state = AsyncValue.data([...currentMessages]);

    final candidates = await chat(message, currentMessages);
    final response = candidates;
    state = AsyncValue.data([
      ...currentMessages,
      ChatMessage(
        message: response,
        isUser: false,
      ),
    ]);
  }
}
