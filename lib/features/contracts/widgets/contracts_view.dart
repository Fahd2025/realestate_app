import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_bloc.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_event.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_state.dart';
import 'package:realestate_app/features/contracts/widgets/contract_form_modal.dart';
import 'package:realestate_app/core/widgets/confirmation_dialog.dart';
import 'package:realestate_app/features/contracts/utils/contract_pdf_generator.dart';
import 'package:realestate_app/features/auth/bloc/auth_bloc.dart';
import 'package:realestate_app/features/payments/widgets/contract_payments_modal.dart';
import 'package:realestate_app/features/payments/bloc/payments_bloc.dart';
import 'package:realestate_app/features/payments/data/repositories/payments_repository.dart';

class ContractsView extends StatefulWidget {
  final String contractType; // 'buy' or 'rent'

  const ContractsView({super.key, required this.contractType});

  @override
  State<ContractsView> createState() => _ContractsViewState();
}

class _ContractsViewState extends State<ContractsView> {
  @override
  void initState() {
    super.initState();
    context.read<ContractsBloc>().add(LoadContracts(type: widget.contractType));
  }

  void _showForm(BuildContext context, {Contract? contract}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ContractFormModal(
        contract: contract,
        initialType: widget.contractType,
      ),
    );
  }

  void _deleteContract(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: 'Delete Contract',
        message: 'Are you sure you want to delete this contract?',
        onConfirm: () {
          context.read<ContractsBloc>().add(DeleteContract(id));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.contractType == 'buy' ? 'Buy Contracts' : 'Rent Contracts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showForm(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<ContractsBloc>().add(SearchContracts(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ContractsBloc, ContractsState>(
              builder: (context, state) {
                if (state is ContractsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ContractsError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is ContractsLoaded) {
                  final contracts = state.filteredContracts;
                  if (contracts.isEmpty) {
                    return const Center(child: Text('No contracts found.'));
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return _buildDataTable(contracts);
                      } else {
                        return _buildMobileList(contracts);
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<Contract> contracts) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Property')),
          DataColumn(label: Text('Start Date')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: contracts.map((contract) {
          return DataRow(cells: [
            DataCell(Text(contract.id.substring(0, 8))),
            DataCell(Text(contract.propertyId
                .substring(0, 8))), // TODO: Show Property Title
            DataCell(Text(contract.startDate.toString().split(' ')[0])),
            DataCell(Text(widget.contractType == 'rent'
                ? '${contract.monthlyRent}/mo'
                : '${contract.salePrice}')),
            DataCell(Text(contract.status)),
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showForm(context, contract: contract),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteContract(context, contract.id),
                ),
                IconButton(
                  icon: const Icon(Icons.picture_as_pdf),
                  onPressed: () {
                    ContractPdfGenerator.printContract(contract);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.payment),
                  onPressed: () => _showPayments(context, contract),
                ),
              ],
            )),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildMobileList(List<Contract> contracts) {
    return ListView.builder(
      itemCount: contracts.length,
      itemBuilder: (context, index) {
        final contract = contracts[index];
        return Card(
          child: ExpansionTile(
            title: Text('Contract ${contract.id.substring(0, 8)}'),
            subtitle: Text(contract.startDate.toString().split(' ')[0]),
            children: [
              ListTile(
                title: const Text('Property ID'),
                subtitle: Text(contract.propertyId),
              ),
              ListTile(
                title: const Text('Amount'),
                subtitle: Text(widget.contractType == 'rent'
                    ? '${contract.monthlyRent}/mo'
                    : '${contract.salePrice}'),
              ),
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () => _showForm(context, contract: contract),
                    child: const Text('Edit'),
                  ),
                  TextButton(
                    onPressed: () => _deleteContract(context, contract.id),
                    child: const Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () {
                      ContractPdfGenerator.printContract(contract);
                    },
                    child: const Text('PDF'),
                  ),
                  TextButton(
                    onPressed: () => _showPayments(context, contract),
                    child: const Text('Payments'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPayments(BuildContext context, Contract contract) {
    final database = context.read<AuthBloc>().database;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BlocProvider(
        create: (context) => PaymentsBloc(PaymentsRepository(database)),
        child: ContractPaymentsModal(
          contractId: contract.id,
          payerId: contract.tenantBuyerId,
        ),
      ),
    );
  }
}
