import 'package:flutter/material.dart';

/// Generic data table column configuration
class DataTableColumnConfig<T> {
  final String label;
  final String Function(T) getValue;
  final bool sortable;
  final bool numeric;
  final Widget Function(T)? customCell;

  const DataTableColumnConfig({
    required this.label,
    required this.getValue,
    this.sortable = true,
    this.numeric = false,
    this.customCell,
  });
}

/// Generic responsive data table widget
class ResponsiveDataTable<T> extends StatefulWidget {
  final List<T> data;
  final List<DataTableColumnConfig<T>> columns;
  final void Function(T)? onEdit;
  final void Function(T)? onDelete;
  final void Function(T)? onTap;
  final int rowsPerPage;
  final bool showActions;
  final bool showRowNumbers;

  const ResponsiveDataTable({
    super.key,
    required this.data,
    required this.columns,
    this.onEdit,
    this.onDelete,
    this.onTap,
    this.rowsPerPage = 10,
    this.showActions = true,
    this.showRowNumbers = true,
  });

  @override
  State<ResponsiveDataTable<T>> createState() => _ResponsiveDataTableState<T>();
}

class _ResponsiveDataTableState<T> extends State<ResponsiveDataTable<T>> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  int _currentPage = 0;
  List<T> _sortedData = [];

  @override
  void initState() {
    super.initState();
    _sortedData = List.from(widget.data);
  }

  @override
  void didUpdateWidget(ResponsiveDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _sortedData = List.from(widget.data);
      _sortData();
    }
  }

  void _sortData() {
    if (_sortColumnIndex >= widget.columns.length) return;

    final column = widget.columns[_sortColumnIndex];
    _sortedData.sort((a, b) {
      final aValue = column.getValue(a);
      final bValue = column.getValue(b);

      final comparison = aValue.compareTo(bValue);
      return _sortAscending ? comparison : -comparison;
    });
  }

  void _onSort(int columnIndex) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnIndex = columnIndex;
        _sortAscending = true;
      }
      _sortData();
    });
  }

  List<T> _getPaginatedData() {
    final startIndex = _currentPage * widget.rowsPerPage;
    final endIndex =
        (startIndex + widget.rowsPerPage).clamp(0, _sortedData.length);
    return _sortedData.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final paginatedData = _getPaginatedData();
    final totalPages = (_sortedData.length / widget.rowsPerPage).ceil();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: [
                  if (widget.showRowNumbers)
                    const DataColumn(
                      label: Text(
                        '#',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      numeric: true,
                    ),
                  ...widget.columns.asMap().entries.map((entry) {
                    final index = entry.key;
                    final column = entry.value;
                    return DataColumn(
                      label: Text(
                        column.label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onSort:
                          column.sortable ? (_, __) => _onSort(index) : null,
                      numeric: column.numeric,
                    );
                  }),
                  if (widget.showActions)
                    const DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
                rows: paginatedData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final rowNumber =
                      (_currentPage * widget.rowsPerPage) + index + 1;

                  return DataRow(
                    onSelectChanged: widget.onTap != null
                        ? (_) => widget.onTap!(item)
                        : null,
                    cells: [
                      if (widget.showRowNumbers)
                        DataCell(
                          Text(
                            rowNumber.toString(),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ...widget.columns.map((column) {
                        if (column.customCell != null) {
                          return DataCell(column.customCell!(item));
                        }
                        return DataCell(Text(column.getValue(item)));
                      }),
                      if (widget.showActions)
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.onEdit != null)
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 20),
                                  onPressed: () => widget.onEdit!(item),
                                  tooltip: 'Edit',
                                ),
                              if (widget.onDelete != null)
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 20),
                                  onPressed: () => widget.onDelete!(item),
                                  tooltip: 'Delete',
                                  color: Theme.of(context).colorScheme.error,
                                ),
                            ],
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        // Pagination controls
        if (totalPages > 1)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _currentPage > 0
                      ? () => setState(() => _currentPage--)
                      : null,
                ),
                Text(
                  'Page ${_currentPage + 1} of $totalPages',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _currentPage < totalPages - 1
                      ? () => setState(() => _currentPage++)
                      : null,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
