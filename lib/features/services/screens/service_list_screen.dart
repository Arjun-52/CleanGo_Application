import 'package:flutter/material.dart';
import '../../../core/constants/strings.dart';
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
            onTap: () => Navigator.pushNamed(context, '/service-detail'),
          ),
          ServiceCard(
            title: 'Dry Cleaning',
            icon: Icons.dry_cleaning,
            onTap: () => Navigator.pushNamed(context, '/service-detail'),
          ),
          ServiceCard(
            title: 'Ironing',
            icon: Icons.iron,
            onTap: () => Navigator.pushNamed(context, '/service-detail'),
          ),
          ServiceCard(
            title: 'Premium Care',
            icon: Icons.star,
            onTap: () => Navigator.pushNamed(context, '/service-detail'),
          ),
        ],
      ),
    );
  }
}
