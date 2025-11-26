import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:realestate_app/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/database.dart';

class PropertyRequestFormModal extends StatefulWidget {
  final AppDatabase database;
  final String buyerId;
  final PropertyRequest? existingRequest;
  final bool isAdminMode;

  const PropertyRequestFormModal({
    super.key,
    required this.database,
    required this.buyerId,
    this.existingRequest,
    this.isAdminMode = false,
  });

  @override
  State<PropertyRequestFormModal> createState() =>
      _PropertyRequestFormModalState();
}

class _PropertyRequestFormModalState extends State<PropertyRequestFormModal> {
  final _formKey = GlobalKey<FormState>();
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _locationController = TextEditingController();

  String _selectedCategory = 'residential';
  String? _selectedPropertyType;
  String _selectedUrgency = 'sooner';
  String _selectedStatus = 'pending';
  String? _selectedBuyerId;
  List<User> _buyers = [];
  bool _isLoading = false;
  bool _isLoadingBuyers = false;

  @override
  void initState() {
    super.initState();
    _selectedBuyerId = widget.buyerId;
    if (widget.existingRequest != null) {
      final request = widget.existingRequest!;
      _selectedCategory = request.propertyCategory;
      _selectedPropertyType = request.propertyType;
      _selectedUrgency = request.urgency;
      _selectedStatus = request.status;
      _selectedBuyerId = request.buyerId;
      _minPriceController.text = request.minPrice?.toString() ?? '';
      _maxPriceController.text = request.maxPrice?.toString() ?? '';
      _locationController.text = request.location;
    }
    if (widget.isAdminMode) {
      _loadBuyers();
    }
  }

