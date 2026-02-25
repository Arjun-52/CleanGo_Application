// TODO Implement this library.
import 'package:flutter/material.dart';

class AddressTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onChanged;

  const AddressTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _option("Home")),
        const SizedBox(width: 12),
        Expanded(child: _option("Other")),
      ],
    );
  }

  Widget _option(String type) {
    final bool isSelected = selectedType == type;

    return GestureDetector(
      onTap: () => onChanged(type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff0B3C5D) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          type,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xff1F2A44),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
