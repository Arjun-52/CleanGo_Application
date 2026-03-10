import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';

import 'package:clean_go/features/orders/presentation/widgets/order_success_icon.dart';
import 'package:clean_go/features/orders/presentation/widgets/order_summary_card.dart';
import 'package:clean_go/features/orders/presentation/widgets/pickup_otp_info_box.dart';

import 'package:clean_go/features/orders/presentation/screens/order_tracking_screen.dart';
import '../../../../routes/app_routes.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 20),

              const OrderSuccessIcon(),

              const SizedBox(height: 24),

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

              const OrderSummaryCard(
                orderNumber: "CLN-2026-001",
                itemCount: 2,
                serviceType: "Standard",
                amount: "₹95",
              ),

              const SizedBox(height: 20),

              const PickupOtpInfoBox(),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OrderTrackingScreen()),
                    );
                  },
                  child: const Text(
                    "Track Order",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 12),

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
