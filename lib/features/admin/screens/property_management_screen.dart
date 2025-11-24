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

      // Type filter
      final matchesType = _selectedTypeFilter == null ||
          property.propertyType == _selectedTypeFilter;

      // Listing filter
      final matchesListing = _selectedListingFilter == null ||
          property.listingType == _selectedListingFilter;

      // Status filter
      final matchesStatus = _selectedStatusFilter == null ||
          property.status == _selectedStatusFilter;

      return matchesSearch && matchesType && matchesListing && matchesStatus;
    }).toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
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
              // Type filters
              FilterChip(
                label: Text(l10n.all),
                selected: _selectedTypeFilter == null,
                onSelected: (_) => _onTypeFilterChanged(null),
              ),
              FilterChip(
                label: Text(l10n.apartment),
                selected: _selectedTypeFilter == 'apartment',
                onSelected: (_) => _onTypeFilterChanged('apartment'),
              ),
              FilterChip(
                label: Text(l10n.house),
                selected: _selectedTypeFilter == 'house',
                onSelected: (_) => _onTypeFilterChanged('house'),
              ),
              FilterChip(
                label: Text(l10n.villa),
                selected: _selectedTypeFilter == 'villa',
                onSelected: (_) => _onTypeFilterChanged('villa'),
              ),
              FilterChip(
                label: Text(l10n.land),
                selected: _selectedTypeFilter == 'land',
                onSelected: (_) => _onTypeFilterChanged('land'),
              ),
              FilterChip(
                label: Text(l10n.commercial),
                selected: _selectedTypeFilter == 'commercial',
                onSelected: (_) => _onTypeFilterChanged('commercial'),
              ),
            ],
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

  String _getPropertyTypeLabel(String type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case 'apartment':
        return l10n.apartment;
      case 'house':
        return l10n.house;
      case 'villa':
        return l10n.villa;
      case 'land':
        return l10n.land;
      case 'commercial':
        return l10n.commercial;
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
      case 'land':
        return Icons.landscape;
      case 'commercial':
        return Icons.business;
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
