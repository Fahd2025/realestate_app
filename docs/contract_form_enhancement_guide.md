# Contract Form Enhancement - Implementation Guide

## Requirements Summary

### 1. Remove Contract Type Field

- The contract type should be determined by which screen the user is on (Purchase or Lease)
- Remove the dropdown for contract type from the form

### 2. Add Owner Dropdown

- Replace the "Owner ID" text field with a dropdown
- Populate with users who have role = 'owner'
- Display: fullName (or fullNameAr for Arabic)

### 3. Add Property Dropdown (Filtered by Owner)

- Replace the "Property ID" text field with a dropdown
- Only show properties that belong to the selected owner
- Filter by appropriate status:
  - For Lease contracts: status = 'available' OR 'rented'
  - For Purchase contracts: status = 'available' OR 'for_sale'
- Display: title (or titleAr for Arabic)

### 4. Add Tenant/Buyer Dropdown

- Replace the "Tenant/Buyer ID" text field with a dropdown
- For Lease contracts: Show users with role = 'tenant'
- For Purchase contracts: Show users with role = 'buyer'
- Display: fullName (or fullNameAr for Arabic)

### 5. Rename Terminology

- "Rent" → "Lease"
- "Buy" → "Purchase"
- Update all occurrences in:
  - UI labels
  - Database values (contractType column)
  - Code variables and constants
  - Route names

## Implementation Steps

### Step 1: Update Database Values

Since we're changing 'rent' to 'lease' and 'buy' to 'purchase', we need a migration:

```sql
UPDATE contracts SET contractType = 'lease' WHERE contractType = 'rent';
UPDATE contracts SET contractType = 'purchase' WHERE contractType = 'buy';
```

### Step 2: Update ContractFormModal

**Add State Variables:**

```dart
List<User> _owners = [];
List<Property> _properties = [];
List<User> _tenants = [];
List<User> _buyers = [];

String? _selectedOwnerId;
String? _selectedPropertyId;
String? _selectedTenantBuyerId;

bool _isLoadingData = true;
```

**Add Data Loading Method:**

```dart
Future<void> _loadDropdownData() async {
  final database = context.read<AuthBloc>().database;

  // Load owners
  final owners = await (database.select(database.users)
        ..where((u) => u.role.equals('owner')))
      .get();

  // Load tenants
  final tenants = await (database.select(database.users)
        ..where((u) => u.role.equals('tenant')))
      .get();

  // Load buyers
  final buyers = await (database.select(database.users)
        ..where((u) => u.role.equals('buyer')))
      .get();

  setState(() {
    _owners = owners;
    _tenants = tenants;
    _buyers = buyers;
    _isLoadingData = false;
  });
}

Future<void> _loadPropertiesForOwner(String ownerId) async {
  final database = context.read<AuthBloc>().database;

  final query = database.select(database.properties)
    ..where((p) => p.ownerId.equals(ownerId));

  // Filter by status
  if (_contractType == 'lease') {
    query.where((p) => p.status.equals('available') | p.status.equals('rented'));
  } else {
    query.where((p) => p.status.equals('available') | p.status.equals('for_sale'));
  }

  final properties = await query.get();

  setState(() {
    _properties = properties;
  });
}
```

**Replace Text Fields with Dropdowns:**

```dart
// Owner Dropdown
DropdownButtonFormField<String>(
  value: _selectedOwnerId,
  items: _owners.map((owner) {
    return DropdownMenuItem(
      value: owner.id,
      child: Text(owner.fullName),
    );
  }).toList(),
  onChanged: (value) async {
    setState(() {
      _selectedOwnerId = value;
      _selectedPropertyId = null; // Reset property selection
    });
    if (value != null) {
      await _loadPropertiesForOwner(value);
    }
  },
  decoration: const InputDecoration(labelText: 'Owner'),
  validator: (value) => value == null ? 'Required' : null,
),

// Property Dropdown
DropdownButtonFormField<String>(
  value: _selectedPropertyId,
  items: _properties.map((property) {
    return DropdownMenuItem(
      value: property.id,
      child: Text(property.title),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      _selectedPropertyId = value;
    });
  },
  decoration: const InputDecoration(labelText: 'Property'),
  validator: (value) => value == null ? 'Required' : null,
),

// Tenant/Buyer Dropdown
DropdownButtonFormField<String>(
  value: _selectedTenantBuyerId,
  items: (_contractType == 'lease' ? _tenants : _buyers).map((user) {
    return DropdownMenuItem(
      value: user.id,
      child: Text(user.fullName),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      _selectedTenantBuyerId = value;
    });
  },
  decoration: InputDecoration(
    labelText: _contractType == 'lease' ? 'Tenant' : 'Buyer',
  ),
  validator: (value) => value == null ? 'Required' : null,
),
```

### Step 3: Update All References

**Files to Update:**

1. `contract_form_modal.dart` - Form UI
2. `contracts_view.dart` - Display labels
3. `buy_contracts_screen.dart` → `purchase_contracts_screen.dart` (rename file)
4. `rent_contracts_screen.dart` → `lease_contracts_screen.dart` (rename file)
5. `app_router.dart` - Route names and labels
6. `routes.dart` - Route constants
7. `dashboard_router.dart` - Navigation items
8. All BLoC files that reference contract types
9. Payment-related files that check contract type

**Search and Replace:**

- 'rent' → 'lease' (in contract type context)
- 'Rent' → 'Lease'
- 'buy' → 'purchase'
- 'Buy' → 'Purchase'
- 'Monthly Rent' → 'Monthly Lease'
- 'Sale Price' → 'Purchase Price'

## Testing Checklist

- [ ] Create a new lease contract with dropdowns
- [ ] Create a new purchase contract with dropdowns
- [ ] Edit existing contracts
- [ ] Verify property filtering works correctly
- [ ] Verify owner change resets property selection
- [ ] Verify correct tenant/buyer list based on contract type
- [ ] Check payment schedule generation still works
- [ ] Verify all UI labels are updated
- [ ] Test navigation between lease and purchase screens

## Notes

- This is a significant refactoring that touches many files
- Consider creating a database migration for existing data
- Test thoroughly before deploying
- The changes are backward-compatible if we keep supporting both old and new values temporarily
