// Enums for the real estate application

enum UserRole {
  admin,
  owner,
  tenant,
  buyer,
}

enum PropertyType {
  apartment,
  house,
  villa,
  land,
  commercial,
}

enum ListingType {
  sale,
  rent,
}

enum PropertyStatus {
  available,
  rented,
  sold,
  pending,
}

enum ContractType {
  sale,
  rent,
}

enum ContractStatus {
  draft,
  active,
  completed,
  cancelled,
}

enum PaymentType {
  rent,
  deposit,
  purchase,
  installment,
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}

enum PurchaseRequestStatus {
  pending,
  accepted,
  rejected,
  negotiating,
}

enum SyncStatus {
  synced,
  pending,
  failed,
}
