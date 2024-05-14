import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> getDecks(String user) async {
  final response = await http.get(
      Uri.parse('https://rivalearn-backend.onrender.com/api/decks/get/$user'));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);
    List<String> decks = [];

    for (var deck in responseData) {
      decks.add(deck);
    }

    return decks;
  } else {
    throw Exception('Error al cargar los datos');
  }
}

Future<void> createDeck(String username, String deckName) async {
  const url = 'https://rivalearn-backend.onrender.com/api/decks/create';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
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
