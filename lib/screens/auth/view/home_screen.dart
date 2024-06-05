import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/menu/menu_items.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/screens/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const String name = "HomeScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(authProvider).tokens?['username'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('RivaLearn'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$username',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF383838),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                ListTile(
                  title: const Text('Cerrar sesión'),
                  onTap: () {
                    ref.read(authProvider.notifier).logout();
                    context.goNamed(AuthScreen.name);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    const items = menuItems;

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return _CustomListTile(item: item);
        });
  }
}

class _CustomListTile extends StatelessWidget {
  final MenuItem item;

  const _CustomListTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      onTap: () {
        context.push(item.link);
      },
    );
  }
}
