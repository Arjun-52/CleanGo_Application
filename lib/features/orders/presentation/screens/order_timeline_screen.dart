import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_timeline_provider.dart';
import '../providers/states/order_timeline_state.dart';
import '../../data/models/order_timeline_model.dart';

class OrderTimelineScreen extends StatefulWidget {
  final String orderId;

  const OrderTimelineScreen({super.key, required this.orderId});

  @override
  State<OrderTimelineScreen> createState() => _OrderTimelineScreenState();
}

class _OrderTimelineScreenState extends State<OrderTimelineScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderTimelineProvider>(context, listen: false).getOrderTimeline(widget.orderId);
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "--";
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    final hour = (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12).toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? "PM" : "AM";
    return "$day $month $year, $hour:$minute $period";
  }

  Color _getStatusColor(String? status) {
    if (status == null) return AppColors.grey;
    final s = status.toLowerCase();
    if (s.contains('pending')) return AppColors.info;
    if (s.contains('progress') || s.contains('processing')) return AppColors.warning;
    if (s.contains('delivered') || s.contains('complete') || s.contains('success')) return AppColors.success;
    if (s.contains('cancel') || s.contains('fail')) return AppColors.error;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text(
          "Order Timeline",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<OrderTimelineProvider>(
        builder: (context, provider, child) {
          final state = provider.state;

          if (state is OrderTimelineLoading || state is OrderTimelineInitial) {
            return _buildSkeletonLoader();
          }

          if (state is OrderTimelineError) {
            return _buildErrorState(state.message, provider);
          }

          if (state is OrderTimelineSuccess) {
            final order = state.orderTimeline;
            return RefreshIndicator(
              onRefresh: () => provider.refresh(),
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderSummaryCard(order),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "Tracking Activity",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1F2A44),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTimelineSection(order),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Opacity(
          opacity: 0.35 + (_fadeController.value * 0.45),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Card Skeleton
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 24),
                // Heading Skeleton
                Container(
                  height: 20,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),
                // Timeline Skeletons
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message, OrderTimelineProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1F2A44),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 160,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => provider.getOrderTimeline(widget.orderId),
                child: const Text(
                  "Retry",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard(OrderTimelineModel order) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderRef ?? "No Reference",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1f2a44),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(order.createdAt),
                      style: const TextStyle(color: AppColors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.status ?? "Pending",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(order.status),
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 28),
            _buildSummaryRow(Icons.person_outline, "Customer", order.customerName ?? "--"),
            const SizedBox(height: 10),
            _buildSummaryRow(Icons.local_laundry_service_outlined, "Service", "${order.serviceType} (${order.serviceMode})"),
            const SizedBox(height: 10),
            _buildSummaryRow(Icons.layers_outlined, "Items Count", "${order.itemsCount ?? 0} items"),
            const SizedBox(height: 10),
            _buildSummaryRow(
              Icons.timer_outlined,
              "SLA Status",
              order.slaStatus ?? "--",
              valueColor: (order.slaStatus?.toLowerCase() == 'on track') ? AppColors.success : AppColors.warning,
            ),
            const SizedBox(height: 10),
            _buildSummaryRow(Icons.currency_rupee, "Price", "₹${order.price?.toStringAsFixed(0) ?? '0'}"),
            if (order.packetQr != null && order.packetQr!.isNotEmpty) ...[
              const Divider(height: 28),
              Row(
                children: [
                  const Icon(Icons.qr_code_2, size: 36, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Packet QR",
                          style: TextStyle(fontSize: 11, color: AppColors.grey, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        SelectableText(
                          order.packetQr!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryLight),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.grey, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: valueColor ?? const Color(0xff1f2a44),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineSection(OrderTimelineModel order) {
    final qrEvents = order.qrEvents;

    if (qrEvents == null || qrEvents.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 48, color: AppColors.grey.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text(
              "No tracking events found yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff1F2A44),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Scan events will appear here once recorded.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: qrEvents.length,
        itemBuilder: (context, index) {
          final event = qrEvents[index];
          final isLast = index == qrEvents.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: AppColors.primary.withOpacity(0.3),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              event.scannedByRole ?? "Staff Scan",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff1f2a44),
                              ),
                            ),
                            Text(
                              _formatDateTime(event.createdAt),
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.location ?? "Unknown Location",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
