import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/screens/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});
  static const String name = "AuthScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

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
              controller: usernameController,
            ),
            const SizedBox(height: 20),
            InputField(
              label: 'Contraseña',
              controller: passwordController,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: authState.isLoading
                    ? null
                    : () async {
                        if (passwordController.text.isNotEmpty &&
                            usernameController.text.isNotEmpty) {
                          await ref.read(authProvider.notifier).login(
                                usernameController.text,
                                passwordController.text,
                              );
                          context.goNamed(HomeScreen.name);
                        }
                      },
                child: authState.isLoading
                    ? const Center(
                        child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            )),
                      )
                    : const Text(
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
