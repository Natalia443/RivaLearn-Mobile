import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/deck_datasource.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
