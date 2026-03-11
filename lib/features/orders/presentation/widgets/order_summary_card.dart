import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';

class OrderSummaryCard extends StatelessWidget {
  final String orderNumber;
  final int itemCount;
  final String serviceType;
  final String amount;

  const OrderSummaryCard({
    super.key,
    required this.orderNumber,
    required this.itemCount,
    required this.serviceType,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          /// TOP ROW
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xff0D47A1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.inventory_2, color: Colors.white),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderNumber,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      "Processing",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.5),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "On Track",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(height: 24),

          /// DELIVERY DATE
          const Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                "Estimated Delivery Date",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Saturday, Feb 28, 03:00 PM",
              style: TextStyle(
                color: Color(0xff0D47A1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
