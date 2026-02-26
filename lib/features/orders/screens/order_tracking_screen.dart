import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/orders/widgets/order_timeline.dart';
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0D47A1);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 5,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Order Tracking",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ORDER SUMMARY CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.inventory_2,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CLN-2026-001",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Processing",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "On Track",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  Row(
                    children: const [
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "Estimated Delivery Date",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Saturday, Feb 28, 03:00 PM",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// ✅ NEW TIMELINE WIDGET
            const OrderTimeline(),

            const SizedBox(height: 24),

            /// QR + OTP
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order QR Code & OTP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    height: 110,
                    width: 110,
                    color: Colors.black,
                    child: const Center(
                      child: Icon(
                        Icons.qr_code,
                        color: AppColors.white,
                        size: 60,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "CLN-2026-001-QR",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const Divider(height: 24),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.key, size: 18, color: Colors.grey),
                      SizedBox(width: 6),
                      Text("Pickup OTP", style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "5646",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
