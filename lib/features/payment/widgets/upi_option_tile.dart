import 'package:flutter/material.dart';

class UpiOptionTile extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String name;
  final String iconPath;
  final Function(int) onSelect;

  const UpiOptionTile({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.name,
    required this.iconPath,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<int>(
            value: index,
            groupValue: selectedIndex,
            activeColor: const Color(0xff013E6D),
            onChanged: (val) {
              onSelect(val!);
            },
          ),
          const SizedBox(width: 6),

          Image.asset(iconPath, height: 24, width: 24, fit: BoxFit.contain),
        ],
      ),

      title: Text(name),

      onTap: () => onSelect(index),
    );
  }
}
