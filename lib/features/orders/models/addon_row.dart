import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'addon_model.dart';

class AddonRow extends StatelessWidget {
  final AddonModel addon;
  final bool selected;
  final VoidCallback onTap;

  const AddonRow({
    super.key,
    required this.addon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? const Color(0xff013E6D) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            selected
                ? const CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xff013E6D),
                    child: Icon(Icons.check, size: 16, color: Colors.white),
                  )
                : const Icon(Icons.add_circle_outline),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(addon.name),
                  const SizedBox(height: 2),
                  Text(
                    addon.desc,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text("+ ₹${addon.price}"),
          ],
        ),
      ),
    );
  }
}
