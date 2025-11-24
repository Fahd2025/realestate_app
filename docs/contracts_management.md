# Contracts Management Feature

## Overview

The Contracts Management feature allows Admins and Owners to manage Buy and Rent contracts. It includes functionality for creating, reading, updating, and deleting contracts, as well as managing payments/installments and exporting contracts to PDF.

## Architecture

The feature follows the Clean Architecture principles used in the app:

- **Data Layer**: `ContractsRepository` and `PaymentsRepository` handle database operations using Drift.
- **Business Logic Layer**: `ContractsBloc` and `PaymentsBloc` manage state and events.
- **UI Layer**: `ContractsView` (generic), `BuyContractsScreen`, `RentContractsScreen`, `ContractFormModal`, `ContractPaymentsModal`.

## Features

### 1. Contract Management

- **Buy Contracts**: Dedicated page for sales contracts.
- **Rent Contracts**: Dedicated page for rental contracts.
- **CRUD**: Full Create, Read, Update, Delete capabilities.
- **Responsive Design**:
  - Desktop: DataTable with sorting (sorting logic to be enhanced).
  - Mobile: ExpansionTile cards.
- **Search**: Filter contracts by search query (ID, terms, description).

### 2. Payment Management

- Manage installments and payments for each contract.
- Track payment status (Pending, Completed, Overdue).
- Add multiple payments/installments.

### 3. PDF Export

- Generate professional PDF contracts.
- Includes contract details, terms, and signature placeholders.
- Uses `pdf` and `printing` packages.

## Usage

### Navigation

- Access "Buy Contracts" and "Rent Contracts" from the side menu (Desktop) or drawer (Mobile).

### Adding a Contract

1. Click the "+" button in the app bar.
2. Fill in the contract details (Property, Owner, Tenant/Buyer, Dates, Financials).
3. Click "Create".

### Managing Payments

1. In the contracts list, click the "Payments" button (or "Payments" action in mobile card).
2. View existing payments.
3. Click "+" to add a new payment/installment.

### Exporting PDF

1. Click the PDF icon in the contract row or card.
2. The PDF will be generated and opened for printing or sharing.

# Contracts Management Feature

## Overview

The Contracts Management feature allows Admins and Owners to manage Buy and Rent contracts. It includes functionality for creating, reading, updating, and deleting contracts, as well as managing payments/installments and exporting contracts to PDF.

## Architecture

The feature follows the Clean Architecture principles used in the app:

- **Data Layer**: `ContractsRepository` and `PaymentsRepository` handle database operations using Drift.
- **Business Logic Layer**: `ContractsBloc` and `PaymentsBloc` manage state and events.
- **UI Layer**: `ContractsView` (generic), `BuyContractsScreen`, `RentContractsScreen`, `ContractFormModal`, `ContractPaymentsModal`.

## Features

### 1. Contract Management

- **Buy Contracts**: Dedicated page for sales contracts.
- **Rent Contracts**: Dedicated page for rental contracts.
- **CRUD**: Full Create, Read, Update, Delete capabilities.
- **Responsive Design**:
  - Desktop: DataTable with sorting (sorting logic to be enhanced).
  - Mobile: ExpansionTile cards.
- **Search**: Filter contracts by search query (ID, terms, description).

### 2. Payment Management

- Manage installments and payments for each contract.
- Track payment status (Pending, Completed, Overdue).
- Add multiple payments/installments.

### 3. PDF Export

- Generate professional PDF contracts.
- Includes contract details, terms, and signature placeholders.
- Uses `pdf` and `printing` packages.

## Usage

### Navigation

- Access "Buy Contracts" and "Rent Contracts" from the side menu (Desktop) or drawer (Mobile).

### Adding a Contract

1. Click the "+" button in the app bar.
2. Fill in the contract details (Property, Owner, Tenant/Buyer, Dates, Financials).
3. Click "Create".

### Managing Payments

1. In the contracts list, click the "Payments" button (or "Payments" action in mobile card).
2. View existing payments.
3. Click "+" to add a new payment/installment.

### Exporting PDF

1. Click the PDF icon in the contract row or card.
2. The PDF will be generated and opened for printing or sharing.

## Database Schema

- **Contracts Table**: Stores contract details including `description`, `concessions`, `fileUrl`.
- **Payments Table**: Stores payment records linked to contracts.

## Future Improvements

- **File Upload**: Implement file picker and local storage organization for contract documents.
- **Advanced Filtering**: Add date range and status filters.
- **Notifications**: Notify users of upcoming due dates.
- **UI Enhancements**: Display Property Title and User Names instead of IDs in the contracts list (requires table joins).
