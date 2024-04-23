import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/dictionary_datasource.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  static const String name = "DictionaryScreen";

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  List<String> definitions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diccionario'),
      ),
      body: DictionaryView(
        definitions: definitions,
        onSearch: (String text) {
          _fetchMeaning(text);
        },
      ),
    );
  }

  Future<void> _fetchMeaning(String text) async {
    try {
      final List<String> fetchedDefinitions = await fetchMeaning(text);
      setState(() {
        definitions = fetchedDefinitions;
      });
    } catch (error) {
      print('Error al obtener las definiciones: $error');
    }
  }
}

class DictionaryView extends StatelessWidget {
  final List<String> definitions;
  final Function(String) onSearch;

  const DictionaryView(
      {super.key, required this.definitions, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Busca la palabra',
            ),
            onSubmitted: onSearch,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: definitions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${index + 1}. ${definitions[index]}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
