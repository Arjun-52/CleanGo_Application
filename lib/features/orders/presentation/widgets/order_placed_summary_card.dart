import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';

class OrderPlacedSummaryCard extends StatelessWidget {
  final String orderNumber;
  final int itemCount;
  final String serviceMode;
  final String amount;

  const OrderPlacedSummaryCard({
    super.key,
    required this.orderNumber,
    required this.itemCount,
    required this.serviceMode,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ORDER NUMBER
          const Center(
            child: Text(
              "Order Number",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              orderNumber,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff0D47A1),
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Divider(),

          const SizedBox(height: 10),

          /// ITEMS + SERVICE MODE
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Color(0xff0D47A1),
                ),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Items",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(height: 2),

                  Row(
                    children: [
                      Text(
                        "$itemCount items",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(width: 8),

                      const Text("•", style: TextStyle(color: Colors.grey)),

                      const SizedBox(width: 8),

                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color(0xff0D47A1),
                      ),

                      const SizedBox(width: 4),

                      Text(
                        serviceMode,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Divider(),

          const SizedBox(height: 10),

          /// AMOUNT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Amount Paid",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "$amount",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff0D47A1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
