import 'package:flutter/material.dart';

class ServiceHeaderCard extends StatelessWidget {
  const ServiceHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.local_laundry_service,
            size: 40,
            color: Colors.blue,
          ),
        ),
        title: const Text(
          'Wash & Fold',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Starting from ₹49/kg'),
      ),
    );
  }
}
