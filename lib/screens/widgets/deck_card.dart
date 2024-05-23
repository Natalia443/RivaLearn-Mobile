import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:go_router/go_router.dart';

class DeckCard extends StatelessWidget {
  const DeckCard({
    super.key,
    required this.deckName,
    required this.deckId,
  });

  final String deckName;
  final String deckId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deckName,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 40, bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Quiz del deck $deckName',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.pushNamed(QuizScreen.name);
                                        },
                                        child: const Text('Estudiar ahora!'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.school,
                        color: Colors.amber,
                      )),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onPressed: () =>
                        context.pushNamed(FlashcardScreen.name, extra: deckId),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
