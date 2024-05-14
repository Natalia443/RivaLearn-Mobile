import 'package:flutter_application_1/core/data/deck_datasource.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deckProvider = FutureProvider.autoDispose(
  (ref) {
    final username = ref.watch(authProvider).tokens?['user_id'];
    return getDecks(username!);
  },
);
