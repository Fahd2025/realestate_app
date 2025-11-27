import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../bloc/basic_data_cubit.dart';
import '../widgets/basic_data_crud_view.dart';
import '../../../../core/database/database.dart';
import '../../../../core/widgets/main_layout.dart';

class BasicDataManagementScreen extends StatelessWidget {
  const BasicDataManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final items = [
      _DataItem(
        title: l10n.nationalities,
        icon: Icons.flag,
        color: Colors.blue,
        type: BasicDataType.nationality,
      ),
      _DataItem(
        title: l10n.roomTypes,
        icon: Icons.meeting_room,
        color: Colors.purple,
        type: BasicDataType.roomType,
      ),
      _DataItem(
        title: l10n.unitDescriptions,
        icon: Icons.description,
        color: Colors.teal,
        type: BasicDataType.unitDescriptionType,
      ),
      _DataItem(
        title: l10n.propertyTypes,
        icon: Icons.home_work,
        color: Colors.orange,
        type: BasicDataType.propertyType,
      ),
      _DataItem(
        title: l10n.regions,
        icon: Icons.public,
        color: Colors.green,
        type: BasicDataType.region,
      ),
      _DataItem(
        title: l10n.provinces,
        icon: Icons.map,
        color: Colors.indigo,
        type: BasicDataType.province,
      ),
      _DataItem(
        title: l10n.cities,
        icon: Icons.location_city,
        color: Colors.cyan,
        type: BasicDataType.city,
      ),
      _DataItem(
        title: l10n.services,
        icon: Icons.room_service,
        color: Colors.pink,
        type: BasicDataType.service,
      ),
      _DataItem(
        title: l10n.currencies,
        icon: Icons.attach_money,
        color: Colors.amber,
        type: BasicDataType.currency,
      ),
    ];

