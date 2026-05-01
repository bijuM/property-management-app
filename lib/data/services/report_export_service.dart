import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ReportExportService {
  static final DateFormat _timestampFormat = DateFormat('yyyyMMdd_HHmmss');

  Future<File> exportCsv({
    required String title,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final file = await _createFile(title, 'csv');
    final csvContent = csv.encode([
      headers,
      ...rows,
    ]);
    await file.writeAsString(csvContent);
    await _shareFile(file, title);
    return file;
  }

  Future<File> exportPdf({
    required String title,
    required List<String> summaryLines,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final file = await _createFile(title, 'pdf');
    final document = pw.Document();

    document.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          ...summaryLines.map((line) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(line),
              )),
          pw.SizedBox(height: 16),
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: rows,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellAlignment: pw.Alignment.centerLeft,
          ),
        ],
      ),
    );

    await file.writeAsBytes(await document.save());
    await _shareFile(file, title);
    return file;
  }

  Future<File> _createFile(String title, String extension) async {
    final directory = await getTemporaryDirectory();
    final timestamp = _timestampFormat.format(DateTime.now());
    final safeTitle = title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+$'), '');

    return File(p.join(directory.path, '${safeTitle}_$timestamp.$extension'));
  }

  Future<void> _shareFile(File file, String title) async {
    await SharePlus.instance.share(
      ShareParams(
        text: title,
        files: [XFile(file.path)],
      ),
    );
  }
}
