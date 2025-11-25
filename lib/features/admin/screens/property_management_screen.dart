import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/database/database.dart';
import '../../../core/widgets/main_layout.dart';
import '../../../core/widgets/responsive_data_table.dart';
import '../../../core/widgets/responsive_card_list.dart';
import '../../../core/widgets/confirmation_dialog.dart';
import '../../../core/widgets/search_filter_bar.dart';
import '../widgets/property_form_modal.dart';

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
  List<Property> _properties = [];
  List<Property> _filteredProperties = [];
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
      setState(() {
        _properties = properties;
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
    _filteredProperties = _properties.where((property) {
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

  Future<void> _handleEditProperty(Property property) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PropertyFormModal(
        database: widget.database,
        property: property,
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

  Future<void> _handleDeleteProperty(Property property) async {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return MainLayout(
      title: l10n.manageProperties,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddProperty,
        icon: const Icon(Icons.add),
        label: Text(l10n.add),
      ),
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
                    : isDesktop
                        ? _buildDesktopView()
                        : _buildMobileView(),
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
      ]);
    } else if (_selectedCategoryFilter == 'commercial') {
      chips.addAll([
        _buildTypeChip(l10n.office, 'office'),
        _buildTypeChip(l10n.business, 'business'),
        _buildTypeChip(l10n.industrial, 'industrial'),
        _buildTypeChip(l10n.commercialStore, 'commercial_store'),
        _buildTypeChip(l10n.medical, 'medical'),
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
    return ResponsiveDataTable<Property>(
      data: _filteredProperties,
      columns: [
        DataTableColumnConfig(
          label: l10n.title,
          getValue: (property) => property.title,
        ),
        DataTableColumnConfig(
          label: l10n.category,
          getValue: (property) => _getCategoryLabel(property.propertyCategory),
        ),
        DataTableColumnConfig(
          label: l10n.type,
          getValue: (property) => _getPropertyTypeLabel(property.propertyType),
        ),
        DataTableColumnConfig(
          label: l10n.price,
          getValue: (property) => '\$${property.price.toStringAsFixed(0)}',
          numeric: true,
        ),
        DataTableColumnConfig(
          label: l10n.area,
          getValue: (property) => '${property.area.toStringAsFixed(0)} m²',
          numeric: true,
        ),
        DataTableColumnConfig(
          label: l10n.city,
          getValue: (property) => property.city,
        ),
        DataTableColumnConfig(
          label: l10n.status,
          getValue: (property) => _getStatusLabel(property.status),
          customCell: (property) => Chip(
            label: Text(
              _getStatusLabel(property.status),
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: _getStatusColor(property.status),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
      onEdit: _handleEditProperty,
      onDelete: _handleDeleteProperty,
      rowsPerPage: 10,
    );
  }

  Widget _buildMobileView() {
    final l10n = AppLocalizations.of(context)!;
    return ResponsiveCardList<Property>(
      data: _filteredProperties,
      getTitle: (property) => property.title,
      getSubtitle: (property) =>
          '${property.city} • \$${property.price.toStringAsFixed(0)}',
      getLeading: (property) => CircleAvatar(
        backgroundColor: _getStatusColor(property.status),
        child: Icon(
          _getPropertyTypeIcon(property.propertyType),
          color: Colors.white,
        ),
      ),
      fields: [
        CardField(
          label: l10n.category,
          getValue: (property) => _getCategoryLabel(property.propertyCategory),
        ),
        CardField(
          label: l10n.type,
          getValue: (property) => _getPropertyTypeLabel(property.propertyType),
        ),
        CardField(
          label: l10n.area,
          getValue: (property) => '${property.area.toStringAsFixed(0)} m²',
        ),
        CardField(
          label: l10n.bedrooms,
          getValue: (property) => property.bedrooms?.toString() ?? '-',
        ),
        CardField(
          label: l10n.bathrooms,
          getValue: (property) => property.bathrooms?.toString() ?? '-',
        ),
        CardField(
          label: l10n.address,
          getValue: (property) => property.address,
        ),
        CardField(
          label: l10n.status,
          getValue: (property) => _getStatusLabel(property.status),
          customWidget: (property) => Chip(
            label: Text(_getStatusLabel(property.status)),
            backgroundColor: _getStatusColor(property.status),
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
