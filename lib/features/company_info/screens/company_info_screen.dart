import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;
import 'package:realestate_app/l10n/app_localizations.dart';

import '../../../core/database/database.dart';
import '../cubit/company_info_cubit.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameEnController;
  late TextEditingController _nameArController;
  late TextEditingController _addressEnController;
  late TextEditingController _addressArController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _vatController;
  late TextEditingController _crnController;
  late TextEditingController _websiteController;

  String? _logoBase64;
  final ImagePicker _picker = ImagePicker();
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _nameEnController = TextEditingController();
    _nameArController = TextEditingController();
    _addressEnController = TextEditingController();
    _addressArController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _vatController = TextEditingController();
    _crnController = TextEditingController();
    _websiteController = TextEditingController();

    // Load data when screen initializes
    context.read<CompanyInfoCubit>().loadCompanyInfo();
  }

  @override
  void dispose() {
    _nameEnController.dispose();
    _nameArController.dispose();
    _addressEnController.dispose();
    _addressArController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _vatController.dispose();
    _crnController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _updateControllers(CompanyInfoData info) {
    if (_isLoaded) {
      return; // Prevent overwriting user edits if called multiple times
    }

    _nameEnController.text = info.nameEn ?? '';
    _nameArController.text = info.nameAr ?? '';
    _addressEnController.text = info.addressEn ?? '';
    _addressArController.text = info.addressAr ?? '';
    _phoneController.text = info.phone ?? '';
    _emailController.text = info.email ?? '';
    _vatController.text = info.vatNumber ?? '';
    _crnController.text = info.crn ?? '';
    _websiteController.text = info.website ?? '';

    setState(() {
      _logoBase64 = info.logoBase64;
      _isLoaded = true;
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      final String base64String = base64Encode(imageBytes);
      setState(() {
        _logoBase64 = base64String;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _logoBase64 = null;
    });
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final info = CompanyInfoCompanion(
        nameEn: drift.Value(_nameEnController.text),
        nameAr: drift.Value(_nameArController.text),
        addressEn: drift.Value(_addressEnController.text),
        addressAr: drift.Value(_addressArController.text),
        phone: drift.Value(_phoneController.text),
        email: drift.Value(_emailController.text),
        vatNumber: drift.Value(_vatController.text),
        crn: drift.Value(_crnController.text),
        website: drift.Value(_websiteController.text),
        logoBase64: drift.Value(_logoBase64),
      );
      context.read<CompanyInfoCubit>().saveCompanyInfo(info);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.companySettings),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: BlocConsumer<CompanyInfoCubit, CompanyInfoState>(
        listener: (context, state) {
          if (state is CompanyInfoLoaded && state.info != null) {
            _updateControllers(state.info!);
          }
          if (state is CompanyInfoSaveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.companyInfoSaved)),
            );
          }
          if (state is CompanyInfoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CompanyInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: _logoBase64 != null
                        ? Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  image: DecorationImage(
                                    image:
                                        MemoryImage(base64Decode(_logoBase64!)),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: _pickImage,
                                    icon: const Icon(Icons.edit, size: 18),
                                    label: Text(l10n.change),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black87,
                                      side: const BorderSide(
                                          color: Colors.black87),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  OutlinedButton.icon(
                                    onPressed: _removeImage,
                                    icon: const Icon(Icons.delete, size: 18),
                                    label: Text(l10n.remove),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      side: const BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: _pickImage,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.grey[200],
                                  child: const Icon(Icons.add_a_photo,
                                      size: 40, color: Colors.grey),
                                ),
                                const SizedBox(height: 16),
                                Text(l10n.uploadLogo),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(l10n.basicData),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameEnController,
                          decoration: InputDecoration(
                            labelText: l10n.companyNameEn,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _nameArController,
                          decoration: InputDecoration(
                            labelText: l10n.companyNameAr,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _addressEnController,
                          decoration: InputDecoration(
                            labelText: l10n.companyAddressEn,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _addressArController,
                          decoration: InputDecoration(
                            labelText: l10n.companyAddressAr,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(l10n.details),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: l10n.phoneNumber,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: l10n.email,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _vatController,
                          decoration: InputDecoration(
                            labelText: l10n.vatNumber,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _crnController,
                          decoration: InputDecoration(
                            labelText: l10n.crn,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _websiteController,
                    decoration: InputDecoration(
                      labelText: l10n.website,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
