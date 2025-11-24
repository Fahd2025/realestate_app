import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_bloc.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_event.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'package:image_picker/image_picker.dart';
import 'package:realestate_app/features/payments/models/payment_frequency.dart';
import 'package:realestate_app/features/payments/services/installment_service.dart';
import 'package:realestate_app/features/payments/models/payment_schedule_item.dart';

class ContractFormModal extends StatefulWidget {
  final Contract? contract;
  final String? initialType;

  const ContractFormModal({super.key, this.contract, this.initialType});

  @override
  State<ContractFormModal> createState() => _ContractFormModalState();
}

class _ContractFormModalState extends State<ContractFormModal> {
  final _formKey = GlobalKey<FormState>();
  late String _contractType;
  late TextEditingController _propertyIdController;
  late TextEditingController _ownerIdController;
  late TextEditingController _tenantBuyerIdController;
  late TextEditingController _monthlyRentController;
  late TextEditingController _salePriceController;
  late TextEditingController _depositAmountController;
  late TextEditingController _termsController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;
  late TextEditingController _concessionsController;
  late TextEditingController _customFrequencyController;
  String? _fileUrl;
  PaymentFrequency _paymentFrequency = PaymentFrequency.monthly;

  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _contractType =
        widget.contract?.contractType ?? widget.initialType ?? 'rent';
    _propertyIdController =
        TextEditingController(text: widget.contract?.propertyId);
    _ownerIdController = TextEditingController(text: widget.contract?.ownerId);
    _tenantBuyerIdController =
        TextEditingController(text: widget.contract?.tenantBuyerId);
    _monthlyRentController =
        TextEditingController(text: widget.contract?.monthlyRent?.toString());
    _salePriceController =
        TextEditingController(text: widget.contract?.salePrice?.toString());
    _depositAmountController =
        TextEditingController(text: widget.contract?.depositAmount?.toString());
    _termsController = TextEditingController(text: widget.contract?.terms);
    _descriptionController =
        TextEditingController(text: widget.contract?.description);
    _descriptionArController =
        TextEditingController(text: widget.contract?.descriptionAr);
    _concessionsController =
        TextEditingController(text: widget.contract?.concessions);
    _customFrequencyController = TextEditingController();
    _fileUrl = widget.contract?.fileUrl;

    if (widget.contract != null) {
      _paymentFrequency = PaymentFrequency.fromString(
        widget.contract!.paymentFrequency,
      );
      if (widget.contract!.customFrequencyDays != null) {
        _customFrequencyController.text =
            widget.contract!.customFrequencyDays.toString();
      }
    }

