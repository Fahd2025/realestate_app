import 'package:equatable/equatable.dart';

class PaymentResult extends Equatable {
  final bool success;
  final String? transactionId;
  final String? errorMessage;
  final DateTime timestamp;

  const PaymentResult({
    required this.success,
    this.transactionId,
    this.errorMessage,
    required this.timestamp,
  });

  factory PaymentResult.success(String transactionId) {
    return PaymentResult(
      success: true,
      transactionId: transactionId,
      timestamp: DateTime.now(),
    );
  }

  factory PaymentResult.failure(String errorMessage) {
    return PaymentResult(
      success: false,
      errorMessage: errorMessage,
      timestamp: DateTime.now(),
    );
  }

  String get message => success ? 'Transaction successful' : (errorMessage ?? 'Unknown error');

  @override
  List<Object?> get props => [success, transactionId, errorMessage, timestamp];
}
