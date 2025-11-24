import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:realestate_app/core/database/database.dart';

class ContractPdfGenerator {
  static Future<Uint8List> generate(Contract contract) async {
    final pdf = pw.Document();

    final font = await PdfGoogleFonts.notoSansArabicRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Real Estate Contract',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Contract ID: ${contract.id}'),
              pw.Text('Date: ${contract.createdAt.toString().split(' ')[0]}'),
              pw.SizedBox(height: 20),
              pw.Text('Property ID: ${contract.propertyId}'),
              pw.Text('Owner ID: ${contract.ownerId}'),
              pw.Text('Tenant/Buyer ID: ${contract.tenantBuyerId}'),
              pw.SizedBox(height: 20),
              pw.Text('Terms:'),
              pw.Text(contract.terms ?? 'N/A'),
              pw.SizedBox(height: 20),
              pw.Text('Description:'),
              pw.Text(contract.description ?? 'N/A'),
              pw.SizedBox(height: 40),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text('Owner Signature'),
                      pw.SizedBox(height: 50),
                      pw.Container(
                          height: 1, width: 100, color: PdfColors.black),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('Tenant/Buyer Signature'),
                      pw.SizedBox(height: 50),
                      pw.Container(
                          height: 1, width: 100, color: PdfColors.black),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<void> printContract(Contract contract) async {
    final pdfBytes = await generate(contract);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      name: 'Contract_${contract.id}.pdf',
    );
  }

  static Future<void> shareContract(Contract contract) async {
    final pdfBytes = await generate(contract);
    await Printing.sharePdf(
        bytes: pdfBytes, filename: 'Contract_${contract.id}.pdf');
  }
}
