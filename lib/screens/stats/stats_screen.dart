import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({
    super.key,
  });
  static const String name = "StatsScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).tokens?['user_id'];
    final statsState = ref.watch(statsProvider(userId!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadisticas'),
      ),
      body: statsState.when(
        data: (stats) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Intentos totales',
                      style: TextStyle(fontSize: 36),
                    ),
                    Text(
                      stats.total.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        color: Color.fromARGB(255, 6, 4, 143),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Aciertos totales',
                      style: TextStyle(fontSize: 36),
                    ),
                    Text(
                      stats.success.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        color: Color.fromARGB(255, 52, 129, 55),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
