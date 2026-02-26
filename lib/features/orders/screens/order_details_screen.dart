import 'package:flutter/material.dart';

import 'package:clean_go/features/orders/widgets/order_info_card.dart';
import 'package:clean_go/features/orders/widgets/order_items_card.dart';
import 'package:clean_go/features/orders/widgets/order_timeline.dart';
import 'package:clean_go/features/orders/widgets/reusable_card.dart';

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
            ReusableCard(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC7E6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xFF013E6D),
                    size: 26,
                  ),
                ),
                title: const Text(
                  "Pickup & Delivery Address:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Mega Hills, 18, Madhapur,\nHyderabad, 50003",
                ),
              ),
            ),

            /// Pickup & Delivery Time Cards
            const SizedBox(height: 12),

            const Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.access_time, size: 22, color: Colors.orange),
                        const SizedBox(width: 8),

                        // 👇 All text inside ONE column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Delivery",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Order QR Code & OTP",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        const SizedBox(height: 20),

        Image.asset(
          "assets/images/ffcdb9513a78678ba246a95018506475.jpg",
          height: 120,
          width: 120,
        ),

        const SizedBox(height: 12),

        const Text(
          "CLN-2026-001-QR",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 16),
        const Divider(),

        const SizedBox(height: 12),

        // OTP Section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.key, size: 18, color: Colors.blueGrey),
            SizedBox(width: 6),
            Text("Pickup OTP", style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),

        const SizedBox(height: 8),

        const Text(
          "5646",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    ),
  );
}
