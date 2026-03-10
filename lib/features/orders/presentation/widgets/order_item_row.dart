import 'package:flutter/material.dart';

class OrderItemRow extends StatelessWidget {
  final String name;
  final int qty;
  final String price;

  const OrderItemRow({
    super.key,
    required this.name,
    required this.qty,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.checkroom),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                Text(name, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                const Text(
                  "x 1",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
