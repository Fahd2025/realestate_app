# Property and Unit Management

This document describes the Property and Unit Management features added to the Real Estate Application.

## Overview

The application now supports a hierarchical structure for properties, specifically allowing the creation of **Buildings** which can contain multiple **Units** (Apartments, Offices, Shops, etc.). This feature enables detailed management of multi-unit properties.

## Features

### 1. Building Property Type

- **New Property Type**: Users can now select "Building" as a property type when creating or editing a property.
- **Purpose**: Represents a physical building that houses multiple individual units.

### 2. Unit Management

- **Hierarchical Structure**: Units are directly linked to a parent "Building" property.
- **Unit Types**: Supported unit types include:
  - Apartment
  - Floor
  - Office
  - Shop
- **Unit Details**:
  - **Unit Number**: Identifier for the unit (e.g., 101, A1).
  - **Floor Number**: The floor where the unit is located.
  - **Status**: Current status of the unit (Available, Rented, Sold).

### 3. Detailed Unit Descriptions

- **Multilingual Support**: Descriptions can be entered in both English and Arabic.
- **Specific Attributes**:
  - Number of Rooms
  - Number of Bathrooms
  - Number of Kitchens
  - Free-text description

## Database Schema

Two new tables have been added to the Drift database to support these features:

### `BuildingUnits` Table

| Column | Type | Description |
|Ref|---|---|
| `id` | Text (PK) | Unique identifier |
| `propertyId` | Text (FK) | Reference to the parent Property |
| `unitType` | Text | Type of unit (apartment, office, etc.) |
| `unitNumber` | Text | Unit identifier |
| `floorNumber` | Text | Floor number |
| `status` | Text | Availability status |

### `UnitDescriptions` Table

| Column          | Type      | Description                  |
| --------------- | --------- | ---------------------------- |
| `id`            | Text (PK) | Unique identifier            |
| `unitId`        | Text (FK) | Reference to the parent Unit |
| `rooms`         | Int       | Number of rooms              |
| `bathrooms`     | Int       | Number of bathrooms          |
| `kitchens`      | Int       | Number of kitchens           |
| `description`   | Text      | English description          |
| `descriptionAr` | Text      | Arabic description           |

## User Guide

### Adding a Building and Units

1.  **Create a Building**:

    - Navigate to the **Properties** tab.
    - Click **Add Property**.
    - Fill in the building details (Title, Address, etc.).
    - Select **Building** as the **Property Type**.
    - Save the property.

2.  **Manage Units**:

    - Locate the created Building in the property list.
    - Click **Edit** (or tap to view details then edit).
    - Scroll to the bottom of the form and click **Manage Units**.

3.  **Add a Unit**:

    - In the Unit Management screen, click the **Add (+)** button.
    - Select the **Unit Type** (e.g., Apartment).
    - Enter the **Unit Number** and **Floor Number**.
    - Enter the number of **Rooms**, **Bathrooms**, and **Kitchens**.
    - Provide a description in English and Arabic.
    - Click **Add**.

4.  **Edit/Delete Units**:
    - Use the menu (three dots) on a unit card to **Edit** or **Delete** it.
