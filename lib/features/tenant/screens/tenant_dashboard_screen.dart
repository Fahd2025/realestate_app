import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../features/auth/bloc/auth_bloc.dart';
import '../../../core/constants/routes.dart';
import '../../../core/widgets/main_layout.dart';

class TenantDashboardScreen extends StatelessWidget {
  const TenantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.read<AuthBloc>().currentUser!;

    return MainLayout(
      title: l10n.dashboard,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        user.fullName[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${user.fullName}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            l10n.tenant,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick access
            Text(
              'Quick Access',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              icon: Icons.description,
              title: l10n.myContracts,
              subtitle: 'View your rental contracts',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.tenantContracts);
              },
            ),
            const SizedBox(height: 12),
            _buildMenuCard(
              context,
              icon: Icons.payment,
              title: l10n.paymentHistory,
              subtitle: 'View payment history',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.tenantPayments);
              },
            ),
            const SizedBox(height: 12),
            _buildMenuCard(
              context,
              icon: Icons.home,
              title: 'My Property',
              subtitle: 'View property details',
              onTap: () {
                // TODO: Navigate to property details
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
