import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  const PDFViewerScreen({super.key});
  static const String name = "PDFViewerScreen";

  @override
  PDFViewerScreenState createState() => PDFViewerScreenState();
}

class PDFViewerScreenState extends State<PDFViewerScreen> {
  String? pdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
          child: pdfPath != null
              ? SfPdfViewer.file(
                  File(pdfPath!),
                  enableTextSelection: true,
                )
              : FloatingActionButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                    if (result != null) {
                      setState(() {
                        pdfPath = result.files.single.path!;
                      });
                    }
                  },
                  child: const Icon(Icons.file_upload),
                ),
        ),
        appBar: AppBar(
          title: const Text('Lector PDF'),
        ),
        body: const Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Column(children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Subí acá tu PDF de un libro o documento en cualquiera de los idiomas reconocidos y disfruta las ventajas de leerlo en RivaLearn!',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 90, 88, 88)),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Los idiomas aceptados por la aplicación son: ',
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 90, 88, 88))),
            SizedBox(
              height: 15,
            ),
            Text(
              '🇪🇸 Español\n 🇬🇧 Inglés\n 🇫🇷 Francés\n 🇵🇹 Portugués\n 🇮🇹 Italiano',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 90, 88, 88)),
            ),
          ]),
        ));
  }
}
