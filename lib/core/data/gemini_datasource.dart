import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/entities/entities.dart';

const baseUrl = 'https://rivalearn-backend.onrender.com/api/gemini';

Future<String> getStory(List<dynamic> words) async {
  const url = '$baseUrl/story';

  try {
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'words': words}));
    return response.body;
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}

Future<String> chat(String message, List<ChatMessage> history) async {
  const url = '$baseUrl/chat';
  final formattedHistory = createHistory(history);
  try {
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': message,
          'history': formattedHistory,
        }));
    return response.body.replaceAll('"', '');
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}

List<Map<String, dynamic>> createHistory(List<ChatMessage> history) {
  List<ChatMessage> filteredHistory = history.skip(1).toList();
  return filteredHistory
      .map((msg) => {
            'role': msg.isUser ? 'user' : 'model',
            'parts': [
              {'text': msg.message}
            ],
          })
      .toList();
}
