import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final String title;
  final String time;
  final bool completed;
  final bool active;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.title,
    required this.time,
    this.completed = false,
    this.active = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = completed || active
        ? Colors.teal
        : Colors.grey.shade400;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE (CIRCLE + LINE)
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed
                      ? const Color(0xFF148C81)
                      : Colors.transparent,
                  border: Border.all(
                    color: completed
                        ? const Color(0xFF148C81)
                        : active
                        ? const Color(0xFF148C81)
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: completed
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: active
                                ? const Color(0xFF148C81)
                                : Colors.grey,
                          ),
                        ),
                ),
              ),

              if (!isLast)
                Transform.translate(
                  offset: const Offset(0, 23),
                  child: Container(
                    width: 3,
                    height: 90,
                    color: const Color(0xFF148C81),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          /// RIGHT SIDE TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                if (time.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