    return MainLayout(
      title: l10n.basicDataManagement,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 1200
                ? 4
                : constraints.maxWidth > 800
                    ? 3
                    : constraints.maxWidth > 500
                        ? 2
                        : 1;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.3,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildCard(context, items[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, _DataItem item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BasicDataListScreen(
                title: item.title,
                type: item.type,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.color.withValues(alpha: 0.1),
                item.color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    size: 40,
                    color: item.color,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: item.color.withValues(alpha: 0.9),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DataItem {
  final String title;
  final IconData icon;
  final Color color;
  final BasicDataType type;

  _DataItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.type,
  });
}

class BasicDataListScreen extends StatefulWidget {
  final String title;
  final BasicDataType type;

  const BasicDataListScreen(
      {super.key, required this.title, required this.type});

  @override
  State<BasicDataListScreen> createState() => _BasicDataListScreenState();
}

class _BasicDataListScreenState extends State<BasicDataListScreen> {
  String? _parentId; // For hierarchical data
  Map<String, Region> _regionsMap = {};
  Map<String, Province> _provincesMap = {};

  // Filter state
  String? _selectedRegionFilter;
  String? _selectedProvinceFilter;

  @override
  void initState() {
    super.initState();
    context.read<BasicDataCubit>().loadData(widget.type);
    _loadReferenceData();
  }

  Future<void> _loadReferenceData() async {
    if (widget.type == BasicDataType.city ||
        widget.type == BasicDataType.province) {
      final repository = context.read<BasicDataCubit>().repository;
      final regions = await repository.getRegions();
      if (mounted) {
        setState(() {
          _regionsMap = {for (var r in regions) r.id: r};
        });
      }

      if (widget.type == BasicDataType.city) {
        final provinces = await repository.getProvinces();
        if (mounted) {
          setState(() {
            _provincesMap = {for (var p in provinces) p.id: p};
          });
        }
      }
    }
  }

  List<dynamic> _getFilteredItems(List<dynamic> items) {
    if (widget.type == BasicDataType.city) {
      return items.where((item) {
        if (item is! City) return true;

        if (_selectedProvinceFilter != null &&
            item.provinceId != _selectedProvinceFilter) {
          return false;
        }

        if (_selectedRegionFilter != null) {
          final province = _provincesMap[item.provinceId];
          if (province == null || province.regionId != _selectedRegionFilter) {
            return false;
          }
        }

        return true;
      }).toList();
    } else if (widget.type == BasicDataType.province) {
      return items.where((item) {
        if (item is! Province) return true;

        if (_selectedRegionFilter != null &&
            item.regionId != _selectedRegionFilter) {
          return false;
        }

        return true;
      }).toList();
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasicDataCubit, BasicDataState>(
      builder: (context, state) {
        if (state is BasicDataLoading) {
          return MainLayout(
            title: widget.title,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddEditDialog(context),
                tooltip: 'Add New',
              ),
            ],
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is BasicDataError) {
          return MainLayout(
            title: widget.title,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddEditDialog(context),
                tooltip: 'Add New',
              ),
            ],
            body: Center(child: Text('Error: ${state.message}')),
          );
        } else if (state is BasicDataLoaded) {
          final filteredItems = _getFilteredItems(state.items);

          return MainLayout(
            title: widget.title,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddEditDialog(context),
                tooltip: 'Add New',
              ),
            ],
            body: Column(
              children: [
                if (widget.type == BasicDataType.province ||
                    widget.type == BasicDataType.city)
                  _buildParentSelector(context),
                Expanded(
                  child: BasicDataCrudView(
                    title: widget.title,
                    items: filteredItems,
                    getName: (item) => _getName(item),
                    getSubtitle: widget.type == BasicDataType.city
                        ? null
                        : (item) => _getSubtitle(item),
                    getAdditionalColumns: widget.type == BasicDataType.city
                        ? _getAdditionalColumns
                        : null,
                    getAdditionalCells: widget.type == BasicDataType.city
                        ? (item) => _getAdditionalCells(item)
                        : null,
                    filters: _buildFilters(),
                    onAdd: () => _showAddEditDialog(context),
                    onEdit: (item) => _showAddEditDialog(context, item: item),
                    onDelete: (item) => _deleteItem(context, item),
                  ),
                ),
              ],
            ),
          );
        }
        return MainLayout(
          title: widget.title,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddEditDialog(context),
              tooltip: AppLocalizations.of(context)!.addNew,
            ),
          ],
          body: const Center(child: Text('No data')),
        );
      },
    );
  }

  Widget? _buildFilters() {
    final l10n = AppLocalizations.of(context)!;
    if (widget.type == BasicDataType.city) {
      final locale = Localizations.localeOf(context);
      final isArabic = locale.languageCode == 'ar';

      return Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String?>(
              value: _selectedRegionFilter,
              decoration: InputDecoration(
                labelText: l10n.filterByRegion,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(l10n.allRegions),
                ),
                ..._regionsMap.values.map((r) {
                  final name = isArabic ? (r.nameAr ?? r.name) : r.name;
                  return DropdownMenuItem<String?>(
                    value: r.id,
                    child: Text(name),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRegionFilter = value;
                  _selectedProvinceFilter = null;
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String?>(
              value: _selectedProvinceFilter,
              decoration: InputDecoration(
                labelText: l10n.filterByProvince,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(l10n.allProvinces),
                ),
                ..._provincesMap.values
                    .where((p) =>
                        _selectedRegionFilter == null ||
                        p.regionId == _selectedRegionFilter)
                    .map((p) {
                  final name = isArabic ? (p.nameAr ?? p.name) : p.name;
                  return DropdownMenuItem<String?>(
                    value: p.id,
                    child: Text(name),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedProvinceFilter = value;
                });
              },
            ),
          ),
        ],
      );
    } else if (widget.type == BasicDataType.province) {
      final locale = Localizations.localeOf(context);
      final isArabic = locale.languageCode == 'ar';

      return DropdownButtonFormField<String?>(
        value: _selectedRegionFilter,
        decoration: InputDecoration(
          labelText: l10n.filterByRegion,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
        items: [
          DropdownMenuItem<String?>(
            value: null,
            child: Text(l10n.allRegions),
          ),
          ..._regionsMap.values.map((r) {
            final name = isArabic ? (r.nameAr ?? r.name) : r.name;
            return DropdownMenuItem<String?>(
              value: r.id,
              child: Text(name),
            );
          }).toList(),
        ],
        onChanged: (value) {
          setState(() {
            _selectedRegionFilter = value;
          });
        },
      );
    }

    return null;
  }

  List<DataColumn> _getAdditionalColumns() {
    final l10n = AppLocalizations.of(context)!;
    return [
      DataColumn(
        label: Text(l10n.region,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      DataColumn(
        label: Text(l10n.province,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ];
  }

  List<DataCell> _getAdditionalCells(dynamic item) {
    if (item is! City) {
      return [
        const DataCell(Text('')),
        const DataCell(Text('')),
      ];
    }

    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final province = _provincesMap[item.provinceId];
    final region = province != null ? _regionsMap[province.regionId] : null;

    final regionName = region != null
        ? (isArabic ? (region.nameAr ?? region.name) : region.name)
        : '-';
    final provinceName = province != null
        ? (isArabic ? (province.nameAr ?? province.name) : province.name)
        : '-';

    return [
      DataCell(Text(regionName)),
      DataCell(Text(provinceName)),
    ];
  }

  Widget _buildParentSelector(BuildContext context) {
    // This is tricky because we need to load parents.
    // Ideally, we should have a separate Cubit or load parents in the same Cubit.
    // For simplicity, let's assume we select parent first or show all?
    // Showing all might be too much.
    // Let's just show a message "Select Parent" if _parentId is null?
    // Or better, for Provinces, show Regions dropdown.
    // For Cities, show Provinces dropdown.
    // This requires fetching regions/provinces.
    // I'll skip this complexity for now and assume flat list or handle it simply.
    // Actually, the requirement says "Provinces within the region, Cities within the province".
    // So we MUST handle hierarchy.
    // I'll add a simple dropdown that loads parents.
    return Container(); // Placeholder for now
  }

  String _getName(dynamic item) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    if (item is Nationality) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is RoomType) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is UnitDescriptionType) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is PropertyType) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is Region) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is Province) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is City) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is Service) {
      return isArabic ? (item.nameAr ?? item.name) : item.name;
    }
    if (item is Currency) return item.code;
    return '';
  }

  String _getSubtitle(dynamic item) {
    // Only show subtitle for items that have additional details beyond name
    if (item is Service) {
      return 'Price: ${item.price ?? 0}';
    }
    if (item is Currency) {
      return '${item.symbol ?? ''} - Rate: ${item.exchangeRate}';
    }
    if (item is City) {
      final province = _provincesMap[item.provinceId];
      final region = province != null ? _regionsMap[province.regionId] : null;
      final locale = Localizations.localeOf(context);
      final isArabic = locale.languageCode == 'ar';

      final provinceName = province != null
          ? (isArabic ? (province.nameAr ?? province.name) : province.name)
          : '';
      final regionName = region != null
          ? (isArabic ? (region.nameAr ?? region.name) : region.name)
          : '';

      if (regionName.isNotEmpty && provinceName.isNotEmpty) {
        return '$regionName - $provinceName';
      } else if (provinceName.isNotEmpty) {
        return provinceName;
      }
    }
    if (item is Province) {
      final region = _regionsMap[item.regionId];
      final locale = Localizations.localeOf(context);
      final isArabic = locale.languageCode == 'ar';
      if (region != null) {
        return isArabic ? (region.nameAr ?? region.name) : region.name;
      }
    }
    // For simple name-only items (Nationality, RoomType, etc.), return empty string
    return '';
  }

  void _showAddEditDialog(BuildContext context, {dynamic item}) async {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = item != null;
    final nameController =
        TextEditingController(text: isEdit ? (item as dynamic).name : '');
    final nameArController =
        TextEditingController(text: isEdit ? (item as dynamic).nameAr : '');

    // Extra fields
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final descriptionArController = TextEditingController();
    final codeController = TextEditingController();
    final symbolController = TextEditingController();
    final exchangeRateController = TextEditingController();

    String? selectedRegionId;
    String? selectedProvinceId;

    List<Region> regions = [];
    List<Province> provinces = [];

    final repository = context.read<BasicDataCubit>().repository;

    if (widget.type == BasicDataType.province) {
      regions = await repository.getRegions();
      if (isEdit && item is Province) {
        selectedRegionId = item.regionId;
      }
    } else if (widget.type == BasicDataType.city) {
      regions = await repository.getRegions();
      provinces = await repository.getProvinces();

      if (isEdit && item is City) {
        selectedProvinceId = item.provinceId;
        try {
          final p = provinces.firstWhere((p) => p.id == item.provinceId);
          selectedRegionId = p.regionId;
        } catch (_) {}
      }
    }

    if (isEdit) {
      if (item is Service) {
        priceController.text = item.price?.toString() ?? '';
        descriptionController.text = item.description ?? '';
        descriptionArController.text = item.descriptionAr ?? '';
      }
      if (item is Currency) {
        codeController.text = item.code;
        symbolController.text = item.symbol ?? '';
        exchangeRateController.text = item.exchangeRate.toString();
        // Currency uses code as name in _getName, so reset nameController
        nameController.text = item.name;
      }
    }

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEdit
                          ? '${l10n.edit} ${widget.title}'
                          : '${l10n.add} ${widget.title}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Form Fields

                // Region Dropdown (for Province and City)
                if (widget.type == BasicDataType.province ||
                    widget.type == BasicDataType.city) ...[
                  DropdownButtonFormField<String>(
                    value: selectedRegionId,
                    decoration: InputDecoration(
                      labelText: '${l10n.region} *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    items: regions.map((r) {
                      final locale = Localizations.localeOf(context);
                      final isArabic = locale.languageCode == 'ar';
                      final name = isArabic ? (r.nameAr ?? r.name) : r.name;
                      return DropdownMenuItem<String>(
                        value: r.id,
                        child: Text(name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRegionId = value;
                        if (widget.type == BasicDataType.city) {
                          selectedProvinceId = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                ],

                // Province Dropdown (for City only)
                if (widget.type == BasicDataType.city) ...[
                  DropdownButtonFormField<String>(
                    value: selectedProvinceId,
                    decoration: InputDecoration(
                      labelText: '${l10n.province} *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    items: provinces
                        .where((p) =>
                            selectedRegionId == null ||
                            p.regionId == selectedRegionId)
                        .map((p) {
                      final locale = Localizations.localeOf(context);
                      final isArabic = locale.languageCode == 'ar';
                      final name = isArabic ? (p.nameAr ?? p.name) : p.name;
                      return DropdownMenuItem<String>(
                        value: p.id,
                        child: Text(name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProvinceId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                ],

                if (widget.type == BasicDataType.currency)
                  TextField(
                    controller: codeController,
                    decoration: InputDecoration(
                      labelText: l10n.codeExample,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                if (widget.type == BasicDataType.currency)
                  const SizedBox(height: 12),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: '${l10n.nameEnglish} *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameArController,
                  decoration: InputDecoration(
                    labelText: l10n.nameArabic,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                if (widget.type == BasicDataType.service) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionArController,
                    decoration: InputDecoration(
                      labelText: 'Description (Arabic)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    maxLines: 3,
                  ),
                ],
                if (widget.type == BasicDataType.currency) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: symbolController,
                    decoration: InputDecoration(
                      labelText: 'Symbol',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: exchangeRateController,
                    decoration: InputDecoration(
                      labelText: 'Exchange Rate',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
                const SizedBox(height: 24),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate parent selection for hierarchical data
                          if (widget.type == BasicDataType.province &&
                              selectedRegionId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please select a Region')),
                            );
                            return;
                          }
                          if (widget.type == BasicDataType.city &&
                              selectedProvinceId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please select a Province')),
                            );
                            return;
                          }

                          final Map<String, dynamic> data = {
                            'name': nameController.text,
                            'nameAr': nameArController.text,
                          };

                          if (widget.type == BasicDataType.service) {
                            data['price'] =
                                double.tryParse(priceController.text);
                            data['description'] = descriptionController.text;
                            data['descriptionAr'] =
                                descriptionArController.text;
                          }
                          if (widget.type == BasicDataType.currency) {
                            data['code'] = codeController.text;
                            data['symbol'] = symbolController.text;
                            data['exchangeRate'] =
                                double.tryParse(exchangeRateController.text) ??
                                    1.0;
                          }

                          // Handle parent IDs
                          if (widget.type == BasicDataType.province &&
                              selectedRegionId != null) {
                            data['regionId'] = selectedRegionId;
                          }
                          if (widget.type == BasicDataType.city &&
                              selectedProvinceId != null) {
                            data['provinceId'] = selectedProvinceId;
                          }

                          if (isEdit) {
                            context.read<BasicDataCubit>().updateItem(
                                widget.type, (item as dynamic).id, data);
                          } else {
                            context
                                .read<BasicDataCubit>()
                                .addItem(widget.type, data);
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.save),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteItem(BuildContext context, dynamic item) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmDeleteTitle),
        content: Text(l10n.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<BasicDataCubit>()
                  .deleteItem(widget.type, item.id, parentId: _parentId);
              Navigator.pop(context);
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
