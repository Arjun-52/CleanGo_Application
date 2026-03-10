import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';

class AddressSummaryCard extends StatelessWidget {
  final String label;
  final String address;
  final bool isDefault;
  final Function(String)? onMenuSelected;

  const AddressSummaryCard({
    super.key,
    required this.label,
    required this.address,
    required this.isDefault,
    this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// Address label
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),

              const SizedBox(width: 8),

              /// Default badge
              if (isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff22B573).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Default",
                    style: TextStyle(
                      color: Color(0xff22B573),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              const Spacer(),

              /// Popup menu
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Color(0xff64748B)),
                onSelected: onMenuSelected,
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'set_default',
                    child: Text("Set Default"),
                  ),
                  PopupMenuItem(value: 'edit', child: Text("Edit")),
                  PopupMenuItem(value: 'delete', child: Text("Delete")),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Address text
          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
