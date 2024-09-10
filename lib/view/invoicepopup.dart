import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class InvoicePopupScreen extends StatelessWidget {
  final Map<String, String> invoice;

  InvoicePopupScreen({required this.invoice});

  Future<File> _generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Name: ${invoice['name'] ?? 'N/A'}'),
              pw.Text('Address: ${invoice['address'] ?? 'N/A'}'),
              pw.Text('Pin Code: ${invoice['pin'] ?? 'N/A'}'),
              pw.Text('Mobile Number: ${invoice['mobile'] ?? 'N/A'}'),
            ],
          );
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final outputFile = File('${directory.path}/invoice.pdf');
    await outputFile.writeAsBytes(await pdf.save());

    return outputFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Invoice Details'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final pdfFile = await _generatePdf();
                  // Ensure the file exists before sharing
                  if (await pdfFile.exists()) {
                    // await Share.shareXFiles([pdfFile.path], text: 'Your invoice is ready!');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('The file does not exist at the specified path.')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error sharing PDF: $e')),
                  );
                }
              },
              child: Text('Share as PDF'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final pdfFile = await _generatePdf();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('PDF downloaded to: ${pdfFile.path}')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error downloading PDF: $e')),
                  );
                }
              },
              child: Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