  Future<void> _loadBuyers() async {
    setState(() => _isLoadingBuyers = true);
    try {
      final buyers = await (widget.database.select(widget.database.users)
            ..where((tbl) => tbl.role.equals('buyer')))
          .get();
      setState(() {
        _buyers = buyers;
        _isLoadingBuyers = false;
      });
    } catch (e) {
      setState(() => _isLoadingBuyers = false);
    }
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> _getPropertyTypeItems(AppLocalizations l10n) {
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

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final minPrice = _minPriceController.text.isEmpty
          ? null
          : double.parse(_minPriceController.text);
      final maxPrice = _maxPriceController.text.isEmpty
          ? null
          : double.parse(_maxPriceController.text);

      if (widget.existingRequest != null) {
        // Update existing request
        await (widget.database.update(widget.database.propertyRequests)
              ..where((tbl) => tbl.id.equals(widget.existingRequest!.id)))
            .write(
          PropertyRequestsCompanion(
            buyerId: widget.isAdminMode && _selectedBuyerId != null
                ? drift.Value(_selectedBuyerId!)
                : const drift.Value.absent(),
            propertyCategory: drift.Value(_selectedCategory),
            propertyType: drift.Value(_selectedPropertyType),
            minPrice: drift.Value(minPrice),
            maxPrice: drift.Value(maxPrice),
            location: drift.Value(_locationController.text.trim()),
            urgency: drift.Value(_selectedUrgency),
            status: drift.Value(_selectedStatus),
            updatedAt: drift.Value(now),
          ),
        );
      } else {
        // Create new request
        await widget.database.into(widget.database.propertyRequests).insert(
              PropertyRequestsCompanion.insert(
                id: const Uuid().v4(),
                buyerId: _selectedBuyerId ?? widget.buyerId,
                propertyCategory: _selectedCategory,
                propertyType: drift.Value(_selectedPropertyType),
                minPrice: drift.Value(minPrice),
                maxPrice: drift.Value(maxPrice),
                location: _locationController.text.trim(),
                urgency: _selectedUrgency,
                status: drift.Value(_selectedStatus),
                createdAt: now,
                updatedAt: now,
              ),
            );
      }

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.error}: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color:
                      theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.placeRequest,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
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
                      // Buyer Selection (Admin only)
                      if (widget.isAdminMode) ...[
                        _isLoadingBuyers
                            ? const Center(child: CircularProgressIndicator())
                            : DropdownButtonFormField<String>(
                                initialValue: _selectedBuyerId != null &&
                                        _selectedBuyerId!.isNotEmpty
                                    ? _selectedBuyerId
                                    : null,
                                decoration: InputDecoration(
                                  labelText: l10n.buyer,
                                  prefixIcon: const Icon(Icons.person),
                                  border: const OutlineInputBorder(),
                                ),
                                items: _buyers.map((buyer) {
                                  return DropdownMenuItem(
                                    value: buyer.id,
                                    child: Text(buyer.fullName),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() => _selectedBuyerId = value);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return l10n.required;
                                  }
                                  return null;
                                },
                              ),
                        const SizedBox(height: 16),
                      ],

                      // Category
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: l10n.category,
                          prefixIcon: const Icon(Icons.category),
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'residential',
                            child: Text(l10n.residential),
                          ),
                          DropdownMenuItem(
                            value: 'commercial',
                            child: Text(l10n.commercial),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                            _selectedPropertyType = null;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      // Property Type
                      DropdownButtonFormField<String>(
                        initialValue: _selectedPropertyType,
                        decoration: InputDecoration(
                          labelText: '${l10n.type} (${l10n.optional})',
                          prefixIcon: const Icon(Icons.home_work),
                          border: const OutlineInputBorder(),
                        ),
                        items: _getPropertyTypeItems(l10n),
                        onChanged: (value) {
                          setState(() => _selectedPropertyType = value);
                        },
                      ),

                      const SizedBox(height: 16),

                      // Min Price
                      TextFormField(
                        controller: _minPriceController,
                        decoration: InputDecoration(
                          labelText: l10n.minPrice,
                          prefixIcon: const Icon(Icons.attach_money),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final price = double.tryParse(value);
                            if (price == null || price < 0) {
                              return l10n.invalidPrice;
                            }
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Max Price
                      TextFormField(
                        controller: _maxPriceController,
                        decoration: InputDecoration(
                          labelText: l10n.maxPrice,
                          prefixIcon: const Icon(Icons.attach_money),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final price = double.tryParse(value);
                            if (price == null || price < 0) {
                              return l10n.invalidPrice;
                            }
                            final minPrice =
                                double.tryParse(_minPriceController.text);
                            if (minPrice != null && price < minPrice) {
                              return 'Max price must be greater than min price';
                            }
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Location
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: l10n.preferredLocation,
                          prefixIcon: const Icon(Icons.location_on),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.required;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Urgency
                      DropdownButtonFormField<String>(
                        initialValue: _selectedUrgency,
                        decoration: InputDecoration(
                          labelText: l10n.urgency,
                          prefixIcon: const Icon(Icons.schedule),
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'sooner',
                            child: Text(l10n.sooner),
                          ),
                          DropdownMenuItem(
                            value: 'after_a_while',
                            child: Text(l10n.afterAWhile),
                          ),
                          DropdownMenuItem(
                            value: 'can_wait',
                            child: Text(l10n.canWait),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedUrgency = value!);
                        },
                      ),

                      const SizedBox(height: 32),

// Status (Admin only)
                      if (widget.isAdminMode) ...[
                        DropdownButtonFormField<String>(
                          initialValue: _selectedStatus,
                          decoration: InputDecoration(
                            labelText: l10n.status,
                            prefixIcon: const Icon(Icons.info),
                            border: const OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'pending',
                              child: Text(l10n.pending),
                            ),
                            DropdownMenuItem(
                              value: 'confirmed',
                              child: Text(l10n.confirmed),
                            ),
                            DropdownMenuItem(
                              value: 'completed',
                              child: Text(l10n.completed),
                            ),
                            DropdownMenuItem(
                              value: 'cancelled',
                              child: Text(l10n.cancelled),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedStatus = value!);
                          },
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Submit Button
                      FilledButton.icon(
                        onPressed: _isLoading ? null : _submitRequest,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send),
                        label:
                            Text(_isLoading ? l10n.loading : l10n.placeRequest),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
