import 'package:flutter/material.dart';

class ServiceItemCard extends StatelessWidget {
  final String itemName;

  const ServiceItemCard({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(itemName),
        subtitle: const Text('₹49'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {},
            ),
            const Text('0'),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
