import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/l10n/app_localizations.dart';

class ContractPdfGenerator {
  static Future<Uint8List> generate(
      Contract contract, AppLocalizations l10n) async {
    final pdf = pw.Document();

    // Load NotoSansArabic font from assets
    final fontData =
        await rootBundle.load('assets/fonts/NotoSansArabic-Regular.ttf');
    final font = pw.Font.ttf(fontData);

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
                child: pw.Text(l10n.contractDetails,
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Text('${l10n.contractId}: ${contract.id}'),
              pw.Text(
                  '${l10n.date}: ${contract.createdAt.toString().split(' ')[0]}'),
              pw.SizedBox(height: 20),
              pw.Text('${l10n.propertyId}: ${contract.propertyId}'),
              pw.Text('${l10n.ownerId}: ${contract.ownerId}'),
              pw.Text(
                  '${contract.contractType == 'lease' ? l10n.tenantId : l10n.buyerId}: ${contract.tenantBuyerId}'),
              pw.SizedBox(height: 20),
              pw.Text('${l10n.terms}:'),
              pw.Text(contract.terms ?? 'N/A'),
              pw.SizedBox(height: 20),
              pw.Text('${l10n.description}:'),
              pw.Text(contract.description ?? 'N/A'),
              pw.SizedBox(height: 40),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text(l10n.ownerSignature),
                      pw.SizedBox(height: 50),
                      pw.Container(
                          height: 1, width: 100, color: PdfColors.black),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text(contract.contractType == 'lease'
                          ? l10n.tenantSignature
                          : l10n.buyerSignature),
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

  static Future<void> printContract(
      Contract contract, AppLocalizations l10n) async {
    final pdfBytes = await generate(contract, l10n);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      name: 'Contract_${contract.id}.pdf',
    );
  }

  static Future<void> shareContract(
      Contract contract, AppLocalizations l10n) async {
    final pdfBytes = await generate(contract, l10n);
    await Printing.sharePdf(
        bytes: pdfBytes, filename: 'Contract_${contract.id}.pdf');
  }
}
