import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../../core/language/language_cubit.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/widgets/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../company_info/screens/company_info_screen.dart';
import '../../../core/database/database.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _apiUrlController = TextEditingController();
  bool _syncEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiUrlController.text = prefs.getString('api_url') ?? '';
      _syncEnabled = prefs.getBool('sync_enabled') ?? false;
    });
  }

  Future<void> _saveApiUrl() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_url', _apiUrlController.text);
    ApiEndpoints.updateBaseUrl(_apiUrlController.text);

    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.apiUrlSaved)),
      );
    }
  }

  Future<void> _toggleSync(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sync_enabled', value);
    setState(() {
      _syncEnabled = value;
    });
  }

  Future<void> _clearData() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearAllDataTitle),
        content: Text(l10n.clearAllDataMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.clearData),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await context.read<AppDatabase>().clearData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.allDataCleared)),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.errorClearingData(e.toString()),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _apiUrlController.dispose();
    super.dispose();
  }

  String _getLocalizedColorScheme(String scheme, AppLocalizations l10n) {
    switch (scheme) {
      case 'blue':
        return l10n.blue;
      case 'green':
        return l10n.green;
      case 'purple':
        return l10n.purple;
      default:
        return scheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeCubit = context.watch<ThemeCubit>();
    final languageCubit = context.watch<LanguageCubit>();

    return MainLayout(
      title: l10n.settings,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme section
          Text(
            l10n.theme,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.darkMode),
                  subtitle:
                      Text(themeCubit.state.isDarkMode ? l10n.on : l10n.off),
                  value: themeCubit.state.isDarkMode,
                  onChanged: (value) {
                    themeCubit.toggleTheme();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(l10n.colorScheme),
                  subtitle: Text(_getLocalizedColorScheme(
                      themeCubit.state.colorScheme, l10n)),
                  trailing: DropdownButton<String>(
                    value: themeCubit.state.colorScheme,
                    items: ['blue', 'green', 'purple']
                        .map((scheme) => DropdownMenuItem(
                              value: scheme,
                              child:
                                  Text(_getLocalizedColorScheme(scheme, l10n)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        themeCubit.setColorScheme(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Language section
          Text(
            l10n.language,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: Text(l10n.languageLabel),
              subtitle: Text(languageCubit.state.locale.languageCode == 'en'
                  ? 'English'
                  : 'العربية'),
              trailing: DropdownButton<String>(
                value: languageCubit.state.locale.languageCode,
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    languageCubit.changeLanguage(value);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Company Settings
          Text(
            l10n.companySettings,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.business),
              title: Text(l10n.companySettings),
              subtitle: Text(l10n.manageCompanyDetails),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompanyInfoScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // API Configuration section
          Text(
            l10n.apiConfiguration,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _apiUrlController,
                    decoration: InputDecoration(
                      labelText: l10n.apiUrl,
                      hintText: l10n.apiUrlPlaceholder,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _saveApiUrl,
                    child: Text(l10n.saveApiUrl),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(l10n.syncEnabled),
                    subtitle: Text(l10n.enableDataSync),
                    value: _syncEnabled,
                    onChanged: _toggleSync,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Data Management section
          Text(
            l10n.dataManagement,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: Text(l10n.clearAllData,
                  style: const TextStyle(color: Colors.red)),
              subtitle: Text(l10n.deleteAllBusinessData),
              onTap: _clearData,
            ),
          ),
        ],
      ),
    );
  }
}
