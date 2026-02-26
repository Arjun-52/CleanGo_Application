import 'package:flutter/material.dart';

class AddUpiRow extends StatelessWidget {
  final VoidCallback onTap;

  const AddUpiRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/upi.jpg",
            height: 24,
            width: 24,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
        ],
      ),
      title: const Text("Add UPI ID"),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
