import 'package:flutter_application_1/core/data/flashcard_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// part 'flashcardProvider.freezed.dart';
// part 'flashcardProvider.g.dart';

final flashcardProvider =
    FutureProvider.autoDispose.family<List<dynamic>, String>((ref, deck) {
  return getFlashcards(deck);
});
