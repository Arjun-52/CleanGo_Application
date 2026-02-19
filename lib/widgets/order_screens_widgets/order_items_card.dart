import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'service_chip.dart';
import 'item_row.dart';
import 'addon_row.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Order Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 12),

          Text("Service Details"),
          SizedBox(height: 10),

          Row(
            children: [
              ServiceChip(icon: Icons.schedule, label: "Standard"),
              SizedBox(width: 8),
              ServiceChip(
                icon: Icons.local_laundry_service,
                label: "Wash & Iron",
              ),
            ],
          ),

          Divider(height: 24),

          ItemRow(item: "Shirt", qty: "x1", price: "₹30"),
          Divider(),
          ItemRow(item: "Trousers", qty: "x1", price: "₹40"),

          Divider(height: 24),

          Text("Add-ons"),
          SizedBox(height: 10),

          AddonRow(item: "Fabric Softener", price: "₹25"),
          SizedBox(height: 8),
          AddonRow(item: "Stain Treatment", price: "₹25"),

          Divider(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "₹95",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF013E6D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
