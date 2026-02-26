import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'item_model.dart';

class ItemRow extends StatelessWidget {
  final ItemModel item;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ItemRow({
    super.key,
    required this.item,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.checkroom),
          const SizedBox(width: 12),
          Expanded(child: Text(item.name)),
          qty == 0
              ? GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xff013E6D)),
                    ),
                    child: const Text(
                      "+ Add",
                      style: TextStyle(color: Color(0xff013E6D)),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xff013E6D),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: onRemove,
                      ),
                      Text("$qty", style: const TextStyle(color: Colors.white)),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: onAdd,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
