import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/features/payments/bloc/payments_bloc.dart';
import 'package:realestate_app/features/payments/bloc/payments_event.dart';
import 'package:realestate_app/features/payments/bloc/payments_state.dart';
import 'package:realestate_app/features/payments/services/payment_processor.dart';
import 'package:realestate_app/features/payments/services/payment_receipt_generator.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;

class ContractPaymentsModal extends StatefulWidget {
  final String contractId;
  final String payerId; // Tenant or Buyer ID

  const ContractPaymentsModal({
    super.key,
    required this.contractId,
    required this.payerId,
  });

  @override
  State<ContractPaymentsModal> createState() => _ContractPaymentsModalState();
}

class _ContractPaymentsModalState extends State<ContractPaymentsModal> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentsBloc>().add(LoadPayments(widget.contractId));
  }

  void _showAddPaymentForm(BuildContext context) {
    final paymentsBloc = context.read<PaymentsBloc>();
    showDialog(
      context: context,
      builder: (dialogContext) => _AddPaymentDialog(
        contractId: widget.contractId,
        payerId: widget.payerId,
        bloc: paymentsBloc,
      ),
    );
  }

  void _processPayment(Payment payment, AppLocalizations l10n) async {
    if (context.mounted) {
      // Show loading indicator
      final snackBar = SnackBar(
        content: Row(
          children: [
            const CircularProgressIndicator(strokeWidth: 2),
            const SizedBox(width: 12),
            Text(l10n.processingPayment),
          ],
        ),
        duration: const Duration(seconds: 10),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final result = await PaymentProcessor.processPayment(
      paymentId: payment.id,
      amount: payment.amount,
    );

    // Dismiss the loading snackbar
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }

    if (result.success) {
      // Update payment status to completed
      final updatedPayment = PaymentsCompanion(
        id: drift.Value(payment.id),
        status: const drift.Value('completed'),
        paymentDate: drift.Value(DateTime.now()),
        updatedAt: drift.Value(DateTime.now()),
      );

      context.read<PaymentsBloc>().add(UpdatePayment(updatedPayment));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.paymentProcessedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.paymentFailed}: ${result.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _downloadReceipt(Payment payment, AppLocalizations l10n) async {
    await PaymentReceiptGenerator.generateAndDownloadReceipt(payment, l10n);
  }

  String _getLocalizedPaymentType(String type, AppLocalizations l10n) {
    switch (type) {
      case 'lease':
        return l10n.lease;
      case 'deposit':
        return l10n.deposit;
      case 'installment':
        return l10n.installment;
      default:
        return type;
    }
  }

  String _getLocalizedStatus(String status, AppLocalizations l10n) {
    switch (status) {
      case 'pending':
        return l10n.pending;
      case 'completed':
        return l10n.completed;
      case 'overdue':
        return l10n.overdue;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.paymentsInstallments,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddPaymentForm(context),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: BlocBuilder<PaymentsBloc, PaymentsState>(
              builder: (context, state) {
                if (state is PaymentsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PaymentsError) {
                  return Center(child: Text('${l10n.error}: ${state.message}'));
                } else if (state is PaymentsLoaded) {
                  if (state.payments.isEmpty) {
                    return Center(child: Text(l10n.noPaymentsRecorded));
                  }
                  return ListView.builder(
                    itemCount: state.payments.length,
                    itemBuilder: (context, index) {
                      final payment = state.payments[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${payment.amount} - ${_getLocalizedPaymentType(payment.paymentType, l10n)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Text(
                                          '${l10n.dueDate}: ${payment.dueDate?.toString().split(' ')[0] ?? 'N/A'} | ${l10n.status}: ${_getLocalizedStatus(payment.status, l10n)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context
                                          .read<PaymentsBloc>()
                                          .add(DeletePayment(payment.id));
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  if (payment.status == 'pending')
                                    ElevatedButton.icon(
                                      onPressed: () =>
                                          _processPayment(payment, l10n),
                                      icon: const Icon(Icons.payment),
                                      label: Text(l10n.payNow),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  const SizedBox(width: 8),
                                  if (payment.status == 'completed')
                                    ElevatedButton.icon(
                                      onPressed: () =>
                                          _downloadReceipt(payment, l10n),
                                      icon: const Icon(Icons.download),
                                      label: Text(l10n.receipt),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
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
}

class _AddPaymentDialog extends StatefulWidget {
  final String contractId;
  final String payerId;
  final PaymentsBloc bloc;

  const _AddPaymentDialog({
    required this.contractId,
    required this.payerId,
    required this.bloc,
  });

  @override
  State<_AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<_AddPaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _dueDate = DateTime.now();
  String _paymentType = 'lease'; // lease, deposit, installment
  String _status = 'pending';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.addPayment),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: l10n.amount),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? l10n.required : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _paymentType,
                items: [
                  DropdownMenuItem(value: 'lease', child: Text(l10n.lease)),
                  DropdownMenuItem(value: 'deposit', child: Text(l10n.deposit)),
                  DropdownMenuItem(
                      value: 'installment', child: Text(l10n.installment)),
                ],
                onChanged: (value) => setState(() => _paymentType = value!),
                decoration: InputDecoration(labelText: l10n.type),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(l10n.dueDate),
                subtitle: Text(_dueDate.toString().split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() => _dueDate = date);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _status,
                items: [
                  DropdownMenuItem(value: 'pending', child: Text(l10n.pending)),
                  DropdownMenuItem(
                      value: 'completed', child: Text(l10n.completed)),
                  DropdownMenuItem(value: 'overdue', child: Text(l10n.overdue)),
                ],
                onChanged: (value) => setState(() => _status = value!),
                decoration: InputDecoration(labelText: l10n.status),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: l10n.notes),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final payment = PaymentsCompanion(
                id: drift.Value(const Uuid().v4()),
                contractId: drift.Value(widget.contractId),
                payerId: drift.Value(widget.payerId),
                amount: drift.Value(double.parse(_amountController.text)),
                paymentDate: drift.Value(DateTime.now()),
                dueDate: drift.Value(_dueDate),
                paymentType: drift.Value(_paymentType),
                paymentMethod: const drift.Value(null),
                status: drift.Value(_status),
                notes: drift.Value(_notesController.text),
                createdAt: drift.Value(DateTime.now()),
                updatedAt: drift.Value(DateTime.now()),
                syncStatus: const drift.Value('synced'),
              );
              widget.bloc.add(AddPayment(payment));
              Navigator.pop(context);
            }
          },
          child: Text(l10n.add),
        ),
      ],
    );
  }
}
