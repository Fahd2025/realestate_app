import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../features/auth/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.read<AuthBloc>().currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: user.logoUrl != null && user.logoUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        user.logoUrl!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildInitials(context, user.fullName);
                        },
                      ),
                    )
                  : _buildInitials(context, user.fullName),
            ),
            const SizedBox(height: 16),
            
            // Name
            Text(
              user.fullName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            
            // Role
            Chip(
              label: Text(user.role.toUpperCase()),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            const SizedBox(height: 24),

            // User information
            Card(
              child: Column(
                children: [
                  _buildInfoTile(
                    context,
                    icon: Icons.person,
                    label: l10n.username,
                    value: user.username,
                  ),
                  const Divider(height: 1),
                  _buildInfoTile(
                    context,
                    icon: Icons.email,
                    label: l10n.email,
                    value: user.email,
                  ),
                  if (user.phone != null) ...[
                    const Divider(height: 1),
                    _buildInfoTile(
                      context,
                      icon: Icons.phone,
                      label: l10n.phone,
                      value: user.phone!,
                    ),
                  ],
                  if (user.address != null) ...[
                    const Divider(height: 1),
                    _buildInfoTile(
                      context,
                      icon: Icons.location_on,
                      label: l10n.address,
                      value: user.address!,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement profile update
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile update feature coming soon'),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: Text(l10n.updateProfile),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement password change
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password change feature coming soon'),
                    ),
                  );
                },
                icon: const Icon(Icons.lock),
                label: Text(l10n.changePassword),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitials(BuildContext context, String name) {
    return Text(
      name[0].toUpperCase(),
      style: const TextStyle(
        fontSize: 48,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
