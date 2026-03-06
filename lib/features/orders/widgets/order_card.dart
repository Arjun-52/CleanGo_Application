import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String date;
  final String amount;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.date,
    required this.amount,
    required this.onTap,
    required order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            /// TOP ROW
            Row(
              children: [
                /// ICON BOX
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xff0B3C5D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 12),

                /// ORDER INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ORDER ID
                      Text(
                        orderId,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// STATUS + ITEMS
                      const Text(
                        "Processing • 2 items",
                        style: TextStyle(
                          color: Color(0xff6B7280),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                /// STATUS BADGE
                _statusBadge(status),
              ],
            ),

            const SizedBox(height: 12),

            const Divider(),

            const SizedBox(height: 10),

            /// BOTTOM ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// DATE
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xff6B7280),
                    fontSize: 13,
                  ),
                ),

                Row(
                  children: [
                    /// PRICE
                    Text(
                      amount,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xff0B3C5D),
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color border;
    Color bg;
    IconData icon;

    if (status.toLowerCase() == "on track") {
      border = const Color(0xff22C55E);
      bg = const Color(0xffDCFCE7);
      icon = Icons.check_circle_outline;
    } else {
      border = const Color(0xffEF4444);
      bg = const Color(0xffFEE2E2);
      icon = Icons.error_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: border),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: border,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
