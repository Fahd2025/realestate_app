# Font Configuration Summary

## Overview

The Real Estate Application now uses custom Arabic fonts throughout the application and in PDF documents.

## Font Usage

### 1. Application UI - DINNextLTArabic

**Location:** Throughout the entire Flutter application
**Font Family:** `DINNextLTArabic`
**Weights Available:**

- Regular (400) - `DINNextLTArabic-Regular.ttf`
- Medium (500) - `DINNextLTArabic-Medium.ttf`
- Bold (700) - `DINNextLTArabic-Bold.ttf`

**Configuration:**

- Set in `lib/core/theme/app_theme.dart`
- Applied to both light and dark themes
- Used for all UI text, buttons, labels, etc.

### 2. PDF Documents - NotoSansArabic

**Location:** Contract PDFs and Payment Receipts
**Font Family:** `NotoSansArabic`
**Weight Available:**

- Regular (400) - `NotoSansArabic-Regular.ttf`

**Used In:**

- Contract PDF Generator (`lib/features/contracts/utils/contract_pdf_generator.dart`)
- Payment Receipt Generator (`lib/features/payments/services/payment_receipt_generator.dart`)

## Font Files Location

All font files are stored in: `assets/fonts/`

```
assets/fonts/
├── DINNextLTArabic-Regular.ttf
├── DINNextLTArabic-Medium.ttf
├── DINNextLTArabic-Bold.ttf
└── NotoSansArabic-Regular.ttf
```

## Implementation Details

### Theme Configuration

```dart
// In app_theme.dart
ThemeData(
  fontFamily: 'DINNextLTArabic',
  // ... other theme properties
)
```

### PDF Font Loading

```dart
// Load from assets
final fontData = await rootBundle.load('assets/fonts/NotoSansArabic-Regular.ttf');
final font = pw.Font.ttf(fontData);
```

## Benefits

1. **Consistent Arabic Typography:** DINNextLTArabic provides excellent Arabic text rendering throughout the app
2. **Reliable PDF Generation:** NotoSansArabic ensures proper Arabic text display in printed/shared documents
3. **Offline Support:** Fonts are bundled with the app, no internet required
4. **Better Performance:** Local fonts load faster than Google Fonts

## Files Modified

1. `lib/core/theme/app_theme.dart` - Added fontFamily to both themes
2. `lib/features/contracts/utils/contract_pdf_generator.dart` - Updated to use local NotoSansArabic
3. `lib/features/payments/services/payment_receipt_generator.dart` - Updated to use local NotoSansArabic
4. `pubspec.yaml` - Font declarations (already configured)

## Testing

To verify the fonts are working:

1. **UI:** Navigate through the app and verify Arabic text displays correctly
2. **PDFs:** Generate a contract PDF and verify Arabic text renders properly
3. **Receipts:** Generate a payment receipt and verify Arabic text renders properly
