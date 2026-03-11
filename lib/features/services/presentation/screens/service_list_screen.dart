import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/strings.dart';
import '../../../../routes/app_router.dart';
import '../widgets/service_card.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.services)),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          ServiceCard(
            title: 'Wash & Fold',
            icon: Icons.local_laundry_service,
            onTap: () => context.goServiceDetail('wash-fold'),
          ),
          ServiceCard(
            title: 'Dry Cleaning',
            icon: Icons.dry_cleaning,
            onTap: () => context.goServiceDetail('dry-cleaning'),
          ),
          ServiceCard(
            title: 'Ironing',
            icon: Icons.iron,
            onTap: () => context.goServiceDetail('ironing'),
          ),
          ServiceCard(
            title: 'Premium Care',
            icon: Icons.star,
            onTap: () => context.goServiceDetail('premium-care'),
          ),
        ],
      ),
    );
  }
}
