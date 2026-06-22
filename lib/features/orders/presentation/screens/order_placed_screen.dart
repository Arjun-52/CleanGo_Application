import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clean_go/features/orders/presentation/widgets/order_success_icon.dart';
import 'package:clean_go/features/orders/presentation/widgets/pickup_otp_info_box.dart';
import 'package:clean_go/features/orders/data/models/create_order_model.dart';
import '../../../../routes/app_router.dart';

class OrderPlacedScreen extends StatelessWidget {
  final CreateOrderModel? order;

  const OrderPlacedScreen({super.key, this.order});

  String _formatDateTimeString(DateTime? dateTime) {
    if (dateTime == null) return "--";
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    final hour = (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12).toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? "PM" : "AM";
    return "$day $month $year $hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    final currentOrder = order ?? CreateOrderModel(
      id: "dc943695-1223-46d1-9234-f385d42868e0",
      orderRef: "CLN-2026-001",
      customerName: "Rahul Verma",
      itemsCount: 2,
      serviceMode: "Standard",
      serviceType: "Wash & Iron",
      status: "Pending Pickup",
      slaStatus: "On Track",
      packetQr: "QR-ORD-8924-abc123",
      price: 95.0,
      createdAt: DateTime.now(),
    );

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const OrderSuccessIcon(),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),

              // Detailed Order Confirmation Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Order Details",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow("Order Reference", currentOrder.orderRef ?? "--"),
                      const Divider(height: 20),
                      _buildDetailRow("Customer Name", currentOrder.customerName ?? "--"),
                      const Divider(height: 20),
                      _buildDetailRow("Items Count", "${currentOrder.itemsCount ?? 0} items"),
                      const Divider(height: 20),
                      _buildDetailRow("Service Mode", currentOrder.serviceMode ?? "--"),
                      const Divider(height: 20),
                      _buildDetailRow("Service Type", currentOrder.serviceType ?? "--"),
                      const Divider(height: 20),
                      _buildDetailRow("Order Status", currentOrder.status ?? "--"),
                      const Divider(height: 20),
                      _buildDetailRow("SLA Status", currentOrder.slaStatus ?? "--"),
                      const Divider(height: 20),
                      _buildDetailRow("Price", "₹${currentOrder.price?.toStringAsFixed(0) ?? '0'}"),
                      const Divider(height: 20),
                      _buildDetailRow("Created Time", _formatDateTimeString(currentOrder.createdAt)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // QR Code Integration Card
              if (currentOrder.packetQr != null && currentOrder.packetQr!.isNotEmpty)
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "Packet QR Code",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                        const SizedBox(height: 12),
                        // Mock QR code rendering
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyLight, width: 2),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.qr_code_2,
                            size: 130,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SelectableText(
                          currentOrder.packetQr!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Intake Scan / Pickup Verification Ready",
                          style: TextStyle(fontSize: 11, color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              const PickupOtpInfoBox(),
              const SizedBox(height: 30),

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
                    context.goOrderTimeline(currentOrder.id!);
                  },
                  child: const Text(
                    "Track Order",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    context.goHome();
                  },
                  child: const Text(
                    "Go to Home",
                    style: TextStyle(color: Color(0xff0D47A1), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
