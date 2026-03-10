import 'package:flutter/material.dart';
import './service_item_card.dart';

class ServiceItemList extends StatelessWidget {
  const ServiceItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => ServiceItemCard(itemName: 'Item ${index + 1}'),
      ),
    );
  }
}
