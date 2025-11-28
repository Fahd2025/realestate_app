import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';

class BasicDataCrudView<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T) getName;
  final String Function(T)? getSubtitle;
  final Widget? filters;
  final VoidCallback onAdd;
  final Function(T) onEdit;
  final Function(T) onDelete;
  final List<DataColumn> Function()? getAdditionalColumns;
  final List<DataCell> Function(T)? getAdditionalCells;

  const BasicDataCrudView({
    super.key,
    required this.title,
    required this.items,
    required this.getName,
    this.getSubtitle,
    this.filters,
    this.getAdditionalColumns,
    this.getAdditionalCells,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<BasicDataCrudView<T>> createState() => _BasicDataCrudViewState<T>();
}

class _BasicDataCrudViewState<T> extends State<BasicDataCrudView<T>> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<T> get _filteredItems {
    if (_searchQuery.isEmpty) return widget.items;
    return widget.items.where((item) {
      final name = widget.getName(item).toLowerCase();
      final subtitle = widget.getSubtitle != null
          ? widget.getSubtitle!(item).toLowerCase()
          : '';
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || subtitle.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width >= 900;

    return Column(
      children: [
        // Filters
        if (widget.filters != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: widget.filters!,
          ),
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchPlaceholder,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        // Content
        Expanded(
          child: _filteredItems.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noItemsFound))
              : isLargeScreen
                  ? _buildDataTable()
                  : _buildCardList(),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.3),
            ),
            columnSpacing: 56,
            horizontalMargin: 24,
            columns: [
              const DataColumn(
                label: Text('#', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text(AppLocalizations.of(context)!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              if (widget.getAdditionalColumns != null)
                ...widget.getAdditionalColumns!(),
              if (widget.getSubtitle != null &&
                  widget.getAdditionalColumns == null)
                DataColumn(
                  label: Text(AppLocalizations.of(context)!.details,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              DataColumn(
                label: Text(AppLocalizations.of(context)!.actions,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
            rows: _filteredItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return DataRow(
                cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(widget.getName(item))),
                  if (widget.getAdditionalCells != null)
                    ...widget.getAdditionalCells!(item),
                  if (widget.getSubtitle != null &&
                      widget.getAdditionalCells == null)
                    DataCell(Text(widget.getSubtitle!(item))),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          color: Colors.blue,
                          tooltip: AppLocalizations.of(context)!.edit,
                          onPressed: () => widget.onEdit(item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          color: Colors.red,
                          tooltip: AppLocalizations.of(context)!.delete,
                          onPressed: () => widget.onDelete(item),
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
    );
  }

  Widget _buildCardList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        final hasSubtitle = widget.getSubtitle != null;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: hasSubtitle
              ? ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    widget.getName(item),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.getSubtitle!(item),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                icon: const Icon(Icons.edit, size: 20),
                                label: Text(AppLocalizations.of(context)!.edit),
                                onPressed: () => widget.onEdit(item),
                              ),
                              const SizedBox(width: 8),
                              TextButton.icon(
                                icon: const Icon(Icons.delete, size: 20),
                                label:
                                    Text(AppLocalizations.of(context)!.delete),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () => widget.onDelete(item),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    widget.getName(item),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        color: Colors.blue,
                        tooltip: AppLocalizations.of(context)!.edit,
                        onPressed: () => widget.onEdit(item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        color: Colors.red,
                        tooltip: AppLocalizations.of(context)!.delete,
                        onPressed: () => widget.onDelete(item),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
