import 'package:flutter/material.dart';

Widget buildInputField(String label, Function(String?) onSave) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200, height: 70),
      child: TextFormField(
        onSaved: onSave,
        obscureText: label.toLowerCase() == 'password',
        decoration: InputDecoration(
          hintText: label.toLowerCase(),
        ),
      ),
    ),
  );
}
