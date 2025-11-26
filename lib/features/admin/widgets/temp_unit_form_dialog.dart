import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import 'temp_unit_models.dart';

/// Dialog for adding/editing units in temporary mode (before property is saved)
class TempUnitFormDialog extends StatefulWidget {
  final TempUnit? unit;
  final Function(TempUnit) onSave;

  const TempUnitFormDialog({
    super.key,
    this.unit,
    required this.onSave,
  });

  @override
  State<TempUnitFormDialog> createState() => _TempUnitFormDialogState();
}

class _TempUnitFormDialogState extends State<TempUnitFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _unitNumberController;
  late TextEditingController _floorNumberController;
  late TextEditingController _roomsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _kitchensController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;

  String _selectedUnitType = 'apartment';
  String _selectedStatus = 'available';

  @override
  void initState() {
    super.initState();
    final unit = widget.unit;

    _unitNumberController = TextEditingController(text: unit?.unitNumber ?? '');
    _floorNumberController =
        TextEditingController(text: unit?.floorNumber ?? '');
    _roomsController =
        TextEditingController(text: unit?.description.rooms?.toString() ?? '');
    _bathroomsController = TextEditingController(
        text: unit?.description.bathrooms?.toString() ?? '');
    _kitchensController = TextEditingController(
        text: unit?.description.kitchens?.toString() ?? '');
    _descriptionController =
        TextEditingController(text: unit?.description.description ?? '');
    _descriptionArController =
        TextEditingController(text: unit?.description.descriptionAr ?? '');

    if (unit != null) {
      _selectedUnitType = unit.unitType;
      _selectedStatus = unit.status;
    }
  }

  @override
  void dispose() {
    _unitNumberController.dispose();
    _floorNumberController.dispose();
    _roomsController.dispose();
    _bathroomsController.dispose();
    _kitchensController.dispose();
    _descriptionController.dispose();
    _descriptionArController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> _getUnitTypeItems(AppLocalizations l10n) {
    return [
      DropdownMenuItem(value: 'apartment', child: Text(l10n.apartment)),
      DropdownMenuItem(value: 'floor', child: Text(l10n.floor)),
      DropdownMenuItem(value: 'office', child: Text(l10n.office)),
      DropdownMenuItem(value: 'shop', child: Text(l10n.shop)),
    ];
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final unit = TempUnit(
      id: widget.unit?.id, // Keep existing ID if editing
      unitType: _selectedUnitType,
      unitNumber: _unitNumberController.text.trim(),
      floorNumber: _floorNumberController.text.trim().isEmpty
          ? null
          : _floorNumberController.text.trim(),
      status: _selectedStatus,
      description: TempUnitDescription(
        rooms: _roomsController.text.isEmpty
            ? null
            : int.parse(_roomsController.text),
        bathrooms: _bathroomsController.text.isEmpty
            ? null
            : int.parse(_bathroomsController.text),
        kitchens: _kitchensController.text.isEmpty
            ? null
            : int.parse(_kitchensController.text),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        descriptionAr: _descriptionArController.text.trim().isEmpty
            ? null
            : _descriptionArController.text.trim(),
      ),
    );

    widget.onSave(unit);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.unit != null;

    return Dialog(
      child: Container(
        width: 600,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  Icon(
                    isEdit ? Icons.edit : Icons.add,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isEdit ? l10n.editUnit : l10n.addUnit,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Form content
            Flexible(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  shrinkWrap: true,
                  children: [
                    // Unit Type
                    DropdownButtonFormField<String>(
                      initialValue: _selectedUnitType,
                      decoration: InputDecoration(
                        labelText: l10n.unitType,
                        prefixIcon: const Icon(Icons.category),
                      ),
                      items: _getUnitTypeItems(l10n),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedUnitType = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Unit Number
                    TextFormField(
                      controller: _unitNumberController,
                      decoration: InputDecoration(
                        labelText: l10n.unitNumber,
                        prefixIcon: const Icon(Icons.numbers),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.required;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Floor Number
                    TextFormField(
                      controller: _floorNumberController,
                      decoration: InputDecoration(
                        labelText: l10n.floorNumber,
                        prefixIcon: const Icon(Icons.layers),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Status
                    DropdownButtonFormField<String>(
                      initialValue: _selectedStatus,
                      decoration: InputDecoration(
                        labelText: l10n.status,
                        prefixIcon: const Icon(Icons.info),
                      ),
                      items: [
                        DropdownMenuItem(
                            value: 'available', child: Text(l10n.available)),
                        DropdownMenuItem(
                            value: 'rented', child: Text(l10n.rented)),
                        DropdownMenuItem(value: 'sold', child: Text(l10n.sold)),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedStatus = value);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(l10n.description,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),

                    // Rooms
                    TextFormField(
                      controller: _roomsController,
                      decoration: InputDecoration(
                        labelText: l10n.bedrooms,
                        prefixIcon: const Icon(Icons.meeting_room),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // Bathrooms
                    TextFormField(
                      controller: _bathroomsController,
                      decoration: InputDecoration(
                        labelText: l10n.bathrooms,
                        prefixIcon: const Icon(Icons.bathroom),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // Kitchens
                    TextFormField(
                      controller: _kitchensController,
                      decoration: InputDecoration(
                        labelText: l10n.kitchens,
                        prefixIcon: const Icon(Icons.kitchen),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // Description (English)
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: l10n.descriptionEn,
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // Description (Arabic)
                    TextFormField(
                      controller: _descriptionArController,
                      decoration: InputDecoration(
                        labelText: l10n.descriptionAr,
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(l10n.cancel),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _save,
                          child: Text(isEdit ? l10n.save : l10n.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
