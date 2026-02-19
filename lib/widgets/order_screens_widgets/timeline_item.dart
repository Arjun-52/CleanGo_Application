import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final String title;
  final String time;
  final bool completed;
  final bool active;

  const TimelineItem({
    super.key,
    required this.title,
    required this.time,
    this.completed = false,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color = completed || active ? Colors.teal : Colors.grey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: active ? Colors.white : color,
              child: Icon(
                completed ? Icons.check : Icons.circle,
                size: 12,
                color: active ? color : Colors.white,
              ),
            ),
            Container(width: 2, height: 45, color: Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
