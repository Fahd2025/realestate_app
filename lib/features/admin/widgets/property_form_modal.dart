import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/database/database.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'unit_form_modal.dart';
import 'temp_unit_models.dart';
import 'temp_unit_form_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:convert';

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
  late Stream<List<UnitWithDescription>> _unitsStream;
  final List<TempUnit> _tempUnits = []; // For new properties
  bool _useTemporaryUnits = false; // Flag to determine which list to use

  // Image handling
  final ImagePicker _picker = ImagePicker();
  List<PropertyImage> _existingImages = [];
  List<XFile> _newImages = [];
  List<String> _imagesToDelete = [];
  bool _isLoadingImages = false;

  @override
  void initState() {
    super.initState();
    final property = widget.property;

    if (property != null) {
      _unitsStream = _watchUnits(property.id);
      _useTemporaryUnits = false;
      _isLoadingImages = true;
      _loadImages().then((_) {
        if (mounted) {
          setState(() {
            _isLoadingImages = false;
          });
        }
      });
    } else {
      _unitsStream = Stream.value([]);
      _useTemporaryUnits = true; // Use temp list for new properties
    }

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

  Future<void> _loadImages() async {
    if (widget.property != null) {
      final images = await (widget.database
              .select(widget.database.propertyImages)
            ..where((tbl) => tbl.propertyId.equals(widget.property!.id))
            ..orderBy(
                [(tbl) => drift.OrderingTerm(expression: tbl.displayOrder)]))
          .get();
      setState(() {
        _existingImages = images;
      });
    }
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        final totalImages =
            _existingImages.length + _newImages.length + images.length;
        if (totalImages > 8) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Maximum 8 images allowed')),
            );
          }
          return;
        }
        setState(() {
          _newImages.addAll(images);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking images: $e')),
        );
      }
    }
  }

  void _removeExistingImage(PropertyImage image) {
    setState(() {
      _imagesToDelete.add(image.id);
      _existingImages.remove(image);
    });
  }

  void _removeNewImage(int index) {
    setState(() {
      _newImages.removeAt(index);
    });
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
        DropdownMenuItem(value: 'building', child: Text(l10n.building)),
      ];
    } else {
      return [
        DropdownMenuItem(value: 'office', child: Text(l10n.office)),
        DropdownMenuItem(value: 'business', child: Text(l10n.business)),
        DropdownMenuItem(value: 'industrial', child: Text(l10n.industrial)),
        DropdownMenuItem(
            value: 'commercial_store', child: Text(l10n.commercialStore)),
        DropdownMenuItem(value: 'medical', child: Text(l10n.medical)),
        DropdownMenuItem(value: 'building', child: Text(l10n.building)),
      ];
    }
  }

  Stream<List<UnitWithDescription>> _watchUnits(String propertyId) {
    final query = widget.database.select(widget.database.buildingUnits).join([
      drift.leftOuterJoin(
        widget.database.unitDescriptions,
        widget.database.unitDescriptions.unitId
            .equalsExp(widget.database.buildingUnits.id),
      ),
    ])
      ..where(widget.database.buildingUnits.propertyId.equals(propertyId));

    return query.watch().map((rows) {
      return rows.map((row) {
        return UnitWithDescription(
          unit: row.readTable(widget.database.buildingUnits),
          description: row.readTableOrNull(widget.database.unitDescriptions),
        );
      }).toList();
    });
  }

  Future<void> _deleteUnit(String unitId) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteUnit),
        content: Text(l10n.deleteUnitConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete,
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await (widget.database.delete(widget.database.buildingUnits)
            ..where((tbl) => tbl.id.equals(unitId)))
          .go();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.success),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _showUnitForm(
      {BuildingUnit? unit,
      UnitDescription? description,
      TempUnit? tempUnit,
      int? tempIndex}) {
    // For new properties (temporary mode)
    if (_useTemporaryUnits) {
      showDialog(
        context: context,
        builder: (context) => TempUnitFormDialog(
          unit: tempUnit,
          onSave: (newUnit) {
            setState(() {
              if (tempIndex != null) {
                // Edit existing temp unit
                _tempUnits[tempIndex] = newUnit;
              } else {
                // Add new temp unit
                _tempUnits.add(newUnit);
              }
            });
          },
        ),
      );
      return;
    }

    // For existing properties (database mode)
    if (widget.property == null) return;

    showDialog(
      context: context,
      builder: (context) => UnitFormModal(
        propertyId: widget.property!.id,
        database: widget.database,
        unit: unit,
        description: description,
      ),
    ).then((result) {
      if (result == true && mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.success),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void _deleteTempUnit(int index) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteUnit),
        content: Text(l10n.deleteUnitConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete,
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _tempUnits.removeAt(index);
      });
    }
  }

  IconData _getUnitIcon(String type) {
    switch (type) {
      case 'apartment':
        return Icons.apartment;
      case 'office':
        return Icons.business;
      case 'shop':
        return Icons.store;
      case 'floor':
        return Icons.layers;
      default:
        return Icons.home;
    }
  }

  String _getUnitTypeName(String type, AppLocalizations l10n) {
    switch (type) {
      case 'apartment':
        return l10n.apartment;
      case 'office':
        return l10n.office;
      case 'shop':
        return l10n.shop;
      case 'floor':
        return l10n.floor;
      default:
        return type;
    }
  }

  String _getStatusName(String status, AppLocalizations l10n) {
    switch (status) {
      case 'available':
        return l10n.available;
      case 'rented':
        return l10n.rented;
      case 'sold':
        return l10n.sold;
      default:
        return status;
    }
  }

  Future<void> _saveProperty() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isLoading = false);
      return;
    }

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

      String propertyId;

      if (widget.property == null) {
        // Create new property
        propertyId = const Uuid().v4();
        await widget.database.into(widget.database.properties).insert(
              PropertiesCompanion.insert(
                id: propertyId,
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

        // Save temporary units if any
        if (_tempUnits.isNotEmpty) {
          for (final tempUnit in _tempUnits) {
            final unitId = const Uuid().v4();

            // Insert unit
            await widget.database.into(widget.database.buildingUnits).insert(
                  BuildingUnitsCompanion.insert(
                    id: unitId,
                    propertyId: propertyId,
                    unitType: tempUnit.unitType,
                    unitNumber: tempUnit.unitNumber,
                    floorNumber: drift.Value(tempUnit.floorNumber),
                    status: drift.Value(tempUnit.status),
                    createdAt: now,
                    updatedAt: now,
                  ),
                );

            // Insert unit description
            await widget.database.into(widget.database.unitDescriptions).insert(
                  UnitDescriptionsCompanion.insert(
                    id: const Uuid().v4(),
                    unitId: unitId,
                    rooms: drift.Value(tempUnit.description.rooms),
                    bathrooms: drift.Value(tempUnit.description.bathrooms),
                    kitchens: drift.Value(tempUnit.description.kitchens),
                    description: drift.Value(tempUnit.description.description),
                    descriptionAr:
                        drift.Value(tempUnit.description.descriptionAr),
                    createdAt: now,
                    updatedAt: now,
                  ),
                );
          }
        }
      } else {
        // Update existing property
        propertyId = widget.property!.id;
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

      // Handle image deletions
      if (_imagesToDelete.isNotEmpty) {
        await (widget.database.delete(widget.database.propertyImages)
              ..where((tbl) => tbl.id.isIn(_imagesToDelete)))
            .go();
      }

      // Handle new images
      if (_newImages.isNotEmpty) {
        for (int i = 0; i < _newImages.length; i++) {
          final image = _newImages[i];
          String imageUrl;

          if (kIsWeb) {
            final bytes = await image.readAsBytes();
            final extension = image.name.split('.').last;
            imageUrl = 'data:image/$extension;base64,${base64Encode(bytes)}';
          } else {
            imageUrl = image.path;
          }

          await widget.database.into(widget.database.propertyImages).insert(
                PropertyImagesCompanion.insert(
                  id: const Uuid().v4(),
                  propertyId: propertyId,
                  imageUrl: imageUrl,
                  displayOrder: drift.Value(_existingImages.length + i),
                  createdAt: now,
                ),
              );
        }
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

  Future<void> _handleClose() async {
    // Check if we are in "create mode" (temporary units) and have unsaved units
    final hasUnsavedUnits = _useTemporaryUnits && _tempUnits.isNotEmpty;

    if (hasUnsavedUnits) {
      final l10n = AppLocalizations.of(context)!;
      final shouldDiscard = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.discardChanges),
          content: Text(l10n.discardChangesConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.discard,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        ),
      );

      if (shouldDiscard == true) {
        if (mounted) Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget _buildImageTile(String imageUrl, VoidCallback onRemove) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl.startsWith('data:image')
                ? Image.memory(
                    base64Decode(imageUrl.split(',').last),
                    fit: BoxFit.cover,
                  )
                : (kIsWeb
                    ? Image.network(imageUrl, fit: BoxFit.cover)
                    : Image.file(File(imageUrl), fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewImageTile(XFile image, VoidCallback onRemove) {
    return FutureBuilder<Uint8List>(
      future: image.readAsBytes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        return Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(snapshot.data!, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
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
                      onPressed: _handleClose,
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
                      // Property Images Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Property Images',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton.icon(
                            onPressed:
                                (_existingImages.length + _newImages.length < 8)
                                    ? _pickImages
                                    : null,
                            icon: const Icon(Icons.add_photo_alternate),
                            label: Text(
                                'Add Images (${_existingImages.length + _newImages.length}/8)'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (_isLoadingImages)
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (_existingImages.isEmpty && _newImages.isEmpty)
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('No images added'),
                          ),
                        )
                      else
                        SizedBox(
                          height: 110,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ..._existingImages.map((img) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: _buildImageTile(
                                      img.imageUrl,
                                      () => _removeExistingImage(img),
                                    ),
                                  )),
                              ..._newImages
                                  .asMap()
                                  .entries
                                  .map((entry) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: _buildNewImageTile(
                                          entry.value,
                                          () => _removeNewImage(entry.key),
                                        ),
                                      )),
                            ],
                          ),
                        ),
                      const SizedBox(height: 24),

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

                      // Bedrooms (hidden for buildings)
                      if (_selectedPropertyType != 'building') ...[
                        TextFormField(
                          controller: _bedroomsController,
                          decoration: InputDecoration(
                            labelText: l10n.bedrooms,
                            prefixIcon: const Icon(Icons.bed),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Bathrooms (hidden for buildings)
                      if (_selectedPropertyType != 'building') ...[
                        TextFormField(
                          controller: _bathroomsController,
                          decoration: InputDecoration(
                            labelText: l10n.bathrooms,
                            prefixIcon: const Icon(Icons.bathroom),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                      ],

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
                      const SizedBox(height: 16),

                      // Embedded Unit Management
                      if (_selectedPropertyType == 'building') ...[
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.units,
                                style: Theme.of(context).textTheme.titleLarge),
                            IconButton(
                              onPressed: () => _showUnitForm(),
                              icon: const Icon(Icons.add_circle),
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Info banner
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _useTemporaryUnits
                                      ? 'Units will be saved when you create the property'
                                      : 'Unit changes are saved immediately to the database',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Unit list - Temporary mode (new property)
                        if (_useTemporaryUnits)
                          _tempUnits.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(child: Text(l10n.noUnitsFound)),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _tempUnits.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 8),
                                  itemBuilder: (context, index) {
                                    final tempUnit = _tempUnits[index];
                                    return Card(
                                      margin: EdgeInsets.zero,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 16,
                                          child: Icon(
                                              _getUnitIcon(tempUnit.unitType),
                                              size: 16),
                                        ),
                                        title: Text(
                                            '${_getUnitTypeName(tempUnit.unitType, l10n)} ${tempUnit.unitNumber}'),
                                        subtitle: Text(
                                            '${l10n.status}: ${_getStatusName(tempUnit.status, l10n)}'),
                                        trailing: PopupMenuButton(
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: Text(l10n.edit),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Text(l10n.delete,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error)),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              _showUnitForm(
                                                  tempUnit: tempUnit,
                                                  tempIndex: index);
                                            } else if (value == 'delete') {
                                              _deleteTempUnit(index);
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                )
                        // Unit list - Database mode (existing property)
                        else
                          StreamBuilder<List<UnitWithDescription>>(
                            stream: _unitsStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('${l10n.error}: ${snapshot.error}');
                              }
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              final units = snapshot.data!;
                              if (units.isEmpty) {
                                return Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(child: Text(l10n.noUnitsFound)),
                                );
                              }
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: units.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final item = units[index];
                                  final unit = item.unit;
                                  final desc = item.description;
                                  return Card(
                                    margin: EdgeInsets.zero,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 16,
                                        child: Icon(_getUnitIcon(unit.unitType),
                                            size: 16),
                                      ),
                                      title: Text(
                                          '${_getUnitTypeName(unit.unitType, l10n)} ${unit.unitNumber}'),
                                      subtitle: Text(
                                          '${l10n.status}: ${_getStatusName(unit.status, l10n)}'),
                                      trailing: PopupMenuButton(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Text(l10n.edit),
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Text(l10n.delete,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error)),
                                          ),
                                        ],
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            _showUnitForm(
                                                unit: unit, description: desc);
                                          } else if (value == 'delete') {
                                            _deleteUnit(unit.id);
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                      ],

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
