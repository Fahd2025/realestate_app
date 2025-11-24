import 'package:equatable/equatable.dart';
import 'package:realestate_app/core/database/database.dart';

abstract class ContractsState extends Equatable {
  const ContractsState();

  @override
  List<Object?> get props => [];
}

class ContractsInitial extends ContractsState {}

class ContractsLoading extends ContractsState {}

class ContractsLoaded extends ContractsState {
  final List<Contract> contracts;
  final List<Contract> filteredContracts;

  const ContractsLoaded(this.contracts, {List<Contract>? filteredContracts})
      : filteredContracts = filteredContracts ?? contracts;

  @override
  List<Object?> get props => [contracts, filteredContracts];
}

class ContractsError extends ContractsState {
  final String message;

  const ContractsError(this.message);

  @override
  List<Object?> get props => [message];
}
