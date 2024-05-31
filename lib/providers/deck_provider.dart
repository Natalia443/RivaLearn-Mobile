import 'package:flutter_application_1/core/data/deck_datasource.dart';
import 'package:flutter_application_1/entities/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deckProvider = FutureProvider.autoDispose.family<List<Deck>, String>(
  (ref, userId) {
    return getDecks(userId);
  },
);
