import 'package:flutter/material.dart';
import 'reusable_card.dart';

class OrderInfoCard extends StatelessWidget {
  final String orderId;

  const OrderInfoCard({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.inventory, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "$orderId\nProcessing",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.withOpacity(.15),
                ),
                child: const Text(
                  "On Track",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          const Text(
            "Estimated Delivery Date",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            "Saturday, Feb 28, 03:00 PM",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF013E6D),
            ),
          ),
        ],
      ),
    );
  }
}
