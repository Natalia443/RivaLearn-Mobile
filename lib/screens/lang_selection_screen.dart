import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/lang_datasource.dart';
import 'package:flutter_application_1/screens/book_catalog_screen.dart';
import 'package:go_router/go_router.dart';

class LangSelectionScreen extends StatelessWidget {
  const LangSelectionScreen({super.key});
  static const String name = "LangSelectionScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Idiomas',
        ),
      ),
      body: const _LangsView(),
    );
  }
}

class _LangsView extends StatelessWidget {
  const _LangsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: langList.length,
        itemBuilder: (context, index) {
          final lang = langList[index];
          return Card(
              child: ListTile(
                  title: Text(lang.name),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.pushNamed(BookCatalogScreen.name, extra: lang.code);
                  }));
        });
  }
}
