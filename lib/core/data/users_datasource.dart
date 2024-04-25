import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> saveUser(String username, String password, String email) async {
  const url = 'https://rivalearn-backend.onrender.com/api/users/user';

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
      print('Error al guardar el usuario: ${response.statusCode}');
    }
  } catch (e) {
    print('Error de conexión: $e');
  }
}
