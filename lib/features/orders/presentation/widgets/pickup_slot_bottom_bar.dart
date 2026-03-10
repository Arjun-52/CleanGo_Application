import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';

class PickupSlotBottomBar extends StatelessWidget {
  final String time;
  final VoidCallback onNext;

  const PickupSlotBottomBar({
    super.key,
    required this.time,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jan 08, $time",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("Pickup Slot", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
