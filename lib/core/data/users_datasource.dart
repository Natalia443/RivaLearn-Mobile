import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> saveUser(String username, String password, String email) async {
  const url = 'https://rivalearn-backend.onrender.com/api/users/signup';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('Usuario guardado exitosamente');
    } else {
      throw Exception('Error al guardar el usuario: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}

Future<Map<String, String>> loginUser(String username, String password) async {
  const url = 'https://rivalearn-backend.onrender.com/api/users/login';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final username = responseData['username'];
      final accessToken = responseData['access_token'];
      final refreshToken = responseData['refresh_token'];

      return {
        'username': username,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
    } else {
      throw Exception('Error logging in: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
