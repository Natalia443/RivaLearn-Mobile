import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
      appBar: AppBar(
        title: const Text('Lector PDF'),
      ),
      body: Center(
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
    );
  }
}
