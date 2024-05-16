import 'dart:convert';

import 'package:flutter_application_1/entities/book.dart';
import 'package:http/http.dart' as http;

class BooksDataSource {
  static Future<List<Book>> fetchBooks(String code) async {
    final url =
        'https://rivalearn-backend.onrender.com/api/lib/books?code=$code';

    final response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});

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

  static Future<String> fetchText(String url) async {
    final fetchTextUrl =
        'https://rivalearn-backend.onrender.com/api/lib/text?url=$url';
    final response = await http.get(Uri.parse(fetchTextUrl));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load book text');
    }
  }
}
