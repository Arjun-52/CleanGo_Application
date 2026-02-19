import 'package:flutter/material.dart';

class ActiveOrderCard extends StatelessWidget {
  const ActiveOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0B3C5D);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.inventory_2, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CLN-2026-001",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text("Processing", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.6,
              color: Colors.green,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            const Text("Step 4 of 7", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
