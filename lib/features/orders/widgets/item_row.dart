import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  final String item;
  final String qty;
  final String price;

  const ItemRow({
    super.key,
    required this.item,
    required this.qty,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.checkroom),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            "$item  $qty",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
