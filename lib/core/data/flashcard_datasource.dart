import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> getFlashcards(String deck) async {
  final res = await http.get(Uri.parse(
      'https://rivalearn-backend.onrender.com/api/flashcards/get/$deck'));

  if (res.statusCode == 200) {
    final List<dynamic> resData = jsonDecode(res.body);
    return resData;
  } else {
    throw Exception('Error al cargar los datos de flashcard');
  }
}

Future<void> createFlashcard(String deckName, String flashcard,
    String sourceLang, String targetLang) async {
  const url = "https://rivalearn-backend.onrender.com/api/flashcards/create";

  try {
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'deckname': deckName,
        'vocab': flashcard,
        'sourceLang': sourceLang,
        'targetLang': targetLang
      }),
    );
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
