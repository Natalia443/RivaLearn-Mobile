import 'dart:convert';

import 'package:flutter_application_1/entities/entities.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://rivalearn-backend.onrender.com/api/decks';

Future<List<Deck>> getDecks(String id) async {
  final response = await http.get(Uri.parse('$baseUrl/get/$id'));

  if (response.statusCode == 200) {
    final List<dynamic> list = jsonDecode(response.body);
    final decks = list.map((json) => Deck.fromJson(json)).toList();
    return decks;
  } else {
    throw Exception('Error al cargar los datos');
  }
}

Future<void> createDeck(String id, String deckName) async {
  const url = '$baseUrl/create';

  try {
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': id,
        'deckname': deckName,
      }),
    );
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
