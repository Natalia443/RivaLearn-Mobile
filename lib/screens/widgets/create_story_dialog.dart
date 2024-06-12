import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/deck.dart';
import 'package:flutter_application_1/screens/gemini/ai_stories_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateStoryDialog extends ConsumerStatefulWidget {
  final Deck deck;
  const CreateStoryDialog({super.key, required this.deck});

  @override
  CreateStoryDialogState createState() => CreateStoryDialogState();
}

class CreateStoryDialogState extends ConsumerState<CreateStoryDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 24, right: 18, left: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Crear historia con el deck \n${widget.deck.name}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(AiStoriesScreen.name, extra: widget.deck);
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
