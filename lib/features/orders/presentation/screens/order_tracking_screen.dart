import 'package:clean_go/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';

import 'package:clean_go/features/orders/presentation/widgets/order_summary_card.dart';
import 'package:clean_go/features/orders/presentation/widgets/order_timeline.dart';
import 'package:clean_go/features/orders/presentation/widgets/qr_otp_card.dart';

class OrderTrackingScreen extends StatelessWidget {
  OrderTrackingScreen({super.key});

  final OrderEntity order = OrderEntity(
    id: "CLN-2026-001",
    pickupOtp: "5646",
    totalAmount: 450,
    status: OrderStatus.inProgress,
    items: const [
      OrderItemEntity(serviceName: "Dry Cleaning", quantity: 3, price: 150),
    ],
  );

  @override
  Widget build(BuildContext context) {
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
            OrderSummaryCard(
              orderNumber: order.id ?? "",
              itemCount: order.items?.length ?? 0,
              serviceType: order.items?.first.serviceName ?? "",
              amount: "₹${order.totalAmount ?? 0}",
            ),

            const SizedBox(height: 24),

            const OrderTimeline(),

            const SizedBox(height: 24),

            QrOtpCard(order: order),
          ],
        ),
      ),
    );
  }
}
