import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/database/database.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:drift/drift.dart' as drift;

/// User form modal bottom sheet for creating and editing users
class UserFormModal extends StatefulWidget {
  final User? user; // null for create, non-null for edit
  final AppDatabase database;

  const UserFormModal({
    super.key,
    this.user,
    required this.database,
  });

  @override
  State<UserFormModal> createState() => _UserFormModalState();
}

class _UserFormModalState extends State<UserFormModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;
  late TextEditingController _fullNameArController;
  late TextEditingController _phoneController;
  late TextEditingController _nationalIdController;
  late TextEditingController _addressController;

  String _selectedRole = 'tenant';
  bool _isActive = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = widget.user;

    _usernameController = TextEditingController(text: user?.username ?? '');
    _passwordController = TextEditingController();
    _emailController = TextEditingController(text: user?.email ?? '');
    _fullNameController = TextEditingController(text: user?.fullName ?? '');
    _fullNameArController = TextEditingController(text: user?.fullNameAr ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _nationalIdController = TextEditingController(text: user?.nationalId ?? '');
    _addressController = TextEditingController(text: user?.address ?? '');

    if (user != null) {
      _selectedRole = user.role;
      _isActive = user.isActive;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _fullNameArController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();

      if (widget.user == null) {
        // Create new user
        final passwordHash =
            sha256.convert(utf8.encode(_passwordController.text)).toString();

        await widget.database.into(widget.database.users).insert(
              UsersCompanion.insert(
                id: const Uuid().v4(),
                username: _usernameController.text.trim(),
                passwordHash: passwordHash,
                email: _emailController.text.trim(),
                fullName: _fullNameController.text.trim(),
                fullNameAr: drift.Value(
                    _fullNameArController.text.trim().isEmpty
                        ? null
                        : _fullNameArController.text.trim()),
                phone: drift.Value(_phoneController.text.trim().isEmpty
                    ? null
                    : _phoneController.text.trim()),
                nationalId: drift.Value(
                    _nationalIdController.text.trim().isEmpty
                        ? null
                        : _nationalIdController.text.trim()),
                role: _selectedRole,
                address: drift.Value(_addressController.text.trim().isEmpty
                    ? null
                    : _addressController.text.trim()),
                isActive: drift.Value(_isActive),
                createdAt: now,
                updatedAt: now,
              ),
            );
      } else {
        // Update existing user
        final update = UsersCompanion(
          username: drift.Value(_usernameController.text.trim()),
          email: drift.Value(_emailController.text.trim()),
          fullName: drift.Value(_fullNameController.text.trim()),
          fullNameAr: drift.Value(_fullNameArController.text.trim().isEmpty
              ? null
              : _fullNameArController.text.trim()),
          phone: drift.Value(_phoneController.text.trim().isEmpty
              ? null
              : _phoneController.text.trim()),
          nationalId: drift.Value(_nationalIdController.text.trim().isEmpty
              ? null
              : _nationalIdController.text.trim()),
          role: drift.Value(_selectedRole),
          address: drift.Value(_addressController.text.trim().isEmpty
              ? null
              : _addressController.text.trim()),
          isActive: drift.Value(_isActive),
          updatedAt: drift.Value(now),
        );

        // Update password if provided
        if (_passwordController.text.isNotEmpty) {
          final passwordHash =
              sha256.convert(utf8.encode(_passwordController.text)).toString();
          await (widget.database.update(widget.database.users)
                ..where((tbl) => tbl.id.equals(widget.user!.id)))
              .write(update.copyWith(passwordHash: drift.Value(passwordHash)));
        } else {
          await (widget.database.update(widget.database.users)
                ..where((tbl) => tbl.id.equals(widget.user!.id)))
              .write(update);
        }
      }

      if (mounted) {
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving user: ${e.toString()}'),
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
    final isEdit = widget.user != null;

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
                        isEdit ? l10n.editUser : l10n.addNewUser,
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
                      // Username
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: l10n.username,
                          prefixIcon: const Icon(Icons.person),
                        ),
                        enabled: !isEdit, // Username cannot be changed
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _fullNameArController,
                        decoration: InputDecoration(
                          labelText: l10n.fullNameArabic,
                          prefixIcon: const Icon(Icons.badge),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Phone
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: l10n.phone,
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),

                      // National ID
                      TextFormField(
                        controller: _nationalIdController,
                        decoration: InputDecoration(
                          labelText: l10n.nationalId,
                          prefixIcon: const Icon(Icons.credit_card),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Address
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: l10n.address,
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),

                      // Role
                      DropdownButtonFormField<String>(
                        initialValue: _selectedRole,
                        decoration: InputDecoration(
                          labelText: l10n.role,
                          prefixIcon: const Icon(Icons.work),
                        ),
                        items: [
                          DropdownMenuItem(
                              value: 'admin', child: Text(l10n.admin)),
                          DropdownMenuItem(
                              value: 'owner', child: Text(l10n.owner)),
                          DropdownMenuItem(
                              value: 'tenant', child: Text(l10n.tenant)),
                          DropdownMenuItem(
                              value: 'buyer', child: Text(l10n.buyer)),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedRole = value);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Active status
                      SwitchListTile(
                        title: Text(l10n.active),
                        subtitle: Text(l10n.userCanLogin),
                        value: _isActive,
                        onChanged: (value) => setState(() => _isActive = value),
                      ),
                      const SizedBox(height: 24),

                      // Save button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _saveUser,
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
                            : Text(isEdit ? l10n.updateUser : l10n.createUser),
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

  // static Future<bool?> show({
  //   required BuildContext context,
  //   required AppDatabase database,
  //   User? user,
  // }) {
  //   return showModalBottomSheet<bool>(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => UserFormModal(
  //       user: user,
  //       database: database,
  //     ),
  //   );
  // }
}
