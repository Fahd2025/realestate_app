import 'package:equatable/equatable.dart';
import 'package:realestate_app/core/database/database.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPayments extends PaymentsEvent {
  final String contractId;

  const LoadPayments(this.contractId);

  @override
  List<Object?> get props => [contractId];
}

class AddPayment extends PaymentsEvent {
  final PaymentsCompanion payment;

  const AddPayment(this.payment);

  @override
  List<Object?> get props => [payment];
}

class UpdatePayment extends PaymentsEvent {
  final PaymentsCompanion payment;

  const UpdatePayment(this.payment);

  @override
  List<Object?> get props => [payment];
}

class DeletePayment extends PaymentsEvent {
  final String id;

  const DeletePayment(this.id);

  @override
  List<Object?> get props => [id];
}
