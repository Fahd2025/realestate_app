import 'package:equatable/equatable.dart';

class PaymentScheduleItem extends Equatable {
  final int installmentNumber;
  final DateTime dueDate;
  final double amount;
  final String paymentType;

  const PaymentScheduleItem({
    required this.installmentNumber,
    required this.dueDate,
    required this.amount,
    required this.paymentType,
  });

  @override
  List<Object?> get props => [installmentNumber, dueDate, amount, paymentType];

  @override
  String toString() {
    return 'Installment #$installmentNumber: \$${amount.toStringAsFixed(2)} due on ${dueDate.toString().split(' ')[0]}';
  }
}
