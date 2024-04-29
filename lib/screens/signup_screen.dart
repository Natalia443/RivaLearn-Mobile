import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/users_datasource.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/widgets/input_widget.dart';
import 'package:go_router/go_router.dart';

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
                    buildInputField("Usuario", (value) => _username = value),
                    buildInputField("Email", (value) => _email = value),
                    buildInputField("Contraseña", (value) => _password = value),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveUser(_username!, _password!, _email!);
                    context.pushNamed(LoginScreen.name);
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
}
