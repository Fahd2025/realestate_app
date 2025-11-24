import 'dart:math';
import 'package:realestate_app/features/payments/models/payment_result.dart';

class PaymentProcessor {
  /// Static method to simulate payment processing
  /// In a real application, this would integrate with a payment gateway
  static Future<PaymentResult> processPayment({
    required String paymentId,
    required double amount,
    String paymentMethod = 'credit_card', // Default payment method
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate random payment failures (10% chance)
      final random = Random();
      if (random.nextDouble() < 0.1) {
        return PaymentResult.failure(
            'Payment gateway error: Transaction declined');
      }

      // Generate a mock transaction ID
      final transactionId =
          'TXN${DateTime.now().millisecondsSinceEpoch}${random.nextInt(1000)}';

      // Note: Payment status update is handled by the UI layer
      // that calls this method, since this service doesn't have database access

      return PaymentResult.success(transactionId);
    } catch (e) {
      return PaymentResult.failure('Payment processing error: ${e.toString()}');
    }
  }

  /// Check if payment is overdue
  static bool isOverdue(DateTime? dueDate) {
    if (dueDate == null) return false;
    return dueDate.isBefore(DateTime.now()) &&
        !_isSameDay(dueDate, DateTime.now());
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
