import 'package:realestate_app/l10n/app_localizations.dart';

enum PaymentFrequency {
  monthly,
  quarterly,
  semiAnnual,
  annual,
  custom;

  String getDisplayName(AppLocalizations l10n) {
    switch (this) {
      case PaymentFrequency.monthly:
        return l10n.monthly;
      case PaymentFrequency.quarterly:
        return l10n.quarterly;
      case PaymentFrequency.semiAnnual:
        return l10n.semiAnnual;
      case PaymentFrequency.annual:
        return l10n.annual;
      case PaymentFrequency.custom:
        return l10n.custom;
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
