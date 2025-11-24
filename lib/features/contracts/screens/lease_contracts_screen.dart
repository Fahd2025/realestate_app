import 'package:flutter/material.dart';
import 'package:realestate_app/features/contracts/widgets/contracts_view.dart';

class LeaseContractsScreen extends StatelessWidget {
  const LeaseContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContractsView(contractType: 'lease');
  }
}
