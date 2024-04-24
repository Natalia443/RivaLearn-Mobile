import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/dictionary_datasource.dart';
import 'package:flutter_application_1/core/data/lang_datasource.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  static const String name = "DictionaryScreen";

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  List<String> definitions = [];
  late String selectedLang;
  late String word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diccionario'),
      ),
      body: DictionaryView(
          definitions: definitions,
          onSearch: (String text) {
            word = text;
          },
          onSelection: (String selection) {
            selectedLang = selection;
          },
          onClick: () {
            _fetchMeaning();
          }),
    );
  }

  Future<void> _fetchMeaning() async {
    try {
      final List<String> fetchedDefinitions =
          await fetchMeaning(word, selectedLang);
      setState(() {
        definitions = fetchedDefinitions;
      });
    } catch (error) {
      print('Error al obtener las definiciones: $error');
    }
  }
}

class DictionaryView extends StatefulWidget {
  final List<String> definitions;
  final Function(String) onSearch;
  final Function(String) onSelection;
  final Function() onClick;

  DictionaryView({
    super.key,
    required this.definitions,
    required this.onSearch,
    required this.onSelection,
    required this.onClick,
  });

  @override
  _DictionaryViewState createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  late String langOption;

  @override
  void initState() {
    super.initState();
    langOption = langList[0].code;
  }

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
            onSubmitted: widget.onSearch,
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: langOption,
            onChanged: (String? newLang) {
              if (newLang != null) {
                setState(() {
                  langOption = newLang;
                });
              }
              widget.onSelection(langOption);
            },
            items: langList.map((lang) {
              return DropdownMenuItem<String>(
                value: lang.code,
                child: Text(lang.code),
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: widget.onClick, child: const Text('Enviar')),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.definitions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${index + 1}. ${widget.definitions[index]}'),
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
