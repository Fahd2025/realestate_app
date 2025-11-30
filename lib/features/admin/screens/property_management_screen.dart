import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/database.dart';
import '../../../core/widgets/main_layout.dart';
import '../../../core/widgets/responsive_data_table.dart';
import '../../../core/widgets/responsive_card_list.dart';
import '../../../core/widgets/confirmation_dialog.dart';
import '../../../core/widgets/search_filter_bar.dart';
import '../../../core/widgets/image_slideshow_dialog.dart';
import '../widgets/property_form_modal.dart';

/// Data class to hold property with its primary image
class PropertyWithImage {
  final Property property;
  final String? primaryImageUrl;

  PropertyWithImage({
    required this.property,
    this.primaryImageUrl,
  });
}

/// Comprehensive property management screen with CRUD operations
class PropertyManagementScreen extends StatefulWidget {
  final AppDatabase database;
  final String? ownerId; // null for admin (see all), specific ID for owners

  const PropertyManagementScreen({
    super.key,
    required this.database,
    this.ownerId,
  });

  @override
  State<PropertyManagementScreen> createState() =>
      _PropertyManagementScreenState();
}

class _PropertyManagementScreenState extends State<PropertyManagementScreen> {
  List<PropertyWithImage> _properties = [];
  List<PropertyWithImage> _filteredProperties = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String? _selectedCategoryFilter;
  String? _selectedTypeFilter;
  String? _selectedListingFilter;
  String? _selectedStatusFilter;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    setState(() => _isLoading = true);

