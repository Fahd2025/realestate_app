import 'package:flutter/material.dart';
import '../core/models/enums.dart';
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/owner/screens/owner_dashboard_screen.dart';
import '../features/tenant/screens/tenant_dashboard_screen.dart';
import '../features/buyer/screens/buyer_dashboard_screen.dart';

class DashboardRouter extends StatelessWidget {
  final UserRole userRole;

  const DashboardRouter({
    super.key,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    switch (userRole) {
      case UserRole.admin:
        return const AdminDashboardScreen();
      case UserRole.owner:
        return const OwnerDashboardScreen();
      case UserRole.tenant:
        return const TenantDashboardScreen();
      case UserRole.buyer:
        return const BuyerDashboardScreen();
    }
  }
}
