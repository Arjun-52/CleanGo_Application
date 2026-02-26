import 'package:flutter/material.dart';
import 'package:clean_go/features/orders/screens/order_details_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Order History",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          OrderHistoryCard(
            orderId: "CLN-2026-001",
            status: "On Track",
            items: "Processing • 2 items",
            date: "Feb 26, 02:58 PM",
            price: "₹95",
            statusColor: Colors.green,
          ),
          SizedBox(height: 12),
          OrderHistoryCard(
            orderId: "CLN-2026-002",
            status: "On Track",
            items: "Processing • 6 items",
            date: "Feb 26, 02:58 PM",
            price: "₹95",
            statusColor: Colors.green,
          ),
          SizedBox(height: 12),
          OrderHistoryCard(
            orderId: "CLN-2026-003",
            status: "Breached",
            items: "Processing • 4 items",
            date: "Feb 26, 02:58 PM",
            price: "₹95",
            statusColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String items;
  final String date;
  final String price;
  final Color statusColor;

  const OrderHistoryCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.items,
    required this.date,
    required this.price,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(orderId: orderId),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderId,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(items, style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: statusColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: statusColor),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: TextStyle(color: Colors.grey[600])),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff013E6D),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_ios, size: 14),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
