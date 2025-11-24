enum PaymentFrequency {
  monthly,
  quarterly,
  semiAnnual,
  annual,
  custom;

  String get displayName {
    switch (this) {
      case PaymentFrequency.monthly:
        return 'Monthly';
      case PaymentFrequency.quarterly:
        return 'Quarterly';
      case PaymentFrequency.semiAnnual:
        return 'Semi-Annual';
      case PaymentFrequency.annual:
        return 'Annual';
      case PaymentFrequency.custom:
        return 'Custom';
    }
  }

  int get daysInterval {
    switch (this) {
      case PaymentFrequency.monthly:
        return 30;
      case PaymentFrequency.quarterly:
        return 90;
      case PaymentFrequency.semiAnnual:
        return 180;
      case PaymentFrequency.annual:
        return 365;
      case PaymentFrequency.custom:
        return 0; // Will be provided separately
    }
  }

  static PaymentFrequency fromString(String value) {
    switch (value.toLowerCase()) {
      case 'monthly':
        return PaymentFrequency.monthly;
      case 'quarterly':
        return PaymentFrequency.quarterly;
      case 'semiannual':
      case 'semi-annual':
        return PaymentFrequency.semiAnnual;
      case 'annual':
        return PaymentFrequency.annual;
      case 'custom':
        return PaymentFrequency.custom;
      default:
        return PaymentFrequency.monthly;
    }
  }

  String toDbString() {
    return toString().split('.').last;
  }
}
