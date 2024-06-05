import 'dart:convert';
import 'package:flutter_application_1/entities/entities.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://rivalearn-backend.onrender.com/api/lib/';

Future<List<Book>> fetchBooks(String code) async {
  final response = await http.get(Uri.parse('$baseUrl/books?code=$code'),
      headers: {'Accept': 'application/json'});
  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        json.decode(utf8.decode(response.bodyBytes));
    if (data.containsKey('results')) {
      final List<dynamic> booksData = data['results'];
      return booksData.map((json) => Book.fromJson(json)).toList();
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
