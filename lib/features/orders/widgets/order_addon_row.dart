import 'package:flutter/material.dart';

class OrderAddonRow extends StatelessWidget {
  final String name;
  final String price;

  const OrderAddonRow({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xff0D47A1)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Text(price, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
