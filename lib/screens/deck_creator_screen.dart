import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/decks_screen.dart';
import 'package:flutter_application_1/screens/widgets/input_widget.dart';
import 'package:go_router/go_router.dart';

class DeckCreatorScreen extends StatelessWidget {
  const DeckCreatorScreen({super.key});
  static const String name = "DeckCreatorScreen";

  @override
  Widget build(BuildContext context) {
    String? deckName;
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
                  context.pushNamed(DeckScreen.name);
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
