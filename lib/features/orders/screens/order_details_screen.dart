import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_go/core/constants/colors.dart';

import 'package:clean_go/features/orders/widgets/order_info_card.dart';
import 'package:clean_go/features/orders/widgets/order_items_card.dart';
import 'package:clean_go/features/orders/widgets/order_timeline.dart';
import 'package:clean_go/features/orders/widgets/reusable_card.dart';
import 'package:clean_go/features/orders/widgets/qr_otp_card.dart';
import 'package:clean_go/features/orders/widgets/pickup_delivery_card.dart';

import 'package:clean_go/features/orders/providers/order_provider.dart';
import 'package:clean_go/features/orders/models/order_model.dart';

import 'package:clean_go/features/orders/utils/order_formatters.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();

    /// Load order details after screen builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(
        context,
        listen: false,
      ).loadOrderDetails(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 6,
        iconTheme: const IconThemeData(color: Colors.black),

        title: Consumer<OrderProvider>(
          builder: (context, provider, child) {
            final order = provider.currentOrder;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.orderId,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "${getOrderStatusText(order?.status)} • ${formatTime(order?.createdAt)}",
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),

      /// ---------------- BODY ----------------
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                "Error loading order: ${provider.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final order = provider.currentOrder;

          if (order == null) {
            return const Center(child: Text("Order not found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                /// Summary Card
                OrderInfoCard(orderId: widget.orderId),

                /// Order Items
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

                const SizedBox(height: 12),

                /// Pickup & Delivery
                PickupDeliveryCard(order: order),

                const SizedBox(height: 14),

                /// Timeline
                const OrderTimeline(),

                /// QR & OTP
                QrOtpCard(order: order),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),

      /// ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: AppColors.grey,
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
