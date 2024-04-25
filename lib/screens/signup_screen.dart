import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/users_datasource.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name = "SignUpScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _username;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  _formKey.currentState?.save();
                },
                child: Wrap(
                  children: [
                    _buildInputField("Username", (value) => _username = value),
                    _buildInputField("Email", (value) => _email = value),
                    _buildInputField("Password", (value) => _password = value),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveUser(_username!, _password!, _email!);
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, Function(String?) onSave) {
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
}
