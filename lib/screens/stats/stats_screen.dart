import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/providers/stats_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});
  static const String name = 'StatsScreen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).tokens?['user_id'];
    final statsState = ref.watch(statsProvider(userId!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadisticas'),
      ),
    );
  }
}
