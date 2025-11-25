import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import 'package:realestate_app/core/widgets/main_layout.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/database/database.dart';
import '../../buyer/widgets/property_request_form_modal.dart';

class AdminBuyerRequestsScreen extends StatefulWidget {
  final AppDatabase database;

  const AdminBuyerRequestsScreen({
    super.key,
    required this.database,
  });

  @override
  State<AdminBuyerRequestsScreen> createState() =>
      _AdminBuyerRequestsScreenState();
}

class _AdminBuyerRequestsScreenState extends State<AdminBuyerRequestsScreen> {
  List<PropertyRequest> _requests = [];
  List<PropertyRequest> _filteredRequests = [];
  Map<String, User> _buyers = {};
  bool _isLoading = true;
  String? _selectedStatusFilter;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    setState(() => _isLoading = true);

    try {
      final requests =
          await widget.database.select(widget.database.propertyRequests).get();

      // Load buyer information
      final buyerIds = requests.map((o) => o.buyerId).toSet();
      final buyers = await (widget.database.select(widget.database.users)
            ..where((tbl) => tbl.id.isIn(buyerIds)))
          .get();

      final buyersMap = {for (var buyer in buyers) buyer.id: buyer};

      setState(() {
        _requests = requests;
        _buyers = buyersMap;
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
    _filteredRequests = _requests.where((request) {
      final matchesStatus = _selectedStatusFilter == null ||
          request.status == _selectedStatusFilter;
      return matchesStatus;
    }).toList();
  }

  void _onStatusFilterChanged(String? status) {
    setState(() {
      _selectedStatusFilter = status;
      _applyFilters();
    });
  }

  Future<void> _changeRequestStatus(PropertyRequest request) async {
    final l10n = AppLocalizations.of(context)!;

    final newStatus = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.changeStatus),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.pending),
              onTap: () => Navigator.pop(context, 'pending'),
            ),
            ListTile(
              title: Text(l10n.confirmed),
              onTap: () => Navigator.pop(context, 'confirmed'),
            ),
            ListTile(
              title: Text(l10n.completed),
              onTap: () => Navigator.pop(context, 'completed'),
            ),
            ListTile(
              title: Text(l10n.cancelled),
              onTap: () => Navigator.pop(context, 'cancelled'),
            ),
          ],
        ),
      ),
    );

    if (newStatus != null && newStatus != request.status) {
      try {
        // Update request status
        await (widget.database.update(widget.database.propertyRequests)
              ..where((tbl) => tbl.id.equals(request.id)))
            .write(
          PropertyRequestsCompanion(
            status: drift.Value(newStatus),
            updatedAt: drift.Value(DateTime.now()),
          ),
        );

        // Create notification for buyer
        await widget.database.into(widget.database.notifications).insert(
              NotificationsCompanion.insert(
                id: const Uuid().v4(),
                userId: request.buyerId,
                title: l10n.requestStatus,
                message:
                    'Your request #${request.id.substring(0, 8)} status changed to $newStatus',
                createdAt: DateTime.now(),
              ),
            );

        _loadRequests();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.statusUpdated)),
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
    }
  }

  String _getCategoryLabel(String category) {
    final l10n = AppLocalizations.of(context)!;
    return category == 'residential' ? l10n.residential : l10n.commercial;
  }

  String _getUrgencyLabel(String urgency) {
    final l10n = AppLocalizations.of(context)!;
    switch (urgency) {
      case 'sooner':
        return l10n.sooner;
      case 'after_a_while':
        return l10n.afterAWhile;
      case 'can_wait':
        return l10n.canWait;
      default:
        return urgency;
    }
  }

  String _getStatusLabel(String status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'pending':
        return l10n.pending;
      case 'confirmed':
        return l10n.confirmed;
      case 'completed':
        return l10n.completed;
      case 'cancelled':
        return l10n.cancelled;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange.withValues(alpha: 0.2);
      case 'confirmed':
        return Colors.blue.withValues(alpha: 0.2);
      case 'completed':
        return Colors.green.withValues(alpha: 0.2);
      case 'cancelled':
        return Colors.red.withValues(alpha: 0.2);
      default:
        return Colors.grey.withValues(alpha: 0.2);
    }
  }

  Future<void> _handleAddRequest() async {
    final l10n = AppLocalizations.of(context)!;

    // Open request form directly - buyer selection is now in the form
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PropertyRequestFormModal(
        database: widget.database,
        buyerId: '', // Empty string, will be selected in form
        isAdminMode: true,
      ),
    );

    if (result == true) {
      _loadRequests();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.requestSubmitted)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MainLayout(
      title: l10n.buyerRequests,
      actions: [
        IconButton(
          onPressed: _handleAddRequest,
          icon: const Icon(Icons.add),
          tooltip: l10n.placeRequest,
        ),
      ],
      body: Column(
        children: [
          // Filter bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: Text(l10n.all),
                    selected: _selectedStatusFilter == null,
                    onSelected: (_) => _onStatusFilterChanged(null),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Text(l10n.pending),
                    selected: _selectedStatusFilter == 'pending',
                    onSelected: (_) => _onStatusFilterChanged('pending'),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Text(l10n.confirmed),
                    selected: _selectedStatusFilter == 'confirmed',
                    onSelected: (_) => _onStatusFilterChanged('confirmed'),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Text(l10n.completed),
                    selected: _selectedStatusFilter == 'completed',
                    onSelected: (_) => _onStatusFilterChanged('completed'),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Text(l10n.cancelled),
                    selected: _selectedStatusFilter == 'cancelled',
                    onSelected: (_) => _onStatusFilterChanged('cancelled'),
                  ),
                ],
              ),
            ),
          ),

          // Requests list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredRequests.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noRequests,
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
                            return _buildDataTable(l10n);
                          } else {
                            return _buildMobileList(l10n);
                          }
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text(l10n.buyer)),
            DataColumn(label: Text(l10n.category)),
            DataColumn(label: Text(l10n.type)),
            DataColumn(label: Text(l10n.location)),
            DataColumn(label: Text(l10n.minPrice)),
            DataColumn(label: Text(l10n.maxPrice)),
            DataColumn(label: Text(l10n.urgency)),
            DataColumn(label: Text(l10n.status)),
            DataColumn(label: Text(l10n.actions)),
          ],
          rows: _filteredRequests.map((request) {
            final buyer = _buyers[request.buyerId];
            return DataRow(
              cells: [
                DataCell(Text(buyer?.fullName ?? 'Unknown')),
                DataCell(Text(_getCategoryLabel(request.propertyCategory))),
                DataCell(Text(request.propertyType ?? '-')),
                DataCell(Text(request.location)),
                DataCell(Text(request.minPrice != null
                    ? '\$${request.minPrice!.toStringAsFixed(0)}'
                    : '-')),
                DataCell(Text(request.maxPrice != null
                    ? '\$${request.maxPrice!.toStringAsFixed(0)}'
                    : '-')),
                DataCell(Text(_getUrgencyLabel(request.urgency))),
                DataCell(
                  Chip(
                    label: Text(_getStatusLabel(request.status)),
                    backgroundColor: _getStatusColor(request.status),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: l10n.changeStatus,
                        onPressed: () => _changeRequestStatus(request),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_note),
                        tooltip: l10n.edit,
                        onPressed: () => _handleEditRequest(request),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: l10n.delete,
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () => _handleDeleteRequest(request),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMobileList(AppLocalizations l10n) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredRequests.length,
      itemBuilder: (context, index) {
        final request = _filteredRequests[index];
        final buyer = _buyers[request.buyerId];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(request.status),
              child: const Icon(Icons.shopping_cart),
            ),
            title: Text(buyer?.fullName ?? 'Unknown Buyer'),
            subtitle: Text(
              '${_getCategoryLabel(request.propertyCategory)} • ${request.location}',
            ),
            trailing: Chip(
              label: Text(_getStatusLabel(request.status)),
              backgroundColor: _getStatusColor(request.status),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      l10n.category,
                      _getCategoryLabel(request.propertyCategory),
                    ),
                    if (request.propertyType != null)
                      _buildDetailRow(
                        l10n.type,
                        request.propertyType!,
                      ),
                    if (request.minPrice != null)
                      _buildDetailRow(
                        l10n.minPrice,
                        '\$${request.minPrice!.toStringAsFixed(0)}',
                      ),
                    if (request.maxPrice != null)
                      _buildDetailRow(
                        l10n.maxPrice,
                        '\$${request.maxPrice!.toStringAsFixed(0)}',
                      ),
                    _buildDetailRow(
                      l10n.preferredLocation,
                      request.location,
                    ),
                    _buildDetailRow(
                      l10n.urgency,
                      _getUrgencyLabel(request.urgency),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => _changeRequestStatus(request),
                            icon: const Icon(Icons.edit_note),
                            label: Text(l10n.changeStatus),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _handleEditRequest(request),
                            icon: const Icon(Icons.edit),
                            label: Text(l10n.edit),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          onPressed: () => _handleDeleteRequest(request),
                          icon: const Icon(Icons.delete),
                          color: Colors.white,
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleEditRequest(PropertyRequest request) async {
    final l10n = AppLocalizations.of(context)!;

    // Show the request form with existing data
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PropertyRequestFormModal(
        database: widget.database,
        buyerId: request.buyerId,
        existingRequest: request,
        isAdminMode: true,
      ),
    );

    if (result == true) {
      _loadRequests();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.success)),
        );
      }
    }
  }

  Future<void> _handleDeleteRequest(PropertyRequest request) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.delete),
        content: Text(
            '${l10n.confirmDelete}\n\nRequest #${request.id.substring(0, 8)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await (widget.database.delete(widget.database.propertyRequests)
              ..where((tbl) => tbl.id.equals(request.id)))
            .go();

        _loadRequests();

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
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
