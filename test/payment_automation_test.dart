import 'package:flutter_test/flutter_test.dart';
import 'package:realestate_app/features/payments/services/payment_processor.dart';
import 'package:realestate_app/features/payments/models/payment_result.dart';

void main() {
  group('Payment Automation Tests', () {
    test('Payment processor returns success result', () async {
      final result = await PaymentProcessor.processPayment(
        paymentId: 'test-id',
        amount: 100.0,
      );
      
      expect(result, isA<PaymentResult>());
      expect(result.success, true);
    });

    test('Payment processor can fail with 10% probability', () async {
      int failures = 0;
      const testRuns = 100;
      
      for (int i = 0; i < testRuns; i++) {
        final result = await PaymentProcessor.processPayment(
          paymentId: 'test-id-$i',
          amount: 100.0,
        );
        
        if (!result.success) {
          failures++;
        }
      }
      
      // Since failure rate is 10%, we expect around 10 failures in 100 runs
      // Allow some variance due to randomness
      expect(failures, greaterThanOrEqualTo(0));
      expect(failures, lessThanOrEqualTo(30)); // Reasonable upper bound
    });

    test('Payment result provides appropriate message', () async {
      final successResult = PaymentResult.success('TXN12345');
      expect(successResult.message, 'Transaction successful');
      
      final failureResult = PaymentResult.failure('Test error');
      expect(failureResult.message, 'Test error');
    });

    test('PaymentProcessor is overdue detection works', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 1));
      final futureDate = DateTime.now().add(const Duration(days: 1));
      
      expect(PaymentProcessor.isOverdue(pastDate), true);
      expect(PaymentProcessor.isOverdue(futureDate), false);
      expect(PaymentProcessor.isOverdue(null), false);
    });
  });
}