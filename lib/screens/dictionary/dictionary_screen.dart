import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/dictionary_datasource.dart';
import 'package:flutter_application_1/core/data/lang_datasource.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});
  static const String name = "DictionaryScreen";

  @override
  DictionaryScreenState createState() => DictionaryScreenState();
}

class DictionaryScreenState extends State<DictionaryScreen> {
  List<String> definitions = [];
  String selectedLang = langList[0].code;
  String word = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diccionario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Seleccione idioma:'),
                  DropdownButton<String>(
                    value: selectedLang,
                    onChanged: (String? newLang) {
                      if (newLang != null) {
                        setState(
                          () {
                            selectedLang = newLang;
                          },
                        );
                      }
                    },
                    items: langList.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang.code,
                        child: Text(lang.name),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Busca la palabra',
              ),
              onChanged: (text) {
                setState(() {
                  word = text;
                });
              },
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final response = await fetchMeaning(word, selectedLang);
                    setState(() {
                      definitions = response;
                    });
                  } catch (error) {
                    throw Exception(error);
                  }
                },
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
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
      ),
    );
  }
}
