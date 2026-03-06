import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/orders/models/order_model.dart';
import 'reusable_card.dart';

class QrOtpCard extends StatelessWidget {
  final OrderModel order;

  const QrOtpCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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

          Image.asset("assets/images/qr.jpg", height: 120, width: 120),

          const SizedBox(height: 12),

          Text(
            "${order.id ?? ""}-QR",
            style: const TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
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

          Text(
            order.pickupOtp ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
