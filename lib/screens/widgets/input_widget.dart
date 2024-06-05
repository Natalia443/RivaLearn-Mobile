import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final TextEditingController? controller;

  const InputField({
    required this.label,
    this.onSaved,
    this.onChanged,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        controller: controller,
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
