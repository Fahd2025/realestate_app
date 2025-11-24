import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:realestate_app/core/database/database.dart';

class PaymentReceiptGenerator {
  /// Generate a PDF receipt for a payment
  static Future<Uint8List> generateReceipt({
    required Payment payment,
    required Contract contract,
    required double remainingBalance,
    String? propertyTitle,
    String? payerName,
  }) async {
    final pdf = pw.Document();

    // Load NotoSansArabic font from assets
    final fontData =
        await rootBundle.load('assets/fonts/NotoSansArabic-Regular.ttf');
    final font = pw.Font.ttf(fontData);
    // Use the same font for bold since we only have regular weight
    final fontBold = font;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColors.blue700,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'PAYMENT RECEIPT',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.Text(
                      'Receipt #${payment.id.substring(0, 8).toUpperCase()}',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),

              // Payment Details
              pw.Text(
                'Payment Information',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 10),

              _buildInfoRow('Payment Date:',
                  payment.paymentDate.toString().split(' ')[0]),
              _buildInfoRow('Payment Type:', payment.paymentType.toUpperCase()),
              _buildInfoRow('Payment Method:', payment.paymentMethod ?? 'N/A'),
              _buildInfoRow('Status:', payment.status.toUpperCase()),

              pw.SizedBox(height: 20),

              // Amount Details
              pw.Container(
                padding: const pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey200,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  children: [
                    _buildAmountRow('Amount Paid:', payment.amount, true),
                    pw.SizedBox(height: 5),
                    pw.Divider(),
                    pw.SizedBox(height: 5),
                    _buildAmountRow(
                        'Remaining Balance:', remainingBalance, false),
                  ],
                ),
              ),

              pw.SizedBox(height: 30),

              // Contract Details
              pw.Text(
                'Contract Information',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 10),

              _buildInfoRow(
                  'Contract ID:', contract.id.substring(0, 8).toUpperCase()),
              _buildInfoRow(
                  'Contract Type:', contract.contractType.toUpperCase()),
              _buildInfoRow('Property:',
                  propertyTitle ?? contract.propertyId.substring(0, 8)),
              _buildInfoRow(
                  'Payer:', payerName ?? payment.payerId.substring(0, 8)),

              if (payment.notes != null && payment.notes!.isNotEmpty) ...[
                pw.SizedBox(height: 20),
                pw.Text(
                  'Notes',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 5),
                pw.Text(payment.notes!,
                    style: const pw.TextStyle(fontSize: 12)),
              ],

              pw.Spacer(),

              // Footer
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'Thank you for your payment',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue700,
                  ),
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text(
                  'Generated on ${DateTime.now().toString().split(' ')[0]}',
                  style: const pw.TextStyle(
                      fontSize: 10, color: PdfColors.grey600),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 12)),
          pw.Text(value,
              style:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  static pw.Widget _buildAmountRow(
      String label, double amount, bool highlight) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: highlight ? 16 : 14,
            fontWeight: highlight ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
        pw.Text(
          '\$${amount.toStringAsFixed(2)}',
          style: pw.TextStyle(
            fontSize: highlight ? 18 : 14,
            fontWeight: pw.FontWeight.bold,
            color: highlight ? PdfColors.green700 : PdfColors.black,
          ),
        ),
      ],
    );
  }

  /// Print receipt
  static Future<void> printReceipt({
    required Payment payment,
    required Contract contract,
    required double remainingBalance,
    String? propertyTitle,
    String? payerName,
  }) async {
    final pdfBytes = await generateReceipt(
      payment: payment,
      contract: contract,
      remainingBalance: remainingBalance,
      propertyTitle: propertyTitle,
      payerName: payerName,
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      name: 'Receipt_${payment.id.substring(0, 8)}.pdf',
    );
  }

  /// Share receipt
  static Future<void> shareReceipt({
    required Payment payment,
    required Contract contract,
    required double remainingBalance,
    String? propertyTitle,
    String? payerName,
  }) async {
    final pdfBytes = await generateReceipt(
      payment: payment,
      contract: contract,
      remainingBalance: remainingBalance,
      propertyTitle: propertyTitle,
      payerName: payerName,
    );

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Receipt_${payment.id.substring(0, 8)}.pdf',
    );
  }

  /// Generate and download receipt (save to device)
  static Future<void> generateAndDownloadReceipt(Payment payment) async {
    // In a real implementation, we would need to get related data
    // For now, we'll use default values since we don't have the context here
    try {
      final pdfBytes = await generateReceipt(
        payment: payment,
        contract: Contract(
          // Create a dummy contract with all required data
          id: payment.contractId,
          propertyId: payment.contractId,
          ownerId: '',
          tenantBuyerId: payment.payerId,
          contractType: 'rent', // Default value
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          monthlyRent: payment.amount, // Use payment amount as monthly rent
          salePrice: null,
          depositAmount: null,
          terms: '',
          description: '',
          descriptionAr: null,
          concessions: null,
          fileUrl: null,
          paymentFrequency: 'monthly', // Default frequency
          customFrequencyDays: null,
          status: 'active',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          syncStatus: 'synced', // Default sync status
        ),
        remainingBalance: 0.0, // This would be calculated in a real app
      );

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: 'Receipt_${payment.id.substring(0, 8)}.pdf',
      );
    } catch (e) {
      // Handle error appropriately
      print('Error generating receipt: $e');
    }
  }
}
