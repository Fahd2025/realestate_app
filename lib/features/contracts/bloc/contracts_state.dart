import 'package:equatable/equatable.dart';
import 'package:realestate_app/features/contracts/data/repositories/contracts_repository.dart';

abstract class ContractsState extends Equatable {
  const ContractsState();

  @override
  List<Object?> get props => [];
}

class ContractsInitial extends ContractsState {}

class ContractsLoading extends ContractsState {}

class ContractsLoaded extends ContractsState {
  final List<ContractWithDetails> contractsWithDetails;
  final List<ContractWithDetails> filteredContracts;

  const ContractsLoaded(this.contractsWithDetails,
      {List<ContractWithDetails>? filteredContracts})
      : filteredContracts = filteredContracts ?? contractsWithDetails;

  @override
  List<Object?> get props => [contractsWithDetails, filteredContracts];
}

class ContractsError extends ContractsState {
  final String message;

  const ContractsError(this.message);

  @override
  List<Object?> get props => [message];
}
