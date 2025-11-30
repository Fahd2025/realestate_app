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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('API URL saved')),
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
            'This will permanently delete all users, properties, contracts, and other business data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear Data'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await context.read<AppDatabase>().clearData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All data cleared successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error clearing data: $e')),
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
                  subtitle: Text(themeCubit.state.isDarkMode ? 'On' : 'Off'),
                  value: themeCubit.state.isDarkMode,
                  onChanged: (value) {
                    themeCubit.toggleTheme();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(l10n.colorScheme),
                  subtitle: Text(themeCubit.state.colorScheme.toUpperCase()),
                  trailing: DropdownButton<String>(
                    value: themeCubit.state.colorScheme,
                    items: ['blue', 'green', 'purple']
                        .map((scheme) => DropdownMenuItem(
                              value: scheme,
                              child: Text(scheme.toUpperCase()),
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
              title: const Text('Language'),
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
              subtitle: const Text('Manage company details and logo'),
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
            'API Configuration',
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
                      hintText: 'https://api.example.com',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _saveApiUrl,
                    child: const Text('Save API URL'),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(l10n.syncEnabled),
                    subtitle:
                        const Text('Enable data synchronization with server'),
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
            'Data Management',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text('Clear All Data',
                  style: TextStyle(color: Colors.red)),
              subtitle: const Text('Delete all business data from the app'),
              onTap: _clearData,
            ),
          ),
        ],
      ),
    );
  }
}
