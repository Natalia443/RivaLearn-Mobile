import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'https://rivalearn-backend.onrender.com/api/decks';

Future<List<dynamic>> getDecks(String id) async {
  final response = await http.get(Uri.parse('$baseUrl/get/$id'));

  if (response.statusCode == 200) {
    final List<dynamic> resData = jsonDecode(response.body);
    return resData;
  } else {
    throw Exception('Error al cargar los datos');
  }
}

Future<void> createDeck(String id, String deckName) async {
  const url = '$baseUrl/create';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': id,
        'deckname': deckName,
      }),
    );

    if (response.statusCode == 200) {
      print('Deck guardado exitosamente');
    } else {
      throw Exception('Error al guardar el deck: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
