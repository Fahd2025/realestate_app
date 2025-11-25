import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_bloc.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_event.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_state.dart';
import 'package:realestate_app/features/contracts/data/repositories/contracts_repository.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import 'package:realestate_app/features/contracts/widgets/contract_form_modal.dart';
import 'package:realestate_app/core/widgets/confirmation_dialog.dart';
import 'package:realestate_app/features/contracts/utils/contract_pdf_generator.dart';
import 'package:realestate_app/features/auth/bloc/auth_bloc.dart';
import 'package:realestate_app/features/payments/widgets/contract_payments_modal.dart';
import 'package:realestate_app/features/payments/bloc/payments_bloc.dart';
import 'package:realestate_app/features/payments/data/repositories/payments_repository.dart';
import 'package:realestate_app/core/widgets/main_layout.dart';

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
    final contractsBloc = context.read<ContractsBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: contractsBloc,
        child: ContractFormModal(
          contract: contract,
          initialType: widget.contractType,
        ),
      ),
    );
  }

  void _deleteContract(BuildContext context, String id) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: l10n.deleteContract,
        message: l10n.deleteContractConfirmation,
        onConfirm: () {
          context.read<ContractsBloc>().add(DeleteContract(id));
        },
      ),
    );
  }

  String _getShortString(String str, int length) {
    return str.length > length ? str.substring(0, length) : str;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MainLayout(
      title: widget.contractType == 'purchase'
          ? l10n.purchaseContracts
          : l10n.leaseContracts,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showForm(context),
        ),
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
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
                    return Center(child: Text(l10n.noContractsFound));
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final isLargeScreen = constraints.maxWidth >= 900;

                      if (isLargeScreen) {
                        return _buildDataTable(state.filteredContracts);
                      } else {
                        return _buildMobileList(state.filteredContracts);
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

  Widget _buildDataTable(List<ContractWithDetails> contractsWithDetails) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text(l10n.contractId)),
            DataColumn(label: Text(l10n.property)),
            DataColumn(label: Text(l10n.owner)),
            DataColumn(
                label: Text(
                    widget.contractType == 'lease' ? l10n.tenant : l10n.buyer)),
            DataColumn(label: Text(l10n.startDate)),
            DataColumn(label: Text(l10n.amount)),
            DataColumn(label: Text(l10n.status)),
            DataColumn(label: Text(l10n.actions)),
          ],
          rows: contractsWithDetails.map((item) {
            final contract = item.contract;
            final property = item.property;
            final owner = item.owner;
            final tenantBuyer = item.tenantBuyer;

            return DataRow(cells: [
              DataCell(Text(_getShortString(contract.id, 8))),
              DataCell(Text(property.title)),
              DataCell(Text(owner?.fullName ?? 'N/A')),
              DataCell(Text(tenantBuyer?.fullName ?? 'N/A')),
              DataCell(Text(contract.startDate.toString().split(' ')[0])),
              DataCell(Text(widget.contractType == 'lease'
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
                      ContractPdfGenerator.printContract(contract, l10n);
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
      ),
    );
  }

  Widget _buildMobileList(List<ContractWithDetails> contractsWithDetails) {
    final l10n = AppLocalizations.of(context)!;
    return ListView.builder(
      itemCount: contractsWithDetails.length,
      itemBuilder: (context, index) {
        final item = contractsWithDetails[index];
        final contract = item.contract;
        final property = item.property;
        final owner = item.owner;
        final tenantBuyer = item.tenantBuyer;

        return Card(
          child: ExpansionTile(
            title: Text('${l10n.contract} ${_getShortString(contract.id, 8)}'),
            subtitle: Text(property.title),
            children: [
              ListTile(
                title: Text(l10n.property),
                subtitle: Text(property.title),
              ),
              ListTile(
                title: Text(l10n.owner),
                subtitle: Text(owner?.fullName ?? 'N/A'),
              ),
              ListTile(
                title: Text(
                    widget.contractType == 'lease' ? l10n.tenant : l10n.buyer),
                subtitle: Text(tenantBuyer?.fullName ?? 'N/A'),
              ),
              ListTile(
                title: Text(l10n.startDate),
                subtitle: Text(contract.startDate.toString().split(' ')[0]),
              ),
              ListTile(
                title: Text(l10n.amount),
                subtitle: Text(widget.contractType == 'lease'
                    ? '${l10n.monthly}: ${contract.monthlyRent}'
                    : '${l10n.price}: ${contract.salePrice}'),
              ),
              ListTile(
                title: Text(l10n.status),
                subtitle: Text(contract.status),
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _showForm(context, contract: contract),
                    child: Text(l10n.edit),
                  ),
                  TextButton(
                    onPressed: () => _deleteContract(context, contract.id),
                    child: Text(l10n.delete),
                  ),
                  TextButton(
                    onPressed: () {
                      ContractPdfGenerator.printContract(contract, l10n);
                    },
                    child: Text(l10n.generatePDF),
                  ),
                  TextButton(
                    onPressed: () => _showPayments(context, contract),
                    child: Text(l10n.payments),
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
