import 'package:flutter/material.dart';

class OrderPriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const OrderPriceRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: textStyle)),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}
