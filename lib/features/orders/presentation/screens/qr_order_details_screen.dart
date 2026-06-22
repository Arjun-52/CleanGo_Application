import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../../data/models/qr_scan_order_model.dart';
import '../providers/qr_scan_provider.dart';
import '../providers/states/qr_scan_state.dart';

class QrOrderDetailsScreen extends StatelessWidget {
  final QrScanOrderModel order;

  const QrOrderDetailsScreen({super.key, required this.order});

  String _formatDateString(DateTime? dateTime) {
    if (dateTime == null) return "--";
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    return "$day $month $year";
  }

  Color _getSlaStatusColor(String? status) {
    if (status == null) return AppColors.grey;
    switch (status.toLowerCase()) {
      case 'at risk':
        return AppColors.error;
      case 'on track':
        return AppColors.success;
      case 'delayed':
        return AppColors.warning;
      default:
        return AppColors.grey;
    }
  }

  Color _getStatusColor(String? status) {
    if (status == null) return AppColors.grey;
    switch (status.toLowerCase()) {
      case 'wash':
      case 'in progress':
      case 'processing':
        return AppColors.info;
      case 'completed':
      case 'delivered':
        return AppColors.success;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Scanned Order Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<QrScanProvider>(
        builder: (context, provider, child) {
          // Determine if we should show data from the provider (if refreshed) or the constructor
          final currentOrder = provider.state is QrScanSuccess
              ? (provider.state as QrScanSuccess).orderDetails
              : order;

          return RefreshIndicator(
            onRefresh: () async {
              if (currentOrder.packetQr != null) {
                await provider.scanQrCode(currentOrder.packetQr!);
              }
            },
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.state is QrScanLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),

                  if (provider.error != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        border: Border.all(color: AppColors.error.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: AppColors.error),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              provider.error!,
                              style: const TextStyle(color: AppColors.error, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Header card with Reference & Status
                  _buildHeaderCard(currentOrder),
                  const SizedBox(height: 16),

                  // Customer Details
                  _buildSectionTitle("Customer Information"),
                  const SizedBox(height: 8),
                  _buildCustomerCard(currentOrder),
                  const SizedBox(height: 16),

                  // Service Details
                  _buildSectionTitle("Service Details"),
                  const SizedBox(height: 8),
                  _buildServiceCard(currentOrder),
                  const SizedBox(height: 16),

                  // Packet & Logistics Information
                  _buildSectionTitle("Logistics & OTPs"),
                  const SizedBox(height: 8),
                  _buildLogisticsCard(currentOrder),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildHeaderCard(QrScanOrderModel o) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Reference",
                      style: TextStyle(color: AppColors.greyDark, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      o.orderRef ?? "--",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(o.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    o.status ?? "--",
                    style: TextStyle(
                      color: _getStatusColor(o.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderMiniDetail(
                  "SLA STATUS",
                  o.slaStatus ?? "--",
                  textColor: _getSlaStatusColor(o.slaStatus),
                ),
                _buildHeaderMiniDetail(
                  "SUBSCRIPTION",
                  (o.isSubscription == true) ? "Yes" : "No",
                ),
                _buildHeaderMiniDetail(
                  "PRICE",
                  o.price != null ? "₹${o.price!.toStringAsFixed(0)}" : "₹0",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderMiniDetail(String label, String value, {Color? textColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 10, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor ?? AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerCard(QrScanOrderModel o) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow(Icons.person_outline, "Customer Name", o.customerName ?? "--"),
            const Divider(height: 24),
            _buildDetailRow(Icons.store_mall_directory_outlined, "Store ID", o.storeId ?? "--"),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(QrScanOrderModel o) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow(Icons.dry_cleaning_outlined, "Service Type", o.serviceType ?? "--"),
            const Divider(height: 24),
            _buildDetailRow(Icons.bolt_outlined, "Service Mode", o.serviceMode ?? "--"),
            const Divider(height: 24),
            _buildDetailRow(Icons.shopping_bag_outlined, "Items Count", o.itemsCount?.toString() ?? "0"),
            const Divider(height: 24),
            _buildDetailRow(Icons.add_circle_outline_outlined, "Addons", o.addons ?? "--"),
          ],
        ),
      ),
    );
  }

  Widget _buildLogisticsCard(QrScanOrderModel o) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow(Icons.qr_code_outlined, "Packet QR", o.packetQr ?? "--"),
            const Divider(height: 24),
            _buildDetailRow(Icons.local_shipping_outlined, "Assigned Fleet ID", o.assignedFleetId ?? "--"),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildOtpBox("Pickup OTP", o.pickupOtp ?? "--"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildOtpBox("Delivery OTP", o.deliveryOtp ?? "--"),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildDetailRow(Icons.access_time, "Pickup Slot/Time",
                o.pickupSlot != null ? "${o.pickupSlot} (${_formatDateString(o.pickupTime)})" : "--"),
            const Divider(height: 24),
            _buildDetailRow(Icons.access_time_filled, "Delivery Slot/Time",
                o.deliverySlot != null ? "${o.deliverySlot} (${_formatDateString(o.deliveryTime)})" : "--"),
            const Divider(height: 24),
            _buildDetailRow(Icons.calendar_today_outlined, "Created Date", _formatDateString(o.createdAt)),
            const Divider(height: 24),
            _buildDetailRow(Icons.update_outlined, "Updated Date", _formatDateString(o.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppColors.greyDark, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primaryLight),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: AppColors.grey, fontSize: 11, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }
}
