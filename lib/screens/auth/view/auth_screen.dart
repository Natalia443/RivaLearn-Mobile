import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_state.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});
  static const String name = "AuthScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            InputField(
              label: 'Usuario',
              onChanged: (value) {
                username = value;
              },
            ),
            const SizedBox(height: 20),
            InputField(
              label: 'Contraseña',
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: () async {
                  if (password!.isNotEmpty && username!.isNotEmpty) {
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