    try {
      final query = widget.database.select(widget.database.properties);

      // Filter by owner if specified
      if (widget.ownerId != null) {
        query.where((tbl) => tbl.ownerId.equals(widget.ownerId!));
      }

      final properties = await query.get();

      // Load primary image for each property
      final propertiesWithImages = <PropertyWithImage>[];
      for (final property in properties) {
        final primaryImage =
            await (widget.database.select(widget.database.propertyImages)
                  ..where((tbl) => tbl.propertyId.equals(property.id))
                  ..where((tbl) => tbl.isPrimary.equals(true))
                  ..limit(1))
                .getSingleOrNull();

        propertiesWithImages.add(PropertyWithImage(
          property: property,
          primaryImageUrl: primaryImage?.imageUrl,
        ));
      }

      setState(() {
        _properties = propertiesWithImages;
        _applyFilters();
        _isLoading = false;
      });
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

  void _applyFilters() {
    _filteredProperties = _properties.where((propertyWithImage) {
      final property = propertyWithImage.property;

      // Search filter
      final matchesSearch = _searchQuery.isEmpty ||
          property.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (property.titleAr
                  ?.toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ??
              false) ||
          property.address.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          property.city.toLowerCase().contains(_searchQuery.toLowerCase());

      // Category filter
      final matchesCategory = _selectedCategoryFilter == null ||
          property.propertyCategory == _selectedCategoryFilter;

      // Type filter
      final matchesType = _selectedTypeFilter == null ||
          property.propertyType == _selectedTypeFilter;

      // Listing filter
      final matchesListing = _selectedListingFilter == null ||
          property.listingType == _selectedListingFilter;

      // Status filter
      final matchesStatus = _selectedStatusFilter == null ||
          property.status == _selectedStatusFilter;

      return matchesSearch &&
          matchesCategory &&
          matchesType &&
          matchesListing &&
          matchesStatus;
    }).toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _onCategoryFilterChanged(String? category) {
    setState(() {
      _selectedCategoryFilter = category;
      _selectedTypeFilter = null; // Reset type filter when category changes
      _applyFilters();
    });
  }

  void _onTypeFilterChanged(String? type) {
    setState(() {
      _selectedTypeFilter = type;
      _applyFilters();
    });
  }

  Future<void> _handleAddProperty() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PropertyFormModal(
        database: widget.database,
        ownerId: widget.ownerId,
      ),
    );

    if (result == true) {
      _loadProperties();
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.success)),
        );
      }
    }
  }

  Future<void> _handleEditProperty(PropertyWithImage propertyWithImage) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PropertyFormModal(
        database: widget.database,
        property: propertyWithImage.property,
        ownerId: widget.ownerId,
      ),
    );

    if (result == true) {
      _loadProperties();
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.success)),
        );
      }
    }
  }

  Future<void> _handleDeleteProperty(
      PropertyWithImage propertyWithImage) async {
    final property = propertyWithImage.property;
    final l10n = AppLocalizations.of(context)!;
    await ConfirmationDialog.show(
      context: context,
      title: l10n.delete,
      message: '${l10n.confirmDelete}\n\n${property.title}',
      confirmText: l10n.delete,
      isDangerous: true,
      onConfirm: () async {
        try {
          await (widget.database.delete(widget.database.properties)
                ..where((tbl) => tbl.id.equals(property.id)))
              .go();

          _loadProperties();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.success)),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${l10n.error}: ${e.toString()}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        }
      },
    );
  }

  Future<void> _showPropertyImages(String propertyId) async {
    // Load all images for this property
    final images = await (widget.database.select(widget.database.propertyImages)
          ..where((tbl) => tbl.propertyId.equals(propertyId))
          ..orderBy([
            (tbl) => drift.OrderingTerm(expression: tbl.displayOrder),
          ]))
        .get();

    if (images.isEmpty) {
      return;
    }

    final imageUrls = images.map((img) => img.imageUrl).toList();

    if (mounted) {
      await ImageSlideshowDialog.show(
        context,
        imageUrls,
        initialIndex: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MainLayout(
      title: l10n.manageProperties,
      actions: [
        IconButton(
          onPressed: _handleAddProperty,
          icon: const Icon(Icons.add),
          tooltip: l10n.add,
        ),
      ],
      body: Column(
        children: [
          // Search and filter bar
          SearchFilterBar(
            searchHint: '${l10n.search}...',
            onSearchChanged: _onSearchChanged,
            filterChips: [
              // Category filters
              FilterChip(
                label: Text(l10n.all),
                selected: _selectedCategoryFilter == null,
                onSelected: (_) => _onCategoryFilterChanged(null),
              ),
              FilterChip(
                label: Text(l10n.residential),
                selected: _selectedCategoryFilter == 'residential',
                onSelected: (_) => _onCategoryFilterChanged('residential'),
              ),
              FilterChip(
                label: Text(l10n.commercial),
                selected: _selectedCategoryFilter == 'commercial',
                onSelected: (_) => _onCategoryFilterChanged('commercial'),
              ),
            ],
          ),
          if (_selectedCategoryFilter != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildTypeFilterChips(l10n),
                ),
              ),
            ),

          // Data display
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProperties.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_work_outlined,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noData,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final isLargeScreen = constraints.maxWidth >= 900;

                          if (isLargeScreen) {
                            return _buildDesktopView();
                          } else {
                            return _buildMobileView();
                          }
                        },
                      ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTypeFilterChips(AppLocalizations l10n) {
    final chips = <Widget>[];
    if (_selectedCategoryFilter == 'residential') {
      chips.addAll([
        _buildTypeChip(l10n.apartment, 'apartment'),
        _buildTypeChip(l10n.villa, 'villa'),
        _buildTypeChip(l10n.penthouse, 'penthouse'),
        _buildTypeChip(l10n.townhouse, 'townhouse'),
        _buildTypeChip(l10n.chalet, 'chalet'),
        _buildTypeChip(l10n.twinHouse, 'twin_house'),
        _buildTypeChip(l10n.duplex, 'duplex'),
        _buildTypeChip(l10n.land, 'land'),
        _buildTypeChip(l10n.building, 'building'),
      ]);
    } else if (_selectedCategoryFilter == 'commercial') {
      chips.addAll([
        _buildTypeChip(l10n.office, 'office'),
        _buildTypeChip(l10n.business, 'business'),
        _buildTypeChip(l10n.industrial, 'industrial'),
        _buildTypeChip(l10n.commercialStore, 'commercial_store'),
        _buildTypeChip(l10n.medical, 'medical'),
        _buildTypeChip(l10n.building, 'building'),
      ]);
    }
    return chips;
  }

  Widget _buildTypeChip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: _selectedTypeFilter == value,
        onSelected: (_) =>
            _onTypeFilterChanged(value == _selectedTypeFilter ? null : value),
      ),
    );
  }

  Widget _buildDesktopView() {
    final l10n = AppLocalizations.of(context)!;
    return ResponsiveDataTable<PropertyWithImage>(
      data: _filteredProperties,
      columns: [
        DataTableColumnConfig(
          label: 'Image', // TODO: Add to localizations
          getValue: (propertyWithImage) => '',
          sortable: false,
          customCell: (propertyWithImage) => _buildImageCell(propertyWithImage),
        ),
        DataTableColumnConfig(
          label: l10n.title,
          getValue: (propertyWithImage) => propertyWithImage.property.title,
        ),
        DataTableColumnConfig(
          label: l10n.category,
          getValue: (propertyWithImage) =>
              _getCategoryLabel(propertyWithImage.property.propertyCategory),
        ),
        DataTableColumnConfig(
          label: l10n.type,
          getValue: (propertyWithImage) =>
              _getPropertyTypeLabel(propertyWithImage.property.propertyType),
        ),
        DataTableColumnConfig(
          label: l10n.price,
          getValue: (propertyWithImage) =>
              '\$${propertyWithImage.property.price.toStringAsFixed(0)}',
          numeric: true,
        ),
        DataTableColumnConfig(
          label: l10n.area,
          getValue: (propertyWithImage) =>
              '${propertyWithImage.property.area.toStringAsFixed(0)} m²',
          numeric: true,
        ),
        DataTableColumnConfig(
          label: l10n.city,
          getValue: (propertyWithImage) => propertyWithImage.property.city,
        ),
        DataTableColumnConfig(
          label: l10n.status,
          getValue: (propertyWithImage) =>
              _getStatusLabel(propertyWithImage.property.status),
          customCell: (propertyWithImage) => Chip(
            label: Text(
              _getStatusLabel(propertyWithImage.property.status),
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: _getStatusColor(propertyWithImage.property.status),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
      onEdit: _handleEditProperty,
      onDelete: _handleDeleteProperty,
      rowsPerPage: 10,
    );
  }

  Widget _buildImageCell(PropertyWithImage propertyWithImage) {
    if (propertyWithImage.primaryImageUrl == null) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }

    final imageUrl = propertyWithImage.primaryImageUrl!;

    return InkWell(
      onTap: () => _showPropertyImages(propertyWithImage.property.id),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildImageWidget(imageUrl),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    // Check if it's a network URL (http/https)
    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.broken_image,
          color: Colors.grey,
        ),
      );
    }

    // Check if it's a base64 data URL
    if (imageUrl.startsWith('data:image')) {
      try {
        final base64String = imageUrl.split(',')[1];
        final bytes = base64Decode(base64String);
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image,
            color: Colors.grey,
          ),
        );
      } catch (e) {
        return const Icon(
          Icons.broken_image,
          color: Colors.grey,
        );
      }
    }

    // Local file path - not supported on web
    if (kIsWeb) {
      return Container(
        color: Colors.grey.withValues(alpha: 0.2),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, color: Colors.grey, size: 24),
            SizedBox(height: 4),
            Text(
              'Web',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // For non-web platforms, show placeholder for local files
    return Container(
      color: Colors.grey.withValues(alpha: 0.2),
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }

  Widget _buildMobileView() {
    final l10n = AppLocalizations.of(context)!;
    return ResponsiveCardList<PropertyWithImage>(
      data: _filteredProperties,
      getTitle: (propertyWithImage) => propertyWithImage.property.title,
      getSubtitle: (propertyWithImage) =>
          '${propertyWithImage.property.city} • \$${propertyWithImage.property.price.toStringAsFixed(0)}',
      getLeading: (propertyWithImage) {
        if (propertyWithImage.primaryImageUrl != null) {
          return InkWell(
            onTap: () => _showPropertyImages(propertyWithImage.property.id),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildImageWidget(propertyWithImage.primaryImageUrl!),
              ),
            ),
          );
        }
        return CircleAvatar(
          backgroundColor: _getStatusColor(propertyWithImage.property.status),
          child: Icon(
            _getPropertyTypeIcon(propertyWithImage.property.propertyType),
            color: Colors.white,
          ),
        );
      },
      fields: [
        CardField(
          label: l10n.category,
          getValue: (propertyWithImage) =>
              _getCategoryLabel(propertyWithImage.property.propertyCategory),
        ),
        CardField(
          label: l10n.type,
          getValue: (propertyWithImage) =>
              _getPropertyTypeLabel(propertyWithImage.property.propertyType),
        ),
        CardField(
          label: l10n.area,
          getValue: (propertyWithImage) =>
              '${propertyWithImage.property.area.toStringAsFixed(0)} m²',
        ),
        CardField(
          label: l10n.bedrooms,
          getValue: (propertyWithImage) =>
              propertyWithImage.property.bedrooms?.toString() ?? '-',
        ),
        CardField(
          label: l10n.bathrooms,
          getValue: (propertyWithImage) =>
              propertyWithImage.property.bathrooms?.toString() ?? '-',
        ),
        CardField(
          label: l10n.address,
          getValue: (propertyWithImage) => propertyWithImage.property.address,
        ),
        CardField(
          label: l10n.status,
          getValue: (propertyWithImage) =>
              _getStatusLabel(propertyWithImage.property.status),
          customWidget: (propertyWithImage) => Chip(
            label: Text(_getStatusLabel(propertyWithImage.property.status)),
            backgroundColor: _getStatusColor(propertyWithImage.property.status),
          ),
        ),
      ],
      onEdit: _handleEditProperty,
      onDelete: _handleDeleteProperty,
    );
  }

  String _getCategoryLabel(String? category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case 'residential':
        return l10n.residential;
      case 'commercial':
        return l10n.commercial;
      default:
        return category ?? '-';
    }
  }

  String _getPropertyTypeLabel(String type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case 'apartment':
        return l10n.apartment;
      case 'house':
        return l10n.house;
      case 'villa':
        return l10n.villa;
      case 'penthouse':
        return l10n.penthouse;
      case 'townhouse':
        return l10n.townhouse;
      case 'chalet':
        return l10n.chalet;
      case 'twin_house':
        return l10n.twinHouse;
      case 'duplex':
        return l10n.duplex;
      case 'land':
        return l10n.land;
      case 'office':
        return l10n.office;
      case 'business':
        return l10n.business;
      case 'industrial':
        return l10n.industrial;
      case 'commercial_store':
        return l10n.commercialStore;
      case 'medical':
        return l10n.medical;
      case 'building':
        return l10n.building;
      default:
        return type;
    }
  }

  String _getStatusLabel(String status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'available':
        return l10n.available;
      case 'rented':
        return l10n.rented;
      case 'sold':
        return l10n.sold;
      case 'pending':
        return l10n.pending;
      default:
        return status;
    }
  }

  IconData _getPropertyTypeIcon(String type) {
    switch (type) {
      case 'apartment':
        return Icons.apartment;
      case 'house':
        return Icons.house;
      case 'villa':
        return Icons.villa;
      case 'penthouse':
        return Icons.star;
      case 'townhouse':
        return Icons.home_work;
      case 'chalet':
        return Icons.beach_access;
      case 'twin_house':
        return Icons.home;
      case 'duplex':
        return Icons.layers;
      case 'land':
        return Icons.landscape;
      case 'office':
        return Icons.business_center;
      case 'business':
        return Icons.store;
      case 'industrial':
        return Icons.factory;
      case 'commercial_store':
        return Icons.storefront;
      case 'medical':
        return Icons.local_hospital;
      case 'building':
        return Icons.domain;
      default:
        return Icons.home;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return Colors.green.withValues(alpha: 0.2);
      case 'rented':
        return Colors.orange.withValues(alpha: 0.2);
      case 'sold':
        return Colors.red.withValues(alpha: 0.2);
      case 'pending':
        return Colors.blue.withValues(alpha: 0.2);
      default:
        return Colors.grey.withValues(alpha: 0.2);
    }
  }
}
