import 'package:flutter/material.dart';

class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'title': 'Order Placed', 'subtitle': '5 Feb, 10:00 AM', 'isCompleted': true},
      {'title': 'Order Confirmed', 'subtitle': '5 Feb, 10:05 AM', 'isCompleted': true},
      {'title': 'Picked Up', 'subtitle': '5 Feb, 2:00 PM', 'isCompleted': true},
      {'title': 'In Progress', 'subtitle': 'Processing your clothes', 'isCompleted': false, 'isCurrent': true},
      {'title': 'Out for Delivery', 'subtitle': 'Pending', 'isCompleted': false},
      {'title': 'Delivered', 'subtitle': 'Pending', 'isCompleted': false},
    ];

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isCompleted = step['isCompleted'] as bool;
        final isCurrent = step['isCurrent'] == true;
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? Colors.green : (isCurrent ? Colors.blue : Colors.grey[300]),
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : (isCurrent ? const Icon(Icons.radio_button_checked, size: 16, color: Colors.white) : null),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: isCompleted ? Colors.green : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['title'] as String,
                      style: TextStyle(
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCompleted || isCurrent ? Colors.black : Colors.grey,
                      ),
                    ),
                    Text(
                      step['subtitle'] as String,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
