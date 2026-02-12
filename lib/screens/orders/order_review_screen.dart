import 'package:clean_go/screens/booking/payment_screen.dart';
import 'package:flutter/material.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Order Review",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ADDRESS + DELIVERY INFO
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8F0FE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xff0D47A1),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pickup & Delivery Address :",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Mega Hills, 18, Madhapur, Hyd...",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),

                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 8),

                  const Text("Pickup by", style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 4),

                  const Text(
                    "Thursday, Jan 01, 09:00 - 11:00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0D47A1),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    "Estimated Delivery Date",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "Saturday, Feb 28, 03:00 PM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0D47A1),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SERVICE DETAILS (NEW SECTION)
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
                  const Text(
                    "Service Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffE3F2FD),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xff0D47A1)),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Color(0xff0D47A1),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Standard",
                              style: TextStyle(
                                color: Color(0xff0D47A1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffE0F2F1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.teal),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.checkroom, size: 16, color: Colors.teal),
                            SizedBox(width: 6),
                            Text(
                              "Wash & Iron",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ITEMS
            _sectionCard(
              title: "Items (2)",
              children: const [
                _ItemRow("Shirt", "₹30"),
                _ItemRow("Trousers", "₹40"),
              ],
            ),

            const SizedBox(height: 20),

            /// ADDONS
            _sectionCard(
              title: "Add-ons",
              children: const [_AddonRow("Fabric Softener", "₹25")],
            ),

            const SizedBox(height: 20),

            /// PRICE BREAKDOWN
            _sectionCard(
              title: "Price Breakdown",
              children: const [
                _PriceRow("Items Total", "₹75"),
                _PriceRow("Add-ons", "₹25"),
                Divider(),
                _PriceRow("Grand Total", "₹95", bold: true),
              ],
            ),

            const SizedBox(height: 30),

            /// PAYMENT BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaymentScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0D47A1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _sectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _sectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  final String name;
  final String price;

  const _ItemRow(this.name, this.price);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.checkroom),
          const SizedBox(width: 10),
          Expanded(child: Text(name)),
          Text(price),
        ],
      ),
    );
  }
}

class _AddonRow extends StatelessWidget {
  final String name;
  final String price;

  const _AddonRow(this.name, this.price);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Color(0xff0D47A1)),
        const SizedBox(width: 10),
        Expanded(child: Text(name)),
        Text(price),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _PriceRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
