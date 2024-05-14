import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> fetchMeaning(String text, String lang) async {
  final response = await http.get(Uri.parse(
      'https://rivalearn-backend.onrender.com/api/dict/meaning?text=$text&language=$lang'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> results = responseData['results'];
    List<String> definitions = [];

    for (var result in results) {
      final List<dynamic> senses = result['senses'];
      for (var sense in senses) {
        final String definition = sense['definition'];
        definitions.add(definition);
      }
    }

    return definitions;
  } else {
    throw Exception('Error al cargar los datos');
  }
}
