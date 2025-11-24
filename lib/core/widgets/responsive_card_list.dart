import 'package:flutter/material.dart';

/// Generic expansion tile card for mobile view
class ResponsiveExpansionCard<T> extends StatelessWidget {
  final T data;
  final String Function(T) getTitle;
  final String Function(T) getSubtitle;
  final Widget? Function(T)? getLeading;
  final List<CardField<T>> fields;
  final void Function(T)? onEdit;
  final void Function(T)? onDelete;
  final void Function(T)? onTap;

  const ResponsiveExpansionCard({
    super.key,
    required this.data,
    required this.getTitle,
    required this.getSubtitle,
    this.getLeading,
    required this.fields,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: getLeading?.call(data),
        title: Text(
          getTitle(data),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(getSubtitle(data)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...fields.map((field) => _buildField(context, field)),
                const SizedBox(height: 16),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onEdit != null)
                      TextButton.icon(
                        onPressed: () => onEdit!(data),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                      ),
                    if (onDelete != null)
                      TextButton.icon(
                        onPressed: () => onDelete!(data),
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context, CardField<T> field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              field.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: field.customWidget != null
                ? field.customWidget!(data)
                : Text(
                    field.getValue(data),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
        ],
      ),
    );
  }
}

/// Configuration for a field in the expansion card
class CardField<T> {
  final String label;
  final String Function(T) getValue;
  final Widget Function(T)? customWidget;

  const CardField({
    required this.label,
    required this.getValue,
    this.customWidget,
  });
}

/// Generic list view for mobile with expansion cards
class ResponsiveCardList<T> extends StatelessWidget {
  final List<T> data;
  final String Function(T) getTitle;
  final String Function(T) getSubtitle;
  final Widget? Function(T)? getLeading;
  final List<CardField<T>> fields;
  final void Function(T)? onEdit;
  final void Function(T)? onDelete;
  final void Function(T)? onTap;

  const ResponsiveCardList({
    super.key,
    required this.data,
    required this.getTitle,
    required this.getSubtitle,
    this.getLeading,
    required this.fields,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No data available',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ResponsiveExpansionCard<T>(
          data: data[index],
          getTitle: getTitle,
          getSubtitle: getSubtitle,
          getLeading: getLeading,
          fields: fields,
          onEdit: onEdit,
          onDelete: onDelete,
          onTap: onTap,
        );
      },
    );
  }
}
