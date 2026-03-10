import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/orders/data/models/order_model.dart';
import 'package:intl/intl.dart';

class ActiveOrderCard extends StatelessWidget {
  final OrderModel order;

  const ActiveOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0B3C5D);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW
            Row(
              children: [
                /// ICON
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryColor,
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
                      Text(
                        order.id ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 2),

                      const Text(
                        "Processing",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                /// STATUS BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffE6F4EA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, size: 14, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        "On track",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: 0.6,
                minHeight: 6,
                backgroundColor: Colors.grey.shade300,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 8),

            /// STEP
            const Text(
              "Step 4 of 7",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 8),

            /// DELIVERY INFO
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),

                const SizedBox(width: 6),

                const Text(
                  "Delivery by · ",
                  style: TextStyle(color: Colors.grey),
                ),

                Text(
                  order.deliveryTime != null
                      ? DateFormat(
                          'MMM dd, hh:mm a',
                        ).format(order.deliveryTime!)
                      : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),

                const Spacer(),

                const Text(
                  "-02h -21m",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
