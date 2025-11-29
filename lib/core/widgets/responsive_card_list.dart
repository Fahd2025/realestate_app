import 'package:flutter/material.dart';
import 'package:realestate_app/l10n/app_localizations.dart';

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
  final int? index;
  final bool showRowNumber;

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
    this.index,
    this.showRowNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showRowNumber && index != null) ...[
              CircleAvatar(
                radius: 14,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  '${index! + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            if (getLeading != null)
              getLeading!(data) ?? const SizedBox.shrink(),
          ],
        ),
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
                        label: Text(l10n.edit),
                      ),
                    if (onDelete != null)
                      TextButton.icon(
                        onPressed: () => onDelete!(data),
                        icon: const Icon(Icons.delete),
                        label: Text(l10n.delete),
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
  final bool showRowNumbers;

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
    this.showRowNumbers = true,
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
          index: index,
          showRowNumber: showRowNumbers,
        );
      },
    );
  }
}
