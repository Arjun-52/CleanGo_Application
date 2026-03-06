import 'package:flutter/material.dart';
import 'package:clean_go/features/orders/widgets/reusable_card.dart';
import 'package:clean_go/features/orders/models/order_model.dart';
import 'package:clean_go/features/orders/utils/order_formatters.dart';

class PickupDeliveryCard extends StatelessWidget {
  final OrderModel order;

  const PickupDeliveryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ReusableCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.access_time, size: 22, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(
                      "Pickup",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  formatDate(order.pickupTime),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  "09:00 - 11:00",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ReusableCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.access_time, size: 22, color: Colors.orange),
                    SizedBox(width: 6),
                    Text(
                      "Delivery",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  formatDate(order.deliveryTime),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  "09:00 - 11:00",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
