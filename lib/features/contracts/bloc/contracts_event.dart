import 'package:equatable/equatable.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/core/models/enums.dart';

abstract class ContractsEvent extends Equatable {
  const ContractsEvent();

  @override
  List<Object?> get props => [];
}

class LoadContracts extends ContractsEvent {
  final String? type; // 'buy' or 'rent'
  final String? userId;
  final UserRole? role;

  const LoadContracts({this.type, this.userId, this.role});

  @override
  List<Object?> get props => [type, userId, role];
}

class AddContract extends ContractsEvent {
  final ContractsCompanion contract;

  const AddContract(this.contract);

  @override
  List<Object?> get props => [contract];
}

class UpdateContract extends ContractsEvent {
  final ContractsCompanion contract;

  const UpdateContract(this.contract);

  @override
  List<Object?> get props => [contract];
}

class DeleteContract extends ContractsEvent {
  final String id;

  const DeleteContract(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchContracts extends ContractsEvent {
  final String query;

  const SearchContracts(this.query);

  @override
  List<Object?> get props => [query];
}
