# Payment Modal Bug Fix

## Date: 2025-11-24

## Issue Description

**Error:** `InvalidDataException` when trying to add a payment through the Payments/Installments modal.

**Error Message:**

```
Error: InvalidDataException: Sorry, PaymentsCompanion(id: Value(b4ed83d8-e46c-40ae-a286-2ae341299345),
contractId: Value.absent(), payerId: Value.absent(), amount: Value.absent(),
paymentDate: Value(2025-11-24 15:56:33.977), dueDate: Value.absent(),
paymentType: Value.absent(), paymentMethod: Value.absent(), status: Value(completed),
notes: Value.absent(), createdAt: Value.absent(), updatedAt: Value(2025-11-24 15:56:33.977),
syncStatus: Value.absent(), rowid: Value.absent()) cannot be used for that because
contractId: This value was required, but isn't present
payerId: This value was required, but isn't present
amount: This value was required, but isn't present
paymentType: This value was required, but isn't present
createdAt: This value was required, but isn't present
```

## Root Cause

The `PaymentsCompanion` in the `_AddPaymentDialog` widget was missing two required fields:

1. `paymentMethod` - nullable field that needs to be explicitly set to null
2. `syncStatus` - required field with default value 'synced'

## Fix Applied

### File: `lib/features/payments/widgets/contract_payments_modal.dart`

**Changes Made:**

1. **Added Missing Fields to PaymentsCompanion:**

   ```dart
   final payment = PaymentsCompanion(
     id: drift.Value(const Uuid().v4()),
     contractId: drift.Value(widget.contractId),
     payerId: drift.Value(widget.payerId),
     amount: drift.Value(double.parse(_amountController.text)),
     paymentDate: drift.Value(DateTime.now()),
     dueDate: drift.Value(_dueDate),
     paymentType: drift.Value(_paymentType),
     paymentMethod: const drift.Value(null),  // ✅ ADDED
     status: drift.Value(_status),
     notes: drift.Value(_notesController.text),
     createdAt: drift.Value(DateTime.now()),
     updatedAt: drift.Value(DateTime.now()),
     syncStatus: const drift.Value('synced'),  // ✅ ADDED
   );
   ```

2. **Updated Terminology:**
   - Changed default payment type from `'rent'` to `'lease'`
   - Updated dropdown label from "Rent" to "Lease"
   - This aligns with the terminology changes made throughout the application

## Testing

After the fix, users should be able to:

- ✅ Open the Payments/Installments modal for a contract
- ✅ Click the "+" button to add a new payment
- ✅ Fill in the payment form
- ✅ Successfully submit the payment without errors
- ✅ See the payment appear in the list

## Related Changes

This fix is part of the larger refactoring where:

- "Rent" → "Lease"
- "Buy" → "Purchase"

The payment type dropdown now correctly uses "Lease" instead of "Rent" to maintain consistency.

## Impact

- **Severity:** High (blocking feature)
- **Scope:** Payment creation functionality
- **Users Affected:** All users trying to add manual payments

## Verification Steps

1. Navigate to Purchase Contracts or Lease Contracts
2. Click on a contract to view details
3. Click the payments icon to open the Payments/Installments modal
4. Click the "+" button to add a payment
5. Fill in the form and submit
6. Verify the payment is created successfully without errors

## Notes

- The `paymentMethod` field is nullable and set to `null` by default
- The `syncStatus` field is set to `'synced'` for new payments
- All Drift Companion objects must include all non-nullable fields, even if they have default values in the table definition
