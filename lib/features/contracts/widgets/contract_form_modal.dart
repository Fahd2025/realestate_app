import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_bloc.dart';
import 'package:realestate_app/features/contracts/bloc/contracts_event.dart';
import 'package:realestate_app/features/auth/bloc/auth_bloc.dart';
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
  late TextEditingController _monthlyLeaseController;
  late TextEditingController _purchasePriceController;
  late TextEditingController _depositAmountController;
  late TextEditingController _termsController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;
  late TextEditingController _concessionsController;
  late TextEditingController _customFrequencyController;
  String? _fileUrl;
  PaymentFrequency _paymentFrequency = PaymentFrequency.monthly;

  // Dropdown data
  List<User> _owners = [];
  List<Property> _properties = [];
  List<User> _tenants = [];
  List<User> _buyers = [];

  String? _selectedOwnerId;
  String? _selectedPropertyId;
  String? _selectedTenantBuyerId;

  bool _isLoadingData = true;

  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _contractType =
        widget.contract?.contractType ?? widget.initialType ?? 'lease';

    _monthlyLeaseController = TextEditingController(
      text: widget.contract?.monthlyRent?.toString(),
    );
    _purchasePriceController = TextEditingController(
      text: widget.contract?.salePrice?.toString(),
    );
    _depositAmountController = TextEditingController(
      text: widget.contract?.depositAmount?.toString(),
    );
    _termsController = TextEditingController(text: widget.contract?.terms);
    _descriptionController = TextEditingController(
      text: widget.contract?.description,
    );
    _descriptionArController = TextEditingController(
      text: widget.contract?.descriptionAr,
    );
    _concessionsController = TextEditingController(
      text: widget.contract?.concessions,
    );
    _customFrequencyController = TextEditingController();
    _fileUrl = widget.contract?.fileUrl;

    // Set selected values if editing
    if (widget.contract != null) {
      _selectedOwnerId = widget.contract!.ownerId;
      _selectedPropertyId = widget.contract!.propertyId;
      _selectedTenantBuyerId = widget.contract!.tenantBuyerId;

      _paymentFrequency = PaymentFrequency.fromString(
        widget.contract!.paymentFrequency,
      );
      if (widget.contract!.customFrequencyDays != null) {
        _customFrequencyController.text =
            widget.contract!.customFrequencyDays.toString();
      }

      _startDate = widget.contract!.startDate;
      _endDate = widget.contract!.endDate;
    }

    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    final database = context.read<AuthBloc>().database;

    // Load owners (users with role 'owner')
    final owners = await (database.select(database.users)
          ..where((u) => u.role.equals('owner')))
        .get();

    // Load tenants (users with role 'tenant')
    final tenants = await (database.select(database.users)
          ..where((u) => u.role.equals('tenant')))
        .get();

    // Load buyers (users with role 'buyer')
    final buyers = await (database.select(database.users)
          ..where((u) => u.role.equals('buyer')))
        .get();

    setState(() {
      _owners = owners;
      _tenants = tenants;
      _buyers = buyers;
      _isLoadingData = false;
    });

    // Load properties if owner is already selected
    if (_selectedOwnerId != null) {
      await _loadPropertiesForOwner(_selectedOwnerId!);
    }
  }

  Future<void> _loadPropertiesForOwner(String ownerId) async {
    final database = context.read<AuthBloc>().database;

    // Load properties for the selected owner with appropriate status
    final query = database.select(database.properties)
      ..where((p) => p.ownerId.equals(ownerId));

    final properties = await query.get();

    // Filter by status based on contract type
    final filteredProperties = properties.where((p) {
      if (_contractType == 'lease') {
        return p.status == 'available' || p.status == 'rented';
      } else {
        return p.status == 'available' || p.status == 'for_sale';
      }
    }).toList();

    setState(() {
      _properties = filteredProperties;
      // Reset property selection if it's not in the new list
      if (_selectedPropertyId != null &&
          !filteredProperties.any((p) => p.id == _selectedPropertyId)) {
        _selectedPropertyId = null;
      }
    });
  }

  @override
  void dispose() {
    _monthlyLeaseController.dispose();
    _purchasePriceController.dispose();
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

    final totalAmount = _contractType == 'lease'
        ? double.tryParse(_monthlyLeaseController.text) ?? 0
        : double.tryParse(_purchasePriceController.text) ?? 0;

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
      paymentType: _contractType == 'lease' ? 'lease' : 'installment',
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
      if (_selectedOwnerId == null ||
          _selectedPropertyId == null ||
          _selectedTenantBuyerId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select owner, property, and tenant/buyer')),
        );
        return;
      }

      final contract = ContractsCompanion(
        id: drift.Value(widget.contract?.id ?? const Uuid().v4()),
        propertyId: drift.Value(_selectedPropertyId!),
        ownerId: drift.Value(_selectedOwnerId!),
        tenantBuyerId: drift.Value(_selectedTenantBuyerId!),
        contractType: drift.Value(_contractType),
        startDate: drift.Value(_startDate),
        endDate: drift.Value(_endDate),
        monthlyRent: drift.Value(double.tryParse(_monthlyLeaseController.text)),
        salePrice: drift.Value(double.tryParse(_purchasePriceController.text)),
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
    if (_isLoadingData) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

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

            // Owner Dropdown
            DropdownButtonFormField<String>(
              value: _selectedOwnerId,
              items: _owners.map((owner) {
                return DropdownMenuItem(
                  value: owner.id,
                  child: Text(owner.fullName),
                );
              }).toList(),
              onChanged: (value) async {
                setState(() {
                  _selectedOwnerId = value;
                  _selectedPropertyId = null; // Reset property selection
                  _properties = []; // Clear properties
                });
                if (value != null) {
                  await _loadPropertiesForOwner(value);
                }
              },
              decoration: const InputDecoration(labelText: 'Owner'),
              validator: (value) => value == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            // Property Dropdown
            DropdownButtonFormField<String>(
              value: _selectedPropertyId,
              items: _properties.map((property) {
                return DropdownMenuItem(
                  value: property.id,
                  child: Text(property.title),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPropertyId = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Property'),
              validator: (value) => value == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            // Tenant/Buyer Dropdown
            DropdownButtonFormField<String>(
              value: _selectedTenantBuyerId,
              items:
                  (_contractType == 'lease' ? _tenants : _buyers).map((user) {
                return DropdownMenuItem(
                  value: user.id,
                  child: Text(user.fullName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTenantBuyerId = value;
                });
              },
              decoration: InputDecoration(
                labelText: _contractType == 'lease' ? 'Tenant' : 'Buyer',
              ),
              validator: (value) => value == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            // Amount field based on contract type
            if (_contractType == 'lease') ...[
              TextFormField(
                controller: _monthlyLeaseController,
                decoration:
                    const InputDecoration(labelText: 'Monthly Lease Amount'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
            ] else ...[
              TextFormField(
                controller: _purchasePriceController,
                decoration: const InputDecoration(labelText: 'Purchase Price'),
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
