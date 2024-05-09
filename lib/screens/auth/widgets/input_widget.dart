import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;

  const InputField({
    required this.label,
    this.onSaved,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: TextFormField(
        onSaved: onSaved,
        onChanged: onChanged,
        obscureText: label.toLowerCase() == 'contraseña',
        decoration: InputDecoration(
          hintText: label.toLowerCase(),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
