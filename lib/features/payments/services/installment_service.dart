import 'package:realestate_app/features/payments/models/payment_frequency.dart';
import 'package:realestate_app/features/payments/models/payment_schedule_item.dart';

class InstallmentService {
  /// Calculate the number of installments based on frequency and contract duration
  static int calculateInstallmentCount(
    PaymentFrequency frequency,
    DateTime startDate,
    DateTime endDate, {
    int? customFrequencyDays,
  }) {
    final duration = endDate.difference(startDate).inDays;

    switch (frequency) {
      case PaymentFrequency.monthly:
        // Calculate months between dates
        int months = (endDate.year - startDate.year) * 12 +
            (endDate.month - startDate.month);
        return months > 0 ? months : 1;

      case PaymentFrequency.quarterly:
        return (duration / 90).ceil();

      case PaymentFrequency.semiAnnual:
        return (duration / 180).ceil();

      case PaymentFrequency.annual:
        return (duration / 365).ceil();

      case PaymentFrequency.custom:
        if (customFrequencyDays == null || customFrequencyDays <= 0) {
          throw ArgumentError('Custom frequency requires valid days interval');
        }
        return (duration / customFrequencyDays).ceil();
    }
  }

  /// Calculate the amount per installment
  static double calculateInstallmentAmount(
    double totalAmount,
    int installmentCount,
  ) {
    if (installmentCount <= 0) {
      throw ArgumentError('Installment count must be positive');
    }
    return totalAmount / installmentCount;
  }

  /// Check if amount divides evenly
  static bool isEvenlyDivisible(double totalAmount, int installmentCount) {
    final amount = totalAmount / installmentCount;
    return (amount * 100).round() == (amount * 100);
  }

  /// Generate a complete payment schedule
  static List<PaymentScheduleItem> generateSchedule({
    required double totalAmount,
    required PaymentFrequency frequency,
    required DateTime startDate,
    required DateTime endDate,
    required String paymentType,
    int? customFrequencyDays,
  }) {
    final installmentCount = calculateInstallmentCount(
      frequency,
      startDate,
      endDate,
      customFrequencyDays: customFrequencyDays,
    );

    final baseAmount =
        calculateInstallmentAmount(totalAmount, installmentCount);
    final schedule = <PaymentScheduleItem>[];

    // Calculate the remainder to add to the last installment
    final totalCalculated = baseAmount * installmentCount;
    final remainder = totalAmount - totalCalculated;

    for (int i = 0; i < installmentCount; i++) {
      final dueDate = _calculateDueDate(
        startDate,
        i,
        frequency,
        customFrequencyDays,
      );

      // Add remainder to last installment
      final amount =
          (i == installmentCount - 1) ? baseAmount + remainder : baseAmount;

      schedule.add(PaymentScheduleItem(
        installmentNumber: i + 1,
        dueDate: dueDate,
        amount: amount,
        paymentType: paymentType,
      ));
    }

    return schedule;
  }

  /// Calculate due date for a specific installment
  static DateTime _calculateDueDate(
    DateTime startDate,
    int installmentIndex,
    PaymentFrequency frequency,
    int? customFrequencyDays,
  ) {
    switch (frequency) {
      case PaymentFrequency.monthly:
        return DateTime(
          startDate.year,
          startDate.month + installmentIndex + 1,
          startDate.day,
        );

      case PaymentFrequency.quarterly:
        return DateTime(
          startDate.year,
          startDate.month + (installmentIndex + 1) * 3,
          startDate.day,
        );

      case PaymentFrequency.semiAnnual:
        return DateTime(
          startDate.year,
          startDate.month + (installmentIndex + 1) * 6,
          startDate.day,
        );

      case PaymentFrequency.annual:
        return DateTime(
          startDate.year + installmentIndex + 1,
          startDate.month,
          startDate.day,
        );

      case PaymentFrequency.custom:
        if (customFrequencyDays == null || customFrequencyDays <= 0) {
          throw ArgumentError('Custom frequency requires valid days interval');
        }
        return startDate
            .add(Duration(days: customFrequencyDays * (installmentIndex + 1)));
    }
  }

  /// Validate payment schedule parameters
  static String? validateScheduleParameters({
    required double totalAmount,
    required PaymentFrequency frequency,
    required DateTime startDate,
    required DateTime endDate,
    int? customFrequencyDays,
  }) {
    if (totalAmount <= 0) {
      return 'Total amount must be positive';
    }

    if (endDate.isBefore(startDate) || endDate.isAtSameMomentAs(startDate)) {
      return 'End date must be after start date';
    }

    if (frequency == PaymentFrequency.custom) {
      if (customFrequencyDays == null || customFrequencyDays <= 0) {
        return 'Custom frequency requires a positive number of days';
      }
    }

    try {
      final count = calculateInstallmentCount(
        frequency,
        startDate,
        endDate,
        customFrequencyDays: customFrequencyDays,
      );
      if (count <= 0) {
        return 'Invalid contract duration for selected frequency';
      }
    } catch (e) {
      return e.toString();
    }

    return null; // Valid
  }
}
