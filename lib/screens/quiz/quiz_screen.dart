import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/stats_datasource.dart';
import 'package:flutter_application_1/entities/entities.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/deck/deck.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key, required this.deckId});
  static const String name = 'QuizScreen';
  final String deckId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int counter = 0;
  int success = 0;
  int total = 0;
  String displayExampleText = '';
  String displayVocabText = '';

  void _showAnswer(List<dynamic> list, int index) {
    setState(() {
      displayVocabText = list[index]['vocab_translated'];
      displayExampleText = list[index]['vocab_example_translated'];
    });
  }

  void _cleanAnswer() {
    displayVocabText = '';
    displayExampleText = '';
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authProvider).tokens?['user_id'];
    final flashcardState = ref.watch(flashcardProvider(widget.deckId));
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: flashcardState.when(
          data: (flashcardList) => ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      flashcardList[counter]['vocab'],
                      style: const TextStyle(fontSize: 36),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      displayVocabText,
                      style: TextStyle(fontSize: 22, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(
                      flashcardList[counter]['vocab_example'],
                      style: const TextStyle(fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      displayExampleText,
                      style: TextStyle(fontSize: 22, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 330,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (counter < flashcardList.length - 1) {
                                  counter++;
                                  total++;
                                } else {
                                  saveStats(Stats(
                                      success: success,
                                      total: total,
                                      userId: userId!));
                                  context.pushNamed(DeckScreen.name);
                                }
                              });
                              _cleanAnswer();
                            },
                            child: const Text('No lo sé')),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _showAnswer(flashcardList, counter);
                              setState(() {});
                            },
                            child: const Text('Mostrar Respuesta')),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (counter < flashcardList.length - 1) {
                                  counter++;
                                  success++;
                                  total++;
                                } else {
                                  saveStats(Stats(
                                      success: success,
                                      total: total,
                                      userId: userId!));
                                  context.pushNamed(DeckScreen.name);
                                }
                              });
                              _cleanAnswer();
                            },
                            child: const Text('Lo sé')),
                      ],
                    )
                  ]);
            },
          ),
          error: (error, _) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
