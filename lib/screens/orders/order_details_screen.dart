import 'package:flutter/material.dart';

import 'package:clean_go/widgets/order_screens_widgets/order_info_card.dart';
import 'package:clean_go/widgets/order_screens_widgets/order_items_card.dart';
import 'package:clean_go/widgets/order_screens_widgets/order_timeline.dart';
import 'package:clean_go/widgets/order_screens_widgets/reusable_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderId,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Processing • 02:58 PM",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),

      /// ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Summary Card
            const OrderInfoCard(orderId: "CLN-2026-001"),

            /// Order Items & Pricing
            const OrderItemsCard(),

            /// Address Card
            const ReusableCard(
              child: ListTile(
                leading: Icon(Icons.location_on, color: Color(0xFF013E6D)),
                title: Text(
                  "Pickup & Delivery Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Mega Hills, 18, Madhapur,\nHyderabad, 50003"),
              ),
            ),

            /// Pickup & Delivery Time Cards
            const SizedBox(height: 12),

            const Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 22,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Pickup",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Feb 27",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "09:00 - 11:00",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ReusableCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 22,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Delivery",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Feb 28",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "09:00 - 11:00",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// Timeline
            const OrderTimeline(),

            /// QR & OTP
            QrOtpCard(),

            const SizedBox(height: 20),
          ],
        ),
      ),

      ///   BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: "Track",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

Widget QrOtpCard() {
  return ReusableCard(
    child: Column(
      children: const [
        Icon(Icons.qr_code, size: 60, color: Colors.black),
        SizedBox(height: 8),
        Text(
          "Show this QR at pickup",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text("OTP: 1234", style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}
