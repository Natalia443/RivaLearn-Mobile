import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/flashcard_datasource.dart';
import 'package:flutter_application_1/core/data/lang_datasource.dart';
import 'package:flutter_application_1/providers/flashcard_provider.dart';
import 'package:flutter_application_1/screens/auth/widgets/input_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashcardScreen extends ConsumerWidget {
  final String deckId;
  const FlashcardScreen({super.key, required this.deckId});
  static const String name = "FlashcardScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashcardState = ref.watch(flashcardProvider(deckId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: RefreshIndicator(
          onRefresh: () => ref.refresh(flashcardProvider(deckId).future),
          child: flashcardState.when(
            data: (flashcardList) => ListView.builder(
              itemCount: flashcardList.length,
              itemBuilder: (context, index) {
                final flashcardName = flashcardList[index]['vocab'];
                return Card(
                  child: ListTile(
                    title: Text(flashcardName),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
            error: (error, _) => Center(
              child: Text('Error: $error'),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return PopScope(child: CreateFlashcardDialog(deckId: deckId));
              });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CreateFlashcardDialog extends ConsumerStatefulWidget {
  final String deckId;
  final String? selectedWord;
  const CreateFlashcardDialog(
      {super.key, required this.deckId, this.selectedWord});

  @override
  CreateFlashcardDialogState createState() => CreateFlashcardDialogState();
}

class CreateFlashcardDialogState extends ConsumerState<CreateFlashcardDialog> {
  late String? vocab = widget.selectedWord;
  String sourceLang = langList[0].code;
  String targetLang = deeplTargetLangList[1].code;

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
              InputField(
                label: "Vocabulario",
                onChanged: (value) => setState(() => vocab = value),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: sourceLang,
                      onChanged: (String? newLang) {
                        if (newLang != null) {
                          setState(() {
                            sourceLang = newLang;
                          });
                        }
                      },
                      items: langList.map((lang) {
                        return DropdownMenuItem<String>(
                          value: lang.code,
                          child: Text(lang.code),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton<String>(
                      value: targetLang,
                      onChanged: (String? newLang) {
                        if (newLang != null) {
                          setState(() {
                            targetLang = newLang;
                          });
                        }
                      },
                      items: deeplTargetLangList.map((lang) {
                        return DropdownMenuItem<String>(
                          value: lang.code,
                          child: Text(lang.code),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: ElevatedButton(
                  onPressed: () {
                    createFlashcard(
                        widget.deckId, vocab!, sourceLang, targetLang);
                    ref.invalidate(flashcardProvider);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Crear',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
