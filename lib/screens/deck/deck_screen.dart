import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/deck_datasource.dart';
import 'package:flutter_application_1/providers/deck_provider.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckScreen extends ConsumerWidget {
  const DeckScreen({super.key});
  static const String name = "DeckScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckList = ref.watch(deckProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(deckProvider.future),
        child: deckList.when(
          data: (deckList) => ListView.builder(
            itemCount: deckList.length,
            itemBuilder: (context, index) {
              final deckName = deckList[index];
              return Card(
                child: ListTile(
                  title: Text(deckName),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.pushNamed(FlashcardScreen.name, extra: deckName);
                  },
                ),
              );
            },
          ),
          error: (error, _) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const PopScope(child: CreateDeckDialog());
              });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CreateDeckDialog extends ConsumerStatefulWidget {
  const CreateDeckDialog({super.key});

  @override
  CreateDeckDialogState createState() => CreateDeckDialogState();
}

class CreateDeckDialogState extends ConsumerState<CreateDeckDialog> {
  late String? deckName;

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authProvider).tokens?['user_id'];
    return Dialog(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 24, right: 18, left: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              label: "Nombre del deck",
              onChanged: (value) => setState(() => deckName = value),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: ElevatedButton(
                onPressed: () {
                  createDeck(userId!, deckName!);
                  ref.invalidate(deckProvider);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Crear',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
