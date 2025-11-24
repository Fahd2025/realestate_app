import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';

typedef RowBuilder<T> = DataRow Function(T item, int index);

class GenericTable<T> extends StatefulWidget {
  final List<T> items;
  final List<DataColumn> columns;
  final RowBuilder<T> rowBuilder;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final String? emptyMessage;
  final bool sortAscending;
  final int? sortColumnIndex;
  final Function(int columnIndex, bool ascending)? onSort;

  const GenericTable({
    super.key,
    required this.items,
    required this.columns,
    required this.rowBuilder,
    this.isLoading = false,
    this.onRefresh,
    this.emptyMessage,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.onSort,
  });

  @override
  State<GenericTable<T>> createState() => _GenericTableState<T>();
}

class _GenericTableState<T> extends State<GenericTable<T>> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (widget.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (widget.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              widget.emptyMessage ?? l10n.noData,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            if (widget.onRefresh != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: widget.onRefresh,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.refresh),
              ),
            ],
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header with refresh button
          if (widget.onRefresh != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: widget.onRefresh,
                    tooltip: l10n.refresh,
                  ),
                ],
              ),
            ),
          
          // Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortAscending: widget.sortAscending,
                  sortColumnIndex: widget.sortColumnIndex,
                  columns: widget.columns,
                  rows: List.generate(
                    widget.items.length,
                    (index) => widget.rowBuilder(widget.items[index], index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
