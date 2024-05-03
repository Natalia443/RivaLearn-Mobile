import 'package:flutter/material.dart';

Widget buildInputField(String label, Function(String?) onSave) {
  return SizedBox(
    width: 285,
    child: TextFormField(
      onSaved: onSave,
      obscureText: label.toLowerCase() == 'contraseña',
      decoration: InputDecoration(
        hintText: label.toLowerCase(),
      ),
    ),
  );
}
