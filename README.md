# Real Estate Application

A comprehensive Flutter real estate application supporting buying, selling, and renting services with multi-role access, offline functionality, and bilingual support (Arabic/English).

## Features

- **Multi-Role Support**: Admin, Owner, Tenant, and Buyer roles with specific dashboards
- **Offline-First**: Local database with optional API synchronization
- **Bilingual**: Full Arabic and English support with RTL layout
- **Theme Customization**: Multiple color schemes and dark mode
- **Web & Mobile**: Runs on web browsers and mobile devices
- **PWA Ready**: Progressive Web App support for offline usage

## Quick Start

### Prerequisites

- Flutter SDK (latest stable version)
- Chrome browser (for web testing)

### Installation

1. **Install dependencies**:

```bash
flutter pub get
```

2. **Generate database code** (if needed):

```bash
dart run build_runner build --delete-conflicting-outputs
```

3. **Run on Chrome**:

```bash
flutter run -d chrome
```

4. **Build for web**:

```bash
flutter build web
```

## Demo Credentials

| Role   | Username | Password |
| ------ | -------- | -------- |
| Admin  | admin    | 123      |
| Owner  | owner1   | 123      |
| Tenant | tenant1  | 123      |
| Buyer  | buyer1   | 123      |

## Project Structure

```
lib/
├── core/                   # Core functionality
│   ├── database/          # Drift database and tables
│   ├── models/            # Data models and enums
│   ├── constants/         # App constants and routes
│   ├── theme/             # Theme configuration
│   └── widgets/           # Reusable widgets
├── features/              # Feature modules
│   ├── auth/             # Authentication
│   ├── admin/            # Admin features
│   ├── owner/            # Owner features
│   ├── tenant/           # Tenant features
│   ├── buyer/            # Buyer features
│   ├── settings/         # App settings
│   └── profile/          # User profile
├── router/               # Navigation
└── l10n/                 # Localization files
```

## Database Schema

The application uses Drift ORM with the following tables:

- **users**: User accounts with role-based access
- **properties**: Real estate listings
- **property_images**: Property photos
- **contracts**: Rental and sale agreements
- **payments**: Payment transactions
- **purchase_requests**: Buyer purchase requests
- **building_units**: Units within a building property
- **unit_descriptions**: Detailed descriptions for units
- **settings**: App configuration

See [Property and Unit Management](docs/property_and_unit_management.md) for details on the new building and unit features.

## API Integration

The app works fully offline with a local database. To enable API synchronization:

1. Go to Settings
2. Enter your API URL
3. Enable sync toggle
4. Use the refresh button on screens to fetch data

### API Endpoints

See `lib/core/constants/api_endpoints.dart` for the complete list of RESTful endpoints.

## Development

### Adding New Features

1. Create feature directory in `lib/features/`
2. Implement Bloc for state management
3. Create screens and widgets
4. Add routes in `lib/core/constants/routes.dart`
5. Update router in `lib/router/app_router.dart`

### Database Changes

1. Modify tables in `lib/core/database/tables.dart`
2. Update schema version in `lib/core/database/database.dart`
3. Run code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Localization

1. Add strings to `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb`
2. Rebuild the app to generate localization code

## Troubleshooting

### Build Runner Issues

```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Web Database Issues

The app uses IndexedDB for web storage. Clear browser data if you encounter database issues.

### Localization Not Working

Ensure `flutter pub get` has been run and the app has been restarted.

## License

This project is created for demonstration purposes.

## Support

For issues and questions, please refer to the implementation plan and walkthrough documents in the `.gemini/antigravity/brain/` directory.
