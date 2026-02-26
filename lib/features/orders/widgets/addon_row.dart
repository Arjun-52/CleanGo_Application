import 'package:flutter/material.dart';

class AddonRow extends StatelessWidget {
  final String item;
  final String price;

  const AddonRow({super.key, required this.item, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 12,
          backgroundColor: Color(0xFF013E6D),
          child: Icon(Icons.check, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
