import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/database/database.dart';
import '../../../core/widgets/main_layout.dart';
import '../../../core/widgets/responsive_data_table.dart';
import '../../../core/widgets/responsive_card_list.dart';
import '../../../core/widgets/confirmation_dialog.dart';
import '../../../core/widgets/search_filter_bar.dart';
import '../widgets/user_form_modal.dart';

/// Comprehensive user management screen with CRUD operations
class UserManagementScreen extends StatefulWidget {
  final AppDatabase database;

  const UserManagementScreen({
    super.key,
    required this.database,
  });

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String? _selectedRoleFilter;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);

    try {
      final users = await widget.database.select(widget.database.users).get();
      setState(() {
        _users = users;
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorLoadingUsers(e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _applyFilters() {
    _filteredUsers = _users.where((user) {
      // Search filter
      final matchesSearch = _searchQuery.isEmpty ||
          user.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.username.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (user.phone?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);

      // Role filter
      final matchesRole =
          _selectedRoleFilter == null || user.role == _selectedRoleFilter;

      return matchesSearch && matchesRole;
    }).toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _onRoleFilterChanged(String? role) {
    setState(() {
      _selectedRoleFilter = role;
      _applyFilters();
    });
  }

  Future<void> _handleAddUser() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserFormModal(
        database: widget.database,
      ),
    );

    if (result == true) {
      _loadUsers();
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.userCreatedSuccessfully)),
        );
      }
    }
  }

  Future<void> _handleEditUser(User user) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserFormModal(
        database: widget.database,
        user: user,
      ),
    );

    if (result == true) {
      _loadUsers();
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.userUpdatedSuccessfully)),
        );
      }
    }
  }

  Future<void> _handleDeleteUser(User user) async {
    final l10n = AppLocalizations.of(context)!;
    await ConfirmationDialog.show(
      context: context,
      title: l10n.deleteUser,
      message: l10n.deleteUserConfirmation(user.fullName),
      confirmText: l10n.delete,
      isDangerous: true,
      onConfirm: () async {
        try {
          await (widget.database.delete(widget.database.users)
                ..where((tbl) => tbl.id.equals(user.id)))
              .go();

          _loadUsers();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.userDeletedSuccessfully)),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.errorDeletingUser(e.toString())),
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
      title: l10n.manageUsers,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddUser,
        icon: const Icon(Icons.add),
        label: Text(l10n.addUser),
      ),
      body: Column(
        children: [
          // Search and filter bar
          SearchFilterBar(
            searchHint: l10n.searchByNameEmailUsername,
            onSearchChanged: _onSearchChanged,
            filterChips: [
              FilterChip(
                label: Text(l10n.all),
                selected: _selectedRoleFilter == null,
                onSelected: (_) => _onRoleFilterChanged(null),
              ),
              FilterChip(
                label: Text(l10n.admin),
                selected: _selectedRoleFilter == 'admin',
                onSelected: (_) => _onRoleFilterChanged('admin'),
              ),
              FilterChip(
                label: Text(l10n.owner),
                selected: _selectedRoleFilter == 'owner',
                onSelected: (_) => _onRoleFilterChanged('owner'),
              ),
              FilterChip(
                label: Text(l10n.tenant),
                selected: _selectedRoleFilter == 'tenant',
                onSelected: (_) => _onRoleFilterChanged('tenant'),
              ),
              FilterChip(
                label: Text(l10n.buyer),
                selected: _selectedRoleFilter == 'buyer',
                onSelected: (_) => _onRoleFilterChanged('buyer'),
              ),
            ],
          ),

          // Data display
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredUsers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noUsersFound,
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
    return ResponsiveDataTable<User>(
      data: _filteredUsers,
      columns: [
        DataTableColumnConfig(
          label: l10n.username,
          getValue: (user) => user.username,
        ),
        DataTableColumnConfig(
          label: l10n.fullName,
          getValue: (user) => user.fullName,
        ),
        DataTableColumnConfig(
          label: l10n.email,
          getValue: (user) => user.email,
        ),
        DataTableColumnConfig(
          label: l10n.phone,
          getValue: (user) => user.phone ?? '-',
        ),
        DataTableColumnConfig(
          label: l10n.role,
          getValue: (user) => _getRoleLabel(user.role),
          customCell: (user) => Chip(
            label: Text(
              _getRoleLabel(user.role),
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: _getRoleColor(user.role),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
        DataTableColumnConfig(
          label: l10n.status,
          getValue: (user) => user.isActive ? l10n.active : l10n.inactive,
          customCell: (user) => Chip(
            label: Text(
              user.isActive ? l10n.active : l10n.inactive,
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: user.isActive
                ? Colors.green.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
      onEdit: _handleEditUser,
      onDelete: _handleDeleteUser,
      rowsPerPage: 10,
    );
  }

  Widget _buildMobileView() {
    final l10n = AppLocalizations.of(context)!;
    return ResponsiveCardList<User>(
      data: _filteredUsers,
      getTitle: (user) => user.fullName,
      getSubtitle: (user) => user.email,
      getLeading: (user) => CircleAvatar(
        backgroundColor: _getRoleColor(user.role),
        child: Text(
          user.fullName[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      fields: [
        CardField(
          label: l10n.username,
          getValue: (user) => user.username,
        ),
        CardField(
          label: l10n.phone,
          getValue: (user) => user.phone ?? '-',
        ),
        CardField(
          label: l10n.nationalId,
          getValue: (user) => user.nationalId ?? '-',
        ),
        CardField(
          label: l10n.address,
          getValue: (user) => user.address ?? '-',
        ),
        CardField(
          label: l10n.role,
          getValue: (user) => _getRoleLabel(user.role),
          customWidget: (user) => Chip(
            label: Text(_getRoleLabel(user.role)),
            backgroundColor: _getRoleColor(user.role),
          ),
        ),
        CardField(
          label: l10n.status,
          getValue: (user) => user.isActive ? l10n.active : l10n.inactive,
          customWidget: (user) => Chip(
            label: Text(user.isActive ? l10n.active : l10n.inactive),
            backgroundColor: user.isActive
                ? Colors.green.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
          ),
        ),
      ],
      onEdit: _handleEditUser,
      onDelete: _handleDeleteUser,
    );
  }

  String _getRoleLabel(String role) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case 'admin':
        return l10n.admin;
      case 'owner':
        return l10n.owner;
      case 'tenant':
        return l10n.tenant;
      case 'buyer':
        return l10n.buyer;
      default:
        return role;
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return Colors.purple.withOpacity(0.2);
      case 'owner':
        return Colors.blue.withOpacity(0.2);
      case 'tenant':
        return Colors.orange.withOpacity(0.2);
      case 'buyer':
        return Colors.teal.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }
}
