import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/menu/menu_items.dart';
import 'package:flutter_application_1/providers/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const String name = "HomeScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider).isAuthenticated;
    final username = ref.watch(authProvider).tokens?['username'];

    if (!isAuthenticated) {
      context.go('/');
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('RivaLearn'),
      ),
      drawer: SafeArea(
          child: Drawer(
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFF37820).withOpacity(.15),
                  child: Text(
                    '$username',
                    style: const TextStyle(
                      color: Color(0xFF383838),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                '$username',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF383838),
                ),
              ),
            ],
          ),
        ),
      )),
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
