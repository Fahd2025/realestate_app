import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/enums.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../constants/routes.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../features/company_info/cubit/company_info_cubit.dart';
import 'company_drawer_header.dart';

class MainLayout extends StatefulWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;

  const MainLayout({
    super.key,
    required this.body,
    required this.title,
    this.actions,
    this.floatingActionButton,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Static variable to persist sidebar state across navigation

  @override
  void initState() {
    super.initState();
    // Load company info when layout initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyInfoCubit>().loadCompanyInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    if (authBloc.currentUser == null) {
      // No authenticated user, redirect to login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
      return const Scaffold();
    }
    final userRole = authBloc.getUserRole();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: widget.actions,
      ),
      drawer: _buildDrawer(context, userRole),
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildDrawer(BuildContext context, UserRole userRole) {
    return Drawer(
      child: _buildDrawerContent(context, userRole),
    );
  }

  Widget _buildDrawerContent(BuildContext context, UserRole userRole) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        const CompanyDrawerHeader(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _buildNavItems(context, userRole, isDrawer: true),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text(l10n.logout),
          onTap: () {
            context.read<AuthBloc>().add(LogoutRequested());
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
        ),
      ],
    );
  }

  List<Widget> _buildNavItems(BuildContext context, UserRole userRole,
      {required bool isDrawer}) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final List<_NavItem> items = _getNavItemsData(context, userRole);

    return items.map((item) {
      final isSelected = currentRoute == item.route;
      return ListTile(
        leading: Icon(item.icon),
        title: Text(item.label),
        selected: isSelected,
        onTap: () {
          // Always close the drawer since it's now always a modal drawer
          if (isDrawer) {
            Navigator.pop(context);
          }

          if (!isSelected) {
            Navigator.pushReplacementNamed(context, item.route);
          }
        },
      );
    }).toList();
  }

  List<_NavItem> _getNavItemsData(BuildContext context, UserRole userRole) {
    final l10n = AppLocalizations.of(context)!;

    // Common items
    final dashboard = _NavItem(
      label: l10n.dashboard,
      icon: Icons.dashboard,
      route: AppRoutes.dashboard,
    );

    final settings = _NavItem(
      label: l10n.settings,
      icon: Icons.settings,
      route: AppRoutes.settings,
    );

    List<_NavItem> roleItems = [];

    switch (userRole) {
      case UserRole.admin:
        roleItems = [
          _NavItem(
              label: l10n.manageUsers,
              icon: Icons.people,
              route: AppRoutes.adminUsers),
          _NavItem(
              label: l10n.manageProperties,
              icon: Icons.home_work,
              route: AppRoutes.adminProperties),
          _NavItem(
              label: l10n.buyerRequests,
              icon: Icons.shopping_cart,
              route: AppRoutes.adminBuyerRequests),
          _NavItem(
              label: l10n.purchaseContracts,
              icon: Icons.description,
              route: AppRoutes.contractsPurchase),
          _NavItem(
              label: l10n.leaseContracts,
              icon: Icons.key,
              route: AppRoutes.contractsLease),
          _NavItem(
              label: l10n.basicData,
              icon: Icons.settings_input_component,
              route: AppRoutes.adminBasicData),
        ];
        break;
      case UserRole.owner:
        roleItems = [
          _NavItem(
              label: l10n.myProperties,
              icon: Icons.home,
              route: AppRoutes.ownerProperties),
          _NavItem(
              label: l10n.purchaseContracts,
              icon: Icons.shopping_cart,
              route: AppRoutes.contractsPurchase),
          _NavItem(
              label: l10n.leaseContracts,
              icon: Icons.key,
              route: AppRoutes.contractsLease),
        ];
        break;
      case UserRole.tenant:
        roleItems = [
          _NavItem(
              label: l10n.contracts,
              icon: Icons.description,
              route: AppRoutes.tenantContracts),
          _NavItem(
              label: l10n.payments,
              icon: Icons.payment,
              route: AppRoutes.tenantPayments),
        ];
        break;
      case UserRole.buyer:
        roleItems = [
          _NavItem(
              label: l10n.browseProperties,
              icon: Icons.search,
              route: AppRoutes.buyerBrowse),
          _NavItem(
              label: l10n.myRequests,
              icon: Icons.request_quote,
              route: AppRoutes.buyerRequests),
          _NavItem(
              label: l10n.purchaseContracts,
              icon: Icons.description,
              route: AppRoutes.buyerContracts),
        ];
        break;
    }

    return [dashboard, ...roleItems, settings];
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String route;

  _NavItem({required this.label, required this.icon, required this.route});
}
