// API endpoint constants

class ApiEndpoints {
  static String baseUrl = '';

  // Auth endpoints
  static String get login => '$baseUrl/api/auth/login';
  static String get logout => '$baseUrl/api/auth/logout';
  static String get refresh => '$baseUrl/api/auth/refresh';

  // User endpoints
  static String get users => '$baseUrl/api/users';
  static String user(String id) => '$baseUrl/api/users/$id';

  // Property endpoints
  static String get properties => '$baseUrl/api/properties';
  static String property(String id) => '$baseUrl/api/properties/$id';
  static String propertyImages(String id) => '$baseUrl/api/properties/$id/images';
  static String propertyImage(String id, String imageId) => 
      '$baseUrl/api/properties/$id/images/$imageId';

  // Contract endpoints
  static String get contracts => '$baseUrl/api/contracts';
  static String contract(String id) => '$baseUrl/api/contracts/$id';
  static String contractPdf(String id) => '$baseUrl/api/contracts/$id/pdf';

  // Payment endpoints
  static String get payments => '$baseUrl/api/payments';
  static String payment(String id) => '$baseUrl/api/payments/$id';

  // Purchase request endpoints
  static String get purchaseRequests => '$baseUrl/api/purchase-requests';
  static String purchaseRequest(String id) => '$baseUrl/api/purchase-requests/$id';

  // Sync endpoints
  static String get syncPull => '$baseUrl/api/sync/pull';
  static String get syncPush => '$baseUrl/api/sync/push';
  static String get syncStatus => '$baseUrl/api/sync/status';

  // Update base URL
  static void updateBaseUrl(String url) {
    baseUrl = url;
  }
}
