import 'package:flutter/material.dart';
import 'package:clean_go/features/orders/screens/order_tracking_screen.dart';

import '../../../routes/app_routes.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Success Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD7F2E3),
                ),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xff22B573),
                  child: Icon(Icons.check, color: Colors.white, size: 40),
                ),
              ),

              const SizedBox(height: 24),

              /// Title
              const Text(
                "Order Placed!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1F2A44),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Your order has been confirmed successfully",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 24),

              /// Order Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            "Order Number",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "CLN-2026-001",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0D47A1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),

                    /// Items info
                    Row(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Color(0xffE8F0FE),
                          child: Icon(
                            Icons.inventory_2,
                            color: Color(0xff0D47A1),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(child: Text("2 items • Standard")),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Amount Paid",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "₹95",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0D47A1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Info box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffE3F2FD),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xff90CAF9)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.sms, color: Color(0xff0D47A1)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "You'll receive pickup OTP via SMS before the pickup slot",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// Track Order button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0D47A1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderTrackingScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    "Track Order",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// Home button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff0D47A1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.main,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Go to Home",
                    style: TextStyle(color: Color(0xff0D47A1)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
