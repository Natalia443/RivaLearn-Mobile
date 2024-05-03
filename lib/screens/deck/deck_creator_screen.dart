import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/deck_datasource.dart';
import 'package:flutter_application_1/providers/user_state.dart';
import 'package:flutter_application_1/screens/auth/view/home_screen.dart';
import 'package:flutter_application_1/screens/auth/widgets/input_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckCreatorScreen extends ConsumerWidget {
  const DeckCreatorScreen({super.key});
  static const String name = "DeckCreatorScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? deckName;
    final username = ref.watch(authProvider).tokens?['username'];
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Deck'),
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
                    buildInputField(
                        "Nombre del deck", (value) => deckName = value),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  createDeck(username!, deckName!);
                  context.pushNamed(HomeScreen.name);
                },
                child: const Text('Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
