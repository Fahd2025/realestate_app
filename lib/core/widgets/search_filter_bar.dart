import 'package:flutter/material.dart';

/// Generic search and filter bar
class SearchFilterBar extends StatelessWidget {
  final String searchHint;
  final ValueChanged<String> onSearchChanged;
  final List<FilterChip>? filterChips;
  final VoidCallback? onFilterTap;

  const SearchFilterBar({
    super.key,
    this.searchHint = 'Search...',
    required this.onSearchChanged,
    this.filterChips,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: searchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: onSearchChanged,
            ),
            if (filterChips != null && filterChips!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filterChips!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Filter chip data
class FilterChipData {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const FilterChipData({
    required this.label,
    required this.selected,
    required this.onSelected,
  });
}
