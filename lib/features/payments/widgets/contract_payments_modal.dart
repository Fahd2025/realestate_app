import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/features/payments/bloc/payments_bloc.dart';
import 'package:realestate_app/features/payments/bloc/payments_event.dart';
import 'package:realestate_app/features/payments/bloc/payments_state.dart';
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
    showDialog(
      context: context,
      builder: (context) => _AddPaymentDialog(
        contractId: widget.contractId,
        payerId: widget.payerId,
        bloc: context.read<PaymentsBloc>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payments / Installments',
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
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is PaymentsLoaded) {
                  if (state.payments.isEmpty) {
                    return const Center(child: Text('No payments recorded.'));
                  }
                  return ListView.builder(
                    itemCount: state.payments.length,
                    itemBuilder: (context, index) {
                      final payment = state.payments[index];
                      return ListTile(
                        title:
                            Text('${payment.amount} - ${payment.paymentType}'),
                        subtitle: Text(
                            'Due: ${payment.dueDate?.toString().split(' ')[0] ?? 'N/A'} | Status: ${payment.status}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<PaymentsBloc>()
                                .add(DeletePayment(payment.id));
                          },
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
  String _paymentType = 'rent'; // rent, deposit, installment
  String _status = 'pending';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Payment'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _paymentType,
                items: const [
                  DropdownMenuItem(value: 'rent', child: Text('Rent')),
                  DropdownMenuItem(value: 'deposit', child: Text('Deposit')),
                  DropdownMenuItem(
                      value: 'installment', child: Text('Installment')),
                ],
                onChanged: (value) => setState(() => _paymentType = value!),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Due Date'),
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
                value: _status,
                items: const [
                  DropdownMenuItem(value: 'pending', child: Text('Pending')),
                  DropdownMenuItem(
                      value: 'completed', child: Text('Completed')),
                  DropdownMenuItem(value: 'overdue', child: Text('Overdue')),
                ],
                onChanged: (value) => setState(() => _status = value!),
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
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
                status: drift.Value(_status),
                notes: drift.Value(_notesController.text),
                createdAt: drift.Value(DateTime.now()),
                updatedAt: drift.Value(DateTime.now()),
              );
              widget.bloc.add(AddPayment(payment));
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
