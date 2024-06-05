import 'dart:convert';

import 'package:flutter_application_1/entities/entities.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://rivalearn-backend.onrender.com/api/quiz';

Future<Stats> getStats(String userId) async {
  final url = Uri.parse('$baseUrl/get/$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final list = jsonDecode(response.body);
    try {
      final stats = Stats.fromJson(list[0]);
      return stats;
    } catch (e) {
      throw Exception('Error al serializar estaditicas');
    }
  } else {
    throw Exception('Error al cargar estadísticas');
  }
}

Future<void> saveStats(Stats stats) async {
  const url = "$baseUrl/stats";
  try {
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(stats.toJson()),
    );
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
