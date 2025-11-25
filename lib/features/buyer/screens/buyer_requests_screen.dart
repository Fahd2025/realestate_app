import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/widgets/main_layout.dart';
import '../../../features/auth/bloc/auth_bloc.dart';
import '../widgets/property_request_form_modal.dart';

class BuyerRequestsScreen extends StatefulWidget {
  const BuyerRequestsScreen({super.key});

  @override
  State<BuyerRequestsScreen> createState() => _BuyerRequestsScreenState();
}

class _BuyerRequestsScreenState extends State<BuyerRequestsScreen> {
  List<PropertyRequest> _requests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    setState(() => _isLoading = true);

    try {
      final database = context.read<AuthBloc>().database;
      final buyerId = context.read<AuthBloc>().currentUser!.id;

      final requests = await (database.select(database.propertyRequests)
            ..where((tbl) => tbl.buyerId.equals(buyerId)))
          .get();

      setState(() {
        _requests = requests;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleAddRequest() async {
    final l10n = AppLocalizations.of(context)!;
    final database = context.read<AuthBloc>().database;
    final buyerId = context.read<AuthBloc>().currentUser!.id;

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PropertyRequestFormModal(
        database: database,
        buyerId: buyerId,
      ),
    );

    if (result == true) {
      _loadRequests();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.requestSubmitted)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MainLayout(
      title: l10n.myRequests,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddRequest,
        icon: const Icon(Icons.add),
        label: Text(l10n.placeRequest),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _requests.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.request_quote_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noRequests,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to create your first request',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    final request = _requests[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          child:
                              Text(request.propertyCategory[0].toUpperCase()),
                        ),
                        title: Text(
                            '${request.propertyCategory} - ${request.location}'),
                        subtitle: Text('Status: ${request.status}'),
                        trailing: Chip(
                          label: Text(request.status),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
