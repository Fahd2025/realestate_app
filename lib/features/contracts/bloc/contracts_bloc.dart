import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/features/contracts/data/repositories/contracts_repository.dart';
import 'package:realestate_app/features/payments/data/repositories/payments_repository.dart';
import 'package:realestate_app/features/payments/services/installment_service.dart';
import 'package:realestate_app/features/payments/models/payment_frequency.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import 'contracts_event.dart';
import 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final ContractsRepository _repository;
  final PaymentsRepository _paymentsRepository;
  StreamSubscription? _contractsSubscription;

  ContractsBloc(this._repository, this._paymentsRepository)
      : super(ContractsInitial()) {
    on<LoadContracts>(_onLoadContracts);
    on<AddContract>(_onAddContract);
    on<UpdateContract>(_onUpdateContract);
    on<DeleteContract>(_onDeleteContract);
    on<SearchContracts>(_onSearchContracts);
    on<_ContractsUpdated>(_onContractsUpdated);
  }

  void _onLoadContracts(LoadContracts event, Emitter<ContractsState> emit) {
    emit(ContractsLoading());
    _contractsSubscription?.cancel();
    _contractsSubscription =
        _repository.watchContracts(type: event.type).listen(
      (contracts) {
        add(_ContractsUpdated(contracts));
      },
      onError: (error) {
        // We can't emit from here directly if we use a separate event handler for updates
        // But for simplicity, let's use a private event to update state
      },
    );
  }

  // Private event to handle stream updates
  Future<void> _onContractsUpdated(
      _ContractsUpdated event, Emitter<ContractsState> emit) async {
    emit(ContractsLoaded(event.contracts));
  }

  Future<void> _onAddContract(
      AddContract event, Emitter<ContractsState> emit) async {
    try {
      // Create the contract
      await _repository.createContract(event.contract);

      // Auto-generate payment schedule if contract has valid dates and amount
      await _generatePaymentSchedule(event.contract);

      // Stream will update the state
    } catch (e) {
      emit(ContractsError(e.toString()));
    }
  }

  Future<void> _generatePaymentSchedule(ContractsCompanion contract) async {
    try {
      // Extract values from companion
      final contractId = contract.id.value;
      final payerId = contract.tenantBuyerId.value;
      final startDate = contract.startDate.value;
      final endDate = contract.endDate.value;
      final paymentFrequencyStr = contract.paymentFrequency.value;
      final customFrequencyDays = contract.customFrequencyDays.value;

      if (endDate == null) return; // No end date, skip schedule generation

      final paymentFrequency = PaymentFrequency.fromString(paymentFrequencyStr);
      final contractType = contract.contractType.value;

      // Determine total amount based on contract type
      double totalAmount;
      String paymentType;

      if (contractType == 'lease') {
        totalAmount = contract.monthlyRent.value ?? 0;
        paymentType = 'lease';
      } else {
        totalAmount = contract.salePrice.value ?? 0;
        paymentType = 'installment';
      }

      if (totalAmount <= 0) return; // No amount, skip schedule generation

      // Generate schedule
      final schedule = InstallmentService.generateSchedule(
        totalAmount: totalAmount,
        frequency: paymentFrequency,
        startDate: startDate,
        endDate: endDate,
        paymentType: paymentType,
        customFrequencyDays: customFrequencyDays,
      );

      // Create payment records
      for (final item in schedule) {
        final payment = PaymentsCompanion(
          id: drift.Value(const Uuid().v4()),
          contractId: drift.Value(contractId),
          payerId: drift.Value(payerId),
          amount: drift.Value(item.amount),
          paymentDate: drift.Value(DateTime.now()), // Will be updated when paid
          dueDate: drift.Value(item.dueDate),
          paymentType: drift.Value(item.paymentType),
          status: const drift.Value('pending'),
          createdAt: drift.Value(DateTime.now()),
          updatedAt: drift.Value(DateTime.now()),
        );

        await _paymentsRepository.createPayment(payment);
      }
    } catch (e) {
      // Log error but don't fail contract creation
      print('Error generating payment schedule: $e');
    }
  }

  Future<void> _onUpdateContract(
      UpdateContract event, Emitter<ContractsState> emit) async {
    try {
      await _repository.updateContract(event.contract);
    } catch (e) {
      emit(ContractsError(e.toString()));
    }
  }

  Future<void> _onDeleteContract(
      DeleteContract event, Emitter<ContractsState> emit) async {
    try {
      await _repository.deleteContract(event.id);
    } catch (e) {
      emit(ContractsError(e.toString()));
    }
  }

  void _onSearchContracts(SearchContracts event, Emitter<ContractsState> emit) {
    final state = this.state;
    if (state is ContractsLoaded) {
      final query = event.query.toLowerCase();
      final filtered = state.contracts.where((contract) {
        // Basic search on ID, terms, description.
        // Ideally we would search on joined property title or user name too.
        return contract.id.toLowerCase().contains(query) ||
            (contract.terms?.toLowerCase().contains(query) ?? false) ||
            (contract.description?.toLowerCase().contains(query) ?? false);
      }).toList();
      emit(ContractsLoaded(state.contracts, filteredContracts: filtered));
    }
  }

  @override
  Future<void> close() {
    _contractsSubscription?.cancel();
    return super.close();
  }
}

class _ContractsUpdated extends ContractsEvent {
  final List<Contract> contracts;
  const _ContractsUpdated(this.contracts);
  @override
  List<Object?> get props => [contracts];
}
