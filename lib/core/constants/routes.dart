// Route constants for the application

class AppRoutes {
  // Auth routes
  static const String login = '/login';
  static const String register = '/register';

  // Common routes
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Admin routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminProperties = '/admin/properties';
  static const String adminContracts = '/admin/contracts';
  static const String adminPayments = '/admin/payments';
  static const String adminPurchaseRequests = '/admin/purchase-requests';

  // Owner routes
  static const String ownerDashboard = '/owner/dashboard';
  static const String ownerProperties = '/owner/properties';
  static const String ownerContracts = '/owner/contracts';
  static const String ownerTenants = '/owner/tenants';
  static const String ownerBuyers = '/owner/buyers';

  // Tenant routes
  static const String tenantDashboard = '/tenant/dashboard';
  static const String tenantContracts = '/tenant/contracts';
  static const String tenantPayments = '/tenant/payments';
  static const String tenantProperty = '/tenant/property';

  // Buyer routes
  static const String buyerDashboard = '/buyer/dashboard';
  static const String buyerBrowse = '/buyer/browse';
  static const String buyerRequests = '/buyer/requests';
  static const String buyerContracts = '/buyer/contracts';
  static const String buyerPayments = '/buyer/payments';

  // Property details
  static const String propertyDetails = '/property/details';

  // Contract routes
  static const String contractsBuy = '/contracts/buy';
  static const String contractsRent = '/contracts/rent';
}
