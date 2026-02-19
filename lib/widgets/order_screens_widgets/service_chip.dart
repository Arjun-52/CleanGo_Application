import 'package:flutter/material.dart';

class ServiceChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.teal),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.teal)),
        ],
      ),
    );
  }
}
