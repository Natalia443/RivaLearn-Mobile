import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});
  static const String name = "MainMenuScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RivaLearn'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                context.pushNamed(SignUpScreen.name);
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("Registrate"),
            ),
            const SizedBox(height: 60),
            OutlinedButton(
              onPressed: () {
                context.pushNamed(LoginScreen.name);
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("Inicia Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
