import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/company_info/cubit/company_info_cubit.dart';

class CompanyDrawerHeader extends StatelessWidget {
  const CompanyDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return BlocBuilder<CompanyInfoCubit, CompanyInfoState>(
      builder: (context, state) {
        // Default values
        String companyName = isArabic ? 'مدير النظام' : 'System Administrator';
        String? logoBase64;
        String? vatNumber;
        String? crn;

        // Update with actual company info if loaded
        if (state is CompanyInfoLoaded && state.info != null) {
          final info = state.info!;
          companyName = isArabic
              ? (info.nameAr?.isNotEmpty == true ? info.nameAr! : companyName)
              : (info.nameEn?.isNotEmpty == true ? info.nameEn! : companyName);
          logoBase64 = info.logoBase64;
          vatNumber = info.vatNumber;
          crn = info.crn;
        }

        return Container(
          height: 170, // Increased from default 140
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row with logo and profile button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo - circular with app icon fallback
                  if (logoBase64 != null && logoBase64.isNotEmpty)
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: MemoryImage(base64Decode(logoBase64)),
                    )
                  else
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.home_work,
                        size: 35,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  // Profile button
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Company Name
              Text(
                companyName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // VAT Number and CRN
              if (vatNumber != null && vatNumber.isNotEmpty)
                Text(
                  '${isArabic ? 'الرقم الضريبي' : 'VAT'}: $vatNumber',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (crn != null && crn.isNotEmpty)
                Text(
                  '${isArabic ? 'السجل التجاري' : 'CRN'}: $crn',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        );
      },
    );
  }
}
