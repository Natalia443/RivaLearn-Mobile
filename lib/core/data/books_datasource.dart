import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = 'https://rivalearn-backend.onrender.com/api/lib/';

Future<List<Map<String, dynamic>>> fetchBooks(String code) async {
  final response = await http.get(Uri.parse('$baseUrl/books?code=$code'),
      headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        json.decode(utf8.decode(response.bodyBytes));
    if (data.containsKey('results')) {
      final List<dynamic> booksData = data['results'];
      return booksData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('No books found for the specified language');
    }
  } else {
    throw Exception('Failed to load books');
  }
}

Future<String> fetchText(String url) async {
  final response = await http.get(Uri.parse('$baseUrl/text?url=$url'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load book text');
  }
}
