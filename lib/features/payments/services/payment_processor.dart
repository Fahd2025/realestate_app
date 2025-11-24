import 'dart:math';
import 'package:realestate_app/features/payments/models/payment_result.dart';
import 'package:realestate_app/features/payments/data/repositories/payments_repository.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:drift/drift.dart' as drift;

class PaymentProcessor {
  final PaymentsRepository _repository;

  PaymentProcessor(this._repository);

  /// Simulate payment processing
  /// In a real application, this would integrate with a payment gateway
  Future<PaymentResult> processPayment({
    required String paymentId,
    required double amount,
    required String paymentMethod,
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

      // Update payment status in database
      await _updatePaymentStatus(
        paymentId,
        'completed',
        transactionId,
        paymentMethod,
      );

      return PaymentResult.success(transactionId);
    } catch (e) {
      return PaymentResult.failure('Payment processing error: ${e.toString()}');
    }
  }

  /// Update payment status in the database
  Future<void> _updatePaymentStatus(
    String paymentId,
    String status,
    String? transactionId,
    String? paymentMethod,
  ) async {
    // Create a companion with the fields to update
    final updatedPayment = PaymentsCompanion(
      id: drift.Value(paymentId),
      status: drift.Value(status),
      paymentMethod: drift.Value(paymentMethod),
      paymentDate: drift.Value(DateTime.now()),
      updatedAt: drift.Value(DateTime.now()),
    );

    await _repository.updatePayment(updatedPayment);
  }

  /// Mark payment as failed
  Future<void> markPaymentFailed(String paymentId, String reason) async {
    await _updatePaymentStatus(paymentId, 'failed', null, null);
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

  /// Auto-update overdue payments
  Future<void> updateOverduePayments(List<String> paymentIds) async {
    for (final id in paymentIds) {
      try {
        final payments = await _repository.getPaymentsForContract('');
        final payment = payments.firstWhere((p) => p.id == id);

        if (payment.status == 'pending' && isOverdue(payment.dueDate)) {
          final updatedPayment = PaymentsCompanion(
            id: drift.Value(id),
            status: const drift.Value('overdue'),
            updatedAt: drift.Value(DateTime.now()),
          );
          await _repository.updatePayment(updatedPayment);
        }
      } catch (e) {
        // Continue with next payment
        continue;
      }
    }
  }
}
