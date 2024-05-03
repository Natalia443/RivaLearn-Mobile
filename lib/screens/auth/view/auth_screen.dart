import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_state.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});
  static const String name = "AuthScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? username;
    String? password;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RivaLearn'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                formKey.currentState?.save();
              },
              child: Column(
                children: [
                  buildInputField("Usuario", (value) => username = value),
                  const SizedBox(
                    height: 30,
                  ),
                  buildInputField("Contraseña", (value) => password = value),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await ref
                        .read(authProvider.notifier)
                        .login(username!, password!);
                    context.pushNamed(HomeScreen.name);
                  }
                },
                child: const Text(
                  "Inicia Sesión",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: OutlinedButton(
                onPressed: () {
                  context.pushNamed(SignUpScreen.name);
                },
                child: const Text(
                  "Registrate",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
