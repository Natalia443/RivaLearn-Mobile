import 'dart:convert';

import 'package:http/http.dart' as http;

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
