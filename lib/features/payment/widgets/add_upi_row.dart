import 'package:flutter/material.dart';

class AddUpiRow extends StatelessWidget {
  final VoidCallback onTap;

  const AddUpiRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.add_card),
      title: const Text("Add UPI ID"),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
