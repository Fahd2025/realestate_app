import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/enums.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../constants/routes.dart';
import 'package:realestate_app/l10n/app_localizations.dart';

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
  static bool _isDrawerOpen = true;

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
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            // Sidebar (Drawer or Rail)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _isDrawerOpen ? 250 : 72,
              child: Material(
                elevation: 1,
                color: Theme.of(context).colorScheme.surface,
                child: _isDrawerOpen
                    ? _buildDrawerContent(context, userRole)
                    : _buildNavigationRail(context, userRole),
              ),
            ),
            // Main Content Area
            Expanded(
              child: Column(
                children: [
                  // AppBar
                  SizedBox(
                    height: kToolbarHeight,
                    child: AppBar(
                      title: Text(widget.title),
                      leading: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            _isDrawerOpen = !_isDrawerOpen;
                          });
                        },
                      ),
                      actions: widget.actions,
                      elevation: 0,
                      scrolledUnderElevation: 0,
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                    ),
                  ),
                  // Body
                  Expanded(child: widget.body),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
      );
    }

    // Mobile Layout
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
        UserAccountsDrawerHeader(
          accountName:
              Text(context.read<AuthBloc>().currentUser?.fullName ?? ''),
          accountEmail: Text(context.read<AuthBloc>().currentUser?.email ?? ''),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            child: Text(
              (context.read<AuthBloc>().currentUser?.fullName ?? 'U')[0]
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          otherAccountsPictures: [
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.profile);
              },
              tooltip: l10n.profile,
            ),
          ],
        ),
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

  Widget _buildNavigationRail(BuildContext context, UserRole userRole) {
    final l10n = AppLocalizations.of(context)!;
    final selectedIndex = _getSelectedIndex(context, userRole);

    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        _onDestinationSelected(context, index, userRole);
      },
      labelType: NavigationRailLabelType.none,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: CircleAvatar(
          child: Text(
            (context.read<AuthBloc>().currentUser?.fullName ?? 'U')[0]
                .toUpperCase(),
          ),
        ),
      ),
      destinations: _getDestinations(context, userRole),
      trailing: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              tooltip: l10n.logout,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context, UserRole userRole,
      {required bool isDrawer}) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final List<_NavItem> items = _getNavItemsData(context, userRole);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return items.map((item) {
      final isSelected = currentRoute == item.route;
      return ListTile(
        leading: Icon(item.icon),
        title: Text(item.label),
        selected: isSelected,
        onTap: () {
          // Only close the drawer if we are on mobile (where it's a modal drawer)
          if (isDrawer && !isDesktop) {
            Navigator.pop(context);
          }

          if (!isSelected) {
            Navigator.pushReplacementNamed(context, item.route);
          }
        },
      );
    }).toList();
  }

  List<NavigationRailDestination> _getDestinations(
      BuildContext context, UserRole userRole) {
    final items = _getNavItemsData(context, userRole);
    return items.map((item) {
      return NavigationRailDestination(
        icon: Icon(item.icon),
        label: Text(item.label),
      );
    }).toList();
  }

  int? _getSelectedIndex(BuildContext context, UserRole userRole) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final items = _getNavItemsData(context, userRole);

    final index = items.indexWhere((item) => item.route == currentRoute);
    return index != -1 ? index : 0; // Default to 0 if not found
  }

  void _onDestinationSelected(
      BuildContext context, int index, UserRole userRole) {
    final items = _getNavItemsData(context, userRole);
    final item = items[index];
    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute != item.route) {
      Navigator.pushReplacementNamed(context, item.route);
    }
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
