import 'package:flutter/material.dart';

class OrderItemRow extends StatelessWidget {
  final String name;
  final String price;

  const OrderItemRow({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.checkroom),
          const SizedBox(width: 10),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 14))),
          Text(price, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
