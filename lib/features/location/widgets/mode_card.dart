import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ModeCard extends StatelessWidget {
  final int index;
  final int selectedMode;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ModeCard({
    super.key,
    required this.index,
    required this.selectedMode,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool selected = selectedMode == index;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? const Color(0xff0D47A1) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Same-day delivery,\nno add-ons",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            if (selected)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.check_circle, color: Color(0xff0D47A1)),
              ),
          ],
        ),
      ),
    );
  }
}
