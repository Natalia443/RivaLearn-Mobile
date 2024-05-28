import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'https://rivalearn-backend.onrender.com/api/quiz';

Future<Map<String, dynamic>> getStats(String userId) async {
  final url = Uri.parse('$baseUrl/get/$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error al cargar estadísticas');
  }
}

Future<void> saveStats(String userId, int success, int total) async {
  const url = "$baseUrl/stats";
  try {
    await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'userId': userId, 'success': success, 'total': total}));
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
