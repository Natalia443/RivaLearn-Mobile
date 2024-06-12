import 'package:flutter_application_1/core/data/gemini_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storiesProvider =
    FutureProvider.autoDispose.family<String, List<dynamic>>(
  (ref, words) {
    return getStory(words);
  },
);
