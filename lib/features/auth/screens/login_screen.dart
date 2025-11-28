import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import '../../../core/constants/routes.dart';
import '../../../core/language/language_cubit.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../company_info/cubit/company_info_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Load company info for branding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyInfoCubit>().loadCompanyInfo();
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            LoginRequested(
              username: _usernameController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLoading = context.watch<AuthBloc>().state is AuthLoading;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E88E5),
              Color(0xFF42A5F5),
              Color(0xFF64B5F6),
            ],
          ),
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
            } else if (state is AuthUnauthenticated && state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Scrollbar(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 480),
                            child: Card(
                              elevation: 24,
                              shadowColor: Colors.black.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(48),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Logo - Circular with company logo or app icon
                                          BlocBuilder<CompanyInfoCubit,
                                              CompanyInfoState>(
                                            builder: (context, companyState) {
                                              if (companyState
                                                      is CompanyInfoLoaded &&
                                                  companyState.info != null &&
                                                  companyState
                                                          .info!.logoBase64 !=
                                                      null &&
                                                  companyState.info!.logoBase64!
                                                      .isNotEmpty) {
                                                return CircleAvatar(
                                                  radius: 60,
                                                  backgroundColor:
                                                      Color(0xFFE3F2FD),
                                                  backgroundImage: MemoryImage(
                                                      base64Decode(companyState
                                                          .info!.logoBase64!)),
                                                );
                                              }
                                              // Default app icon
                                              return CircleAvatar(
                                                radius: 60,
                                                backgroundColor:
                                                    Color(0xFFE3F2FD),
                                                child: Icon(
                                                  Icons.home_work,
                                                  size: 50,
                                                  color: Color(0xFF1E88E5),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 24),
                                          // Title - Use company name if available
                                          BlocBuilder<CompanyInfoCubit,
                                              CompanyInfoState>(
                                            builder: (context, companyState) {
                                              final locale =
                                                  Localizations.localeOf(
                                                      context);
                                              final isArabic =
                                                  locale.languageCode == 'ar';

                                              String appTitle = l10n.appTitle;
                                              String loginTitle = l10n.login;

                                              if (companyState
                                                      is CompanyInfoLoaded &&
                                                  companyState.info != null) {
                                                final companyName = isArabic
                                                    ? companyState.info!.nameAr
                                                    : companyState.info!.nameEn;

                                                if (companyName != null &&
                                                    companyName.isNotEmpty) {
                                                  loginTitle = appTitle;
                                                  appTitle = companyName;
                                                }
                                              }

                                              return Column(
                                                children: [
                                                  Text(
                                                    appTitle,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    loginTitle,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.color
                                                                  ?.withOpacity(
                                                                      0.7),
                                                        ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 32),
                                          // Demo credentials info box
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE3F2FD),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.info_outline,
                                                        color:
                                                            Color(0xFF1E88E5),
                                                        size: 24),
                                                    const SizedBox(width: 12),
                                                    Text(
                                                      l10n.defaultCredentials,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 12),
                                                _buildCredentialRow(l10n.admin,
                                                    'admin', '123', l10n),
                                                const SizedBox(height: 6),
                                                _buildCredentialRow(l10n.owner,
                                                    'owner1', '123', l10n),
                                                const SizedBox(height: 6),
                                                _buildCredentialRow(l10n.tenant,
                                                    'tenant1', '123', l10n),
                                                const SizedBox(height: 6),
                                                _buildCredentialRow(l10n.buyer,
                                                    'buyer1', '123', l10n),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          // Username field
                                          TextFormField(
                                            controller: _usernameController,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              labelText: l10n.username,
                                              prefixIcon:
                                                  Icon(Icons.person_outline),
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.grey[800]
                                                  : Colors.grey[50],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.grey[700]!
                                                      : Colors.grey[200]!,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Color(0xFF1E88E5),
                                                    width: 2),
                                              ),
                                            ),
                                            enabled: !isLoading,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your username';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (_) =>
                                                _handleLogin(),
                                          ),
                                          const SizedBox(height: 16),
                                          // Password field
                                          TextFormField(
                                            controller: _passwordController,
                                            obscureText: _obscurePassword,
                                            decoration: InputDecoration(
                                              labelText: l10n.password,
                                              prefixIcon:
                                                  Icon(Icons.lock_outline),
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.grey[800]
                                                  : Colors.grey[50],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.grey[700]!
                                                      : Colors.grey[200]!,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Color(0xFF1E88E5),
                                                    width: 2),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _obscurePassword
                                                      ? Icons
                                                          .visibility_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _obscurePassword =
                                                        !_obscurePassword;
                                                  });
                                                },
                                              ),
                                            ),
                                            enabled: !isLoading,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (_) =>
                                                _handleLogin(),
                                          ),
                                          const SizedBox(height: 32),
                                          // Login button
                                          SizedBox(
                                            width: double.infinity,
                                            height: 56,
                                            child: ElevatedButton(
                                              onPressed: isLoading
                                                  ? null
                                                  : _handleLogin,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFF1E88E5),
                                                foregroundColor: Colors.white,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: isLoading
                                                  ? SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      ),
                                                    )
                                                  : Text(
                                                      l10n.login.toUpperCase(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Theme and Language switchers in top-right corner
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Theme switcher
                                        BlocBuilder<ThemeCubit, ThemeState>(
                                          builder: (context, themeState) {
                                            return IconButton(
                                              icon: Icon(
                                                themeState.isDarkMode
                                                    ? Icons.light_mode_outlined
                                                    : Icons.dark_mode_outlined,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.7),
                                              ),
                                              onPressed: () => context
                                                  .read<ThemeCubit>()
                                                  .toggleTheme(),
                                              tooltip: themeState.isDarkMode
                                                  ? l10n.lightMode
                                                  : l10n.darkMode,
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        // Language switcher
                                        BlocBuilder<LanguageCubit,
                                            LanguageState>(
                                          builder: (context, languageState) {
                                            final isArabic = languageState
                                                    .locale.languageCode ==
                                                'ar';
                                            return IconButton(
                                              icon: Icon(Icons.language,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withOpacity(0.7)),
                                              onPressed: () {
                                                context
                                                    .read<LanguageCubit>()
                                                    .changeLanguage(
                                                        isArabic ? 'en' : 'ar');
                                              },
                                              tooltip: isArabic
                                                  ? 'English'
                                                  : 'العربية',
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCredentialRow(
      String role, String username, String password, AppLocalizations l10n) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            role,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '$username / $password',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 16, color: Colors.black45),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          tooltip: l10n.copy,
          onPressed: () {
            _usernameController.text = username;
            _passwordController.text = password;
          },
        ),
      ],
    );
  }
}
