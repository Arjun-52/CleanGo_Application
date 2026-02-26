import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:clean_go/features/payment/screens/booking_payment_screen.dart';

import 'package:clean_go/features/orders/widgets/order_section_card.dart';
import 'package:clean_go/features/orders/widgets/order_item_row.dart';
import 'package:clean_go/features/orders/widgets/order_addon_row.dart';
import 'package:clean_go/features/orders/widgets/order_price_row.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

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
                color: AppColors.white,
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.access_time, // clock icon
                        size: 20,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Pickup by",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Thursday, Jan 01, 09:00 - 11:00",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0D47A1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.local_shipping_outlined, // delivery-style icon
                        size: 20,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Estimated Delivery Date",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Saturday, Feb 28, 03:00 PM",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0D47A1),
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

            /// SERVICE DETAILS
            OrderSectionCard(
              title: "Service Details",
              children: [
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

            const SizedBox(height: 20),

            /// ITEMS
            OrderSectionCard(
              title: "Items (2)",
              children: const [
                OrderItemRow(name: "Shirt", qty: 1, price: "₹30"),
                OrderItemRow(name: "Trousers", qty: 1, price: "₹40"),
              ],
            ),

            const SizedBox(height: 20),

            /// ADD-ONS
            OrderSectionCard(
              title: "Add-ons",
              children: const [
                OrderAddonRow(name: "Fabric Softener", price: "₹25"),
              ],
            ),

            const SizedBox(height: 20),

            /// PRICE BREAKDOWN
            OrderSectionCard(
              title: "Price Breakdown",
              children: const [
                OrderPriceRow(label: "Items Total", value: "₹75"),
                OrderPriceRow(label: "Add-ons", value: "₹25"),
                Divider(),
                OrderPriceRow(label: "Grand Total", value: "₹95", bold: true),
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
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
