import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> saveUser(String username, String password, String email) async {
  const url = 'https://rivalearn-backend.onrender.com/api/users/signup';

  try {
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
      }),
    );
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

      return {
        'username': responseData['username'],
        'user_id': responseData['user_id'].toString(),
        'access_token': responseData['access_token'],
        'refresh_token': responseData['refresh_token'],
      };
    } else {
      throw Exception('Error logging in: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
