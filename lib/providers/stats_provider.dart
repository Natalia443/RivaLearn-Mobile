import 'package:flutter_application_1/core/data/stats_datasource.dart';
import 'package:flutter_application_1/entities/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statsProvider = FutureProvider.autoDispose.family<Stats, String>(
  (ref, userId) {
    return getStats(userId);
  },
);
