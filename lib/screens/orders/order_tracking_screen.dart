import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0D47A1);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Order Tracking",
          style: TextStyle(color: Colors.black),
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ORDER SUMMARY CARD
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
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// Order details
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

                      /// Status
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

            const SizedBox(height: 20),

            /// TIMELINE
            _timelineCard(),

            const SizedBox(height: 20),

            /// QR + OTP
            _qrOtpCard(),
          ],
        ),
      ),
    );
  }

  /// ---------- TIMELINE CARD ----------
  static Widget _timelineCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Order Timeline", style: TextStyle(fontWeight: FontWeight.bold)),

          SizedBox(height: 16),

          _TimelineStep("Order Confirmed", "Feb 26, 02:58 PM", true),
          _TimelineStep("Items Pickup Up", "Feb 26, 3:18 PM", true),
          _TimelineStep("Processing at Facility", "Feb 27, 11:02", true),
          _TimelineStep("Quality Check", "", true, active: true),
          _TimelineStep("Out For Delivery", "Feb 28, 01:02 PM", false),
          _TimelineStep("Delivered", "Feb 28, 03:00 PM", false),
        ],
      ),
    );
  }

  /// ---------- QR & OTP CARD ----------
  static Widget _qrOtpCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
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

          /// QR placeholder
          Container(
            height: 110,
            width: 110,
            color: Colors.black,
            child: const Center(
              child: Icon(Icons.qr_code, color: Colors.white, size: 60),
            ),
          ),

          const SizedBox(height: 10),
          const Text("CLN-2026-001-QR", style: TextStyle(color: Colors.grey)),

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
    );
  }
}

/// ---------- TIMELINE STEP ----------
class _TimelineStep extends StatelessWidget {
  final String title;
  final String time;
  final bool done;
  final bool active;

  const _TimelineStep(this.title, this.time, this.done, {this.active = false});

  @override
  Widget build(BuildContext context) {
    final color = active
        ? Colors.teal
        : done
        ? Colors.teal
        : Colors.grey.shade400;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (time.isNotEmpty)
                  Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
