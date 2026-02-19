import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'timeline_item.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Order Timeline",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 14),
          TimelineItem(
            title: "Order Confirmed",
            time: "Feb 26, 02:58 PM",
            completed: true,
          ),
          TimelineItem(
            title: "Items Picked Up",
            time: "Feb 26, 03:18 PM",
            completed: true,
          ),
          TimelineItem(
            title: "Processing at Facility",
            time: "Feb 27, 11:02",
            completed: true,
          ),
          TimelineItem(title: "Quality Check", time: "", active: true),
          TimelineItem(title: "Out For Delivery", time: ""),
          TimelineItem(title: "Delivered", time: ""),
        ],
      ),
    );
  }
}
