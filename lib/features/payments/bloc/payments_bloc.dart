import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/features/payments/data/repositories/payments_repository.dart';
import 'payments_event.dart';
import 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final PaymentsRepository _repository;
  StreamSubscription? _paymentsSubscription;

  PaymentsBloc(this._repository) : super(PaymentsInitial()) {
    on<LoadPayments>(_onLoadPayments);
    on<AddPayment>(_onAddPayment);
    on<UpdatePayment>(_onUpdatePayment);
    on<DeletePayment>(_onDeletePayment);
    on<_PaymentsUpdated>(_onPaymentsUpdated);
  }

  void _onLoadPayments(LoadPayments event, Emitter<PaymentsState> emit) {
    emit(PaymentsLoading());
    _paymentsSubscription?.cancel();
    _paymentsSubscription =
        _repository.watchPaymentsForContract(event.contractId).listen(
      (payments) {
        add(_PaymentsUpdated(payments));
      },
      onError: (error) {
        // Handle error
      },
    );
  }

  Future<void> _onPaymentsUpdated(
      _PaymentsUpdated event, Emitter<PaymentsState> emit) async {
    emit(PaymentsLoaded(event.payments));
  }

  Future<void> _onAddPayment(
      AddPayment event, Emitter<PaymentsState> emit) async {
    try {
      await _repository.createPayment(event.payment);
    } catch (e) {
      emit(PaymentsError(e.toString()));
    }
  }

  Future<void> _onUpdatePayment(
      UpdatePayment event, Emitter<PaymentsState> emit) async {
    try {
      await _repository.updatePayment(event.payment);
    } catch (e) {
      emit(PaymentsError(e.toString()));
    }
  }

  Future<void> _onDeletePayment(
      DeletePayment event, Emitter<PaymentsState> emit) async {
    try {
      await _repository.deletePayment(event.id);
    } catch (e) {
      emit(PaymentsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _paymentsSubscription?.cancel();
    return super.close();
  }
}

class _PaymentsUpdated extends PaymentsEvent {
  final List<Payment> payments;
  const _PaymentsUpdated(this.payments);
  @override
  List<Object?> get props => [payments];
}
