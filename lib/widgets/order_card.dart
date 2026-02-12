import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String date;
  final String amount;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.date,
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order #$orderId', style: const TextStyle(fontWeight: FontWeight.bold)),
                  _buildStatusChip(status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date, style: const TextStyle(color: Colors.grey)),
                  Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'delivered':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 12)),
    );
  }
}
