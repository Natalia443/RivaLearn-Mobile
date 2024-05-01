import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/deck_creator_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckScreen extends ConsumerWidget {
  const DeckScreen({super.key});
  static const String name = "DeckScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
      ),
      body: const Center(
        child: Text('Contenido de la página'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(DeckCreatorScreen.name);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
