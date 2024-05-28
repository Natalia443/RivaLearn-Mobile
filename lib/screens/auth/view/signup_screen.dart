import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/users_datasource.dart';
import 'package:flutter_application_1/screens/auth/auth.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/widgets.dart';

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
                child: Column(
                  children: [
                    InputField(
                      label: "Usuario",
                      onSaved: (value) => _username = value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputField(
                      label: "Email",
                      onSaved: (value) => _email = value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputField(
                      label: "Contraseña",
                      onSaved: (value) => _password = value,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveUser(_username!, _password!, _email!);
                      context.pushNamed(AuthScreen.name);
                    }
                  },
                  child: const Text(
                    'Enviar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
