import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/flashcard_datasource.dart';
import 'package:flutter_application_1/core/data/lang_datasource.dart';
import 'package:flutter_application_1/screens/auth/auth.dart';
import 'package:go_router/go_router.dart';

class FlashcardCreatorScreen extends StatefulWidget {
  final String deckname;
  const FlashcardCreatorScreen({super.key, required this.deckname});
  static const String name = "FlashcardCreatorScreen";

  @override
  State<FlashcardCreatorScreen> createState() => _FlashcardCreatorScreenState();
}

class _FlashcardCreatorScreenState extends State<FlashcardCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    String? flashcard;
    String sourceLang = langList[0].code;
    String targetLang = deeplTargetLangList[1].code;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Flashcard'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  formKey.currentState?.save();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                        label: "Palabra",
                        onSaved: (value) => flashcard = value),
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
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (flashcard != null) {
                    createFlashcard(
                        widget.deckname, flashcard!, sourceLang, targetLang);
                    context.pushNamed(HomeScreen.name);
                  }
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
