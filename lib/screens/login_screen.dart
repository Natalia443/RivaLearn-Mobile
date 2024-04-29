import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_state.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/widgets/input_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  static const String name = "LoginScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? username;
    String? password;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  formKey.currentState?.save();
                },
                child: Wrap(
                  children: [
                    buildInputField("Usuario", (value) => username = value),
                    buildInputField("Contraseña", (value) => password = value),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await ref
                        .read(authProvider.notifier)
                        .login(username!, password!);
                    context.pushNamed(HomeScreen.name);
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
