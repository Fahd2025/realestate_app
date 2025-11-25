import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/database/database.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;

/// Property form modal bottom sheet for creating and editing properties
class PropertyFormModal extends StatefulWidget {
  final Property? property; // null for create, non-null for edit
  final AppDatabase database;
  final String? ownerId;

  const PropertyFormModal({
    super.key,
    this.property,
    required this.database,
    this.ownerId,
  });

  @override
  State<PropertyFormModal> createState() => _PropertyFormModalState();
}

class _PropertyFormModalState extends State<PropertyFormModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _titleArController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;
  late TextEditingController _priceController;
  late TextEditingController _areaController;
  late TextEditingController _bedroomsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;

  String _selectedCategory = 'residential';
  String _selectedPropertyType = 'apartment';
  String _selectedListingType = 'rent';
  String _selectedStatus = 'available';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final property = widget.property;

    _titleController = TextEditingController(text: property?.title ?? '');
    _titleArController = TextEditingController(text: property?.titleAr ?? '');
    _descriptionController =
        TextEditingController(text: property?.description ?? '');
    _descriptionArController =
        TextEditingController(text: property?.descriptionAr ?? '');
    _priceController =
        TextEditingController(text: property?.price.toString() ?? '');
    _areaController =
        TextEditingController(text: property?.area.toString() ?? '');
    _bedroomsController =
        TextEditingController(text: property?.bedrooms?.toString() ?? '');
    _bathroomsController =
        TextEditingController(text: property?.bathrooms?.toString() ?? '');
    _addressController = TextEditingController(text: property?.address ?? '');
    _cityController = TextEditingController(text: property?.city ?? '');
    _countryController = TextEditingController(text: property?.country ?? '');

    if (property != null) {
      _selectedCategory = property.propertyCategory ?? 'residential';
      _selectedPropertyType = property.propertyType;
      _selectedListingType = property.listingType;
      _selectedStatus = property.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleArController.dispose();
    _descriptionController.dispose();
    _descriptionArController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> _getPropertyTypeItems() {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedCategory == 'residential') {
      return [
        DropdownMenuItem(value: 'apartment', child: Text(l10n.apartment)),
        DropdownMenuItem(value: 'villa', child: Text(l10n.villa)),
        DropdownMenuItem(value: 'penthouse', child: Text(l10n.penthouse)),
        DropdownMenuItem(value: 'townhouse', child: Text(l10n.townhouse)),
        DropdownMenuItem(value: 'chalet', child: Text(l10n.chalet)),
        DropdownMenuItem(value: 'twin_house', child: Text(l10n.twinHouse)),
        DropdownMenuItem(value: 'duplex', child: Text(l10n.duplex)),
        DropdownMenuItem(value: 'land', child: Text(l10n.land)),
      ];
    } else {
      return [
        DropdownMenuItem(value: 'office', child: Text(l10n.office)),
        DropdownMenuItem(value: 'business', child: Text(l10n.business)),
        DropdownMenuItem(value: 'industrial', child: Text(l10n.industrial)),
        DropdownMenuItem(
            value: 'commercial_store', child: Text(l10n.commercialStore)),
        DropdownMenuItem(value: 'medical', child: Text(l10n.medical)),
      ];
    }
  }

  Future<void> _saveProperty() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final price = double.parse(_priceController.text);
      final area = double.parse(_areaController.text);
      final bedrooms = _bedroomsController.text.isEmpty
          ? null
          : int.parse(_bedroomsController.text);
      final bathrooms = _bathroomsController.text.isEmpty
          ? null
          : int.parse(_bathroomsController.text);

      if (widget.property == null) {
        // Create new property
        await widget.database.into(widget.database.properties).insert(
              PropertiesCompanion.insert(
                id: const Uuid().v4(),
                ownerId: widget.ownerId ?? '',
                title: _titleController.text.trim(),
                titleAr: drift.Value(_titleArController.text.trim().isEmpty
                    ? null
                    : _titleArController.text.trim()),
                description: drift.Value(
                    _descriptionController.text.trim().isEmpty
                        ? null
                        : _descriptionController.text.trim()),
                descriptionAr: drift.Value(
                    _descriptionArController.text.trim().isEmpty
                        ? null
                        : _descriptionArController.text.trim()),
                propertyCategory: drift.Value(_selectedCategory),
                propertyType: _selectedPropertyType,
                listingType: _selectedListingType,
                price: price,
                area: area,
                bedrooms: drift.Value(bedrooms),
                bathrooms: drift.Value(bathrooms),
                address: _addressController.text.trim(),
                city: _cityController.text.trim(),
                country: _countryController.text.trim(),
                status: drift.Value(_selectedStatus),
                createdAt: now,
                updatedAt: now,
              ),
            );
      } else {
        // Update existing property
        await (widget.database.update(widget.database.properties)
              ..where((tbl) => tbl.id.equals(widget.property!.id)))
            .write(
          PropertiesCompanion(
            title: drift.Value(_titleController.text.trim()),
            titleAr: drift.Value(_titleArController.text.trim().isEmpty
                ? null
                : _titleArController.text.trim()),
            description: drift.Value(_descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim()),
            descriptionAr: drift.Value(
                _descriptionArController.text.trim().isEmpty
                    ? null
                    : _descriptionArController.text.trim()),
            propertyCategory: drift.Value(_selectedCategory),
            propertyType: drift.Value(_selectedPropertyType),
            listingType: drift.Value(_selectedListingType),
            price: drift.Value(price),
            area: drift.Value(area),
            bedrooms: drift.Value(bedrooms),
            bathrooms: drift.Value(bathrooms),
            address: drift.Value(_addressController.text.trim()),
            city: drift.Value(_cityController.text.trim()),
            country: drift.Value(_countryController.text.trim()),
            status: drift.Value(_selectedStatus),
            updatedAt: drift.Value(now),
          ),
        );
      }

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.error}: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.property != null;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isEdit ? l10n.editProperty : l10n.addNewProperty,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(24),
                    children: [
                      // Title (English)
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: l10n.title,
                          prefixIcon: const Icon(Icons.title),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.titleRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Title (Arabic)
                      TextFormField(
                        controller: _titleArController,
                        decoration: InputDecoration(
                          labelText: l10n.titleArabic,
                          prefixIcon: const Icon(Icons.title),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Description (English)
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: l10n.description,
                          prefixIcon: const Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Description (Arabic)
                      TextFormField(
                        controller: _descriptionArController,
                        decoration: InputDecoration(
                          labelText: l10n.descriptionArabic,
                          prefixIcon: const Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Property Category
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: l10n.category,
                          prefixIcon: const Icon(Icons.category),
                        ),
                        items: [
                          DropdownMenuItem(
                              value: 'residential',
                              child: Text(l10n.residential)),
                          DropdownMenuItem(
                              value: 'commercial',
                              child: Text(l10n.commercial)),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCategory = value;
                              // Reset type when category changes
                              if (_selectedCategory == 'residential') {
                                _selectedPropertyType = 'apartment';
                              } else {
                                _selectedPropertyType = 'office';
                              }
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Property Type
                      DropdownButtonFormField<String>(
                        value: _selectedPropertyType,
                        decoration: InputDecoration(
                          labelText: l10n.type,
                          prefixIcon: const Icon(Icons.home_work),
                        ),
                        items: _getPropertyTypeItems(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedPropertyType = value);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Listing Type
                      DropdownButtonFormField<String>(
                        value: _selectedListingType,
                        decoration: InputDecoration(
                          labelText: l10n.listingType,
                          prefixIcon: const Icon(Icons.sell),
                        ),
                        items: [
                          DropdownMenuItem(
                              value: 'rent', child: Text(l10n.rent)),
                          DropdownMenuItem(
                              value: 'sale', child: Text(l10n.sale)),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedListingType = value);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Price
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: l10n.price,
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.priceRequired;
                          }
                          if (double.tryParse(value) == null) {
                            return l10n.invalidPrice;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Area
                      TextFormField(
                        controller: _areaController,
                        decoration: InputDecoration(
                          labelText: '${l10n.area} (m²)',
                          prefixIcon: const Icon(Icons.square_foot),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.areaRequired;
                          }
                          if (double.tryParse(value) == null) {
                            return l10n.invalidArea;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Bedrooms
                      TextFormField(
                        controller: _bedroomsController,
                        decoration: InputDecoration(
                          labelText: l10n.bedrooms,
                          prefixIcon: const Icon(Icons.bed),
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

                      // Address
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: l10n.address,
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.addressRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // City
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: l10n.city,
                          prefixIcon: const Icon(Icons.location_city),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.cityRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Country
                      TextFormField(
                        controller: _countryController,
                        decoration: InputDecoration(
                          labelText: l10n.country,
                          prefixIcon: const Icon(Icons.flag),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.countryRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Status
                      DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        decoration: InputDecoration(
                          labelText: l10n.status,
                          prefixIcon: const Icon(Icons.info),
                        ),
                        items: [
                          DropdownMenuItem(
                              value: 'available', child: Text(l10n.available)),
                          DropdownMenuItem(
                              value: 'rented', child: Text(l10n.rented)),
                          DropdownMenuItem(
                              value: 'sold', child: Text(l10n.sold)),
                          DropdownMenuItem(
                              value: 'pending', child: Text(l10n.pending)),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedStatus = value);
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Save button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _saveProperty,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(isEdit
                                ? l10n.updateProperty
                                : l10n.createProperty),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