    if (widget.contract != null) {
      _startDate = widget.contract!.startDate;
      _endDate = widget.contract!.endDate;
    }
  }

  @override
  void dispose() {
    _propertyIdController.dispose();
    _ownerIdController.dispose();
    _tenantBuyerIdController.dispose();
    _monthlyRentController.dispose();
    _salePriceController.dispose();
    _depositAmountController.dispose();
    _termsController.dispose();
    _descriptionController.dispose();
    _descriptionArController.dispose();
    _concessionsController.dispose();
    _customFrequencyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _fileUrl = pickedFile.path;
      });
    }
  }

  void _showSchedulePreview() {
    if (_endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an end date first')),
      );
      return;
    }

    final totalAmount = _contractType == 'rent'
        ? double.tryParse(_monthlyRentController.text) ?? 0
        : double.tryParse(_salePriceController.text) ?? 0;

    if (totalAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final validationError = InstallmentService.validateScheduleParameters(
      totalAmount: totalAmount,
      frequency: _paymentFrequency,
      startDate: _startDate,
      endDate: _endDate!,
      customFrequencyDays: _paymentFrequency == PaymentFrequency.custom
          ? int.tryParse(_customFrequencyController.text)
          : null,
    );

    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return;
    }

    final schedule = InstallmentService.generateSchedule(
      totalAmount: totalAmount,
      frequency: _paymentFrequency,
      startDate: _startDate,
      endDate: _endDate!,
      paymentType: _contractType == 'rent' ? 'rent' : 'installment',
      customFrequencyDays: _paymentFrequency == PaymentFrequency.custom
          ? int.tryParse(_customFrequencyController.text)
          : null,
    );

    showDialog(
      context: context,
      builder: (context) => _SchedulePreviewDialog(schedule: schedule),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final contract = ContractsCompanion(
        id: drift.Value(widget.contract?.id ?? const Uuid().v4()),
        propertyId: drift.Value(_propertyIdController.text),
        ownerId: drift.Value(_ownerIdController.text),
        tenantBuyerId: drift.Value(_tenantBuyerIdController.text),
        contractType: drift.Value(_contractType),
        startDate: drift.Value(_startDate),
        endDate: drift.Value(_endDate),
        monthlyRent: drift.Value(double.tryParse(_monthlyRentController.text)),
        salePrice: drift.Value(double.tryParse(_salePriceController.text)),
        depositAmount:
            drift.Value(double.tryParse(_depositAmountController.text)),
        terms: drift.Value(_termsController.text),
        description: drift.Value(_descriptionController.text),
        descriptionAr: drift.Value(_descriptionArController.text),
        concessions: drift.Value(_concessionsController.text),
        fileUrl: drift.Value(_fileUrl),
        paymentFrequency: drift.Value(_paymentFrequency.toDbString()),
        customFrequencyDays: drift.Value(
          _paymentFrequency == PaymentFrequency.custom
              ? int.tryParse(_customFrequencyController.text)
              : null,
        ),
        createdAt: drift.Value(widget.contract?.createdAt ?? DateTime.now()),
        updatedAt: drift.Value(DateTime.now()),
      );

      if (widget.contract == null) {
        context.read<ContractsBloc>().add(AddContract(contract));
      } else {
        context.read<ContractsBloc>().add(UpdateContract(contract));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              widget.contract == null ? 'New Contract' : 'Edit Contract',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _contractType,
              items: const [
                DropdownMenuItem(value: 'rent', child: Text('Rent')),
                DropdownMenuItem(value: 'buy', child: Text('Buy')),
              ],
              onChanged: (value) {
                setState(() {
                  _contractType = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Contract Type'),
            ),
            const SizedBox(height: 16),
            // TODO: Replace with Dropdowns/Search for Property, Owner, Tenant
            TextFormField(
              controller: _propertyIdController,
              decoration: const InputDecoration(labelText: 'Property ID'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ownerIdController,
              decoration: const InputDecoration(labelText: 'Owner ID'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tenantBuyerIdController,
              decoration: const InputDecoration(labelText: 'Tenant/Buyer ID'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            if (_contractType == 'rent') ...[
              TextFormField(
                controller: _monthlyRentController,
                decoration: const InputDecoration(labelText: 'Monthly Rent'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
            ] else ...[
              TextFormField(
                controller: _salePriceController,
                decoration: const InputDecoration(labelText: 'Sale Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              controller: _depositAmountController,
              decoration: const InputDecoration(labelText: 'Deposit Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Start Date'),
              subtitle: Text(_startDate.toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() => _startDate = date);
                }
              },
            ),
            ListTile(
              title: const Text('End Date'),
              subtitle:
                  Text(_endDate?.toString().split(' ')[0] ?? 'Select Date'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? _startDate,
                  firstDate: _startDate,
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() => _endDate = date);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description (En)'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionArController,
              decoration: const InputDecoration(labelText: 'Description (Ar)'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _termsController,
              decoration: const InputDecoration(labelText: 'Terms'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _concessionsController,
              decoration: const InputDecoration(labelText: 'Concessions'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_fileUrl == null
                  ? 'Upload Contract Image'
                  : 'Image Selected'),
              subtitle: _fileUrl != null ? Text(_fileUrl!) : null,
              trailing: const Icon(Icons.upload_file),
              onTap: _pickImage,
            ),
            const SizedBox(height: 16),

            // Payment Frequency Section
            Text(
              'Payment Schedule',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<PaymentFrequency>(
              value: _paymentFrequency,
              items: PaymentFrequency.values.map((freq) {
                return DropdownMenuItem(
                  value: freq,
                  child: Text(freq.displayName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _paymentFrequency = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Payment Frequency'),
            ),
            if (_paymentFrequency == PaymentFrequency.custom) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _customFrequencyController,
                decoration: const InputDecoration(
                  labelText: 'Custom Frequency (days)',
                  hintText: 'e.g., 45',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_paymentFrequency == PaymentFrequency.custom) {
                    if (value == null || value.isEmpty) {
                      return 'Required for custom frequency';
                    }
                    final days = int.tryParse(value);
                    if (days == null || days <= 0) {
                      return 'Must be a positive number';
                    }
                  }
                  return null;
                },
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _showSchedulePreview,
              icon: const Icon(Icons.calendar_month),
              label: const Text('Preview Payment Schedule'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              child: Text(widget.contract == null ? 'Create' : 'Update'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Schedule Preview Dialog Widget
class _SchedulePreviewDialog extends StatelessWidget {
  final List<PaymentScheduleItem> schedule;

  const _SchedulePreviewDialog({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Payment Schedule Preview'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: schedule.length,
          itemBuilder: (context, index) {
            final item = schedule[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text('${item.installmentNumber}'),
              ),
              title: Text('\$${item.amount.toStringAsFixed(2)}'),
              subtitle: Text('Due: ${item.dueDate.toString().split(' ')[0]}'),
              trailing: Chip(
                label: Text(item.paymentType.toUpperCase()),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
