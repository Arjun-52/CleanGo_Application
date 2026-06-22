import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../../data/models/qr_scan_order_model.dart';
import '../providers/qr_scan_provider.dart';
import '../providers/states/qr_scan_state.dart';
import '../../../../routes/app_router.dart';
import '../providers/order_stage_provider.dart';
import '../providers/states/order_stage_state.dart';

class QrOrderDetailsScreen extends StatelessWidget {
  final QrScanOrderModel order;

  const QrOrderDetailsScreen({super.key, required this.order});

  void _showUpdateStageBottomSheet(BuildContext context, String orderId, QrScanProvider qrProvider) {
    final stages = [
      "Wash",
      "Iron",
      "Dry Clean",
      "QC",
      "Packed",
      "Ready for Delivery",
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Update Processing Stage",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Select the current processing status stage for this order:",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Consumer<OrderStageProvider>(
                  builder: (context, stageProvider, child) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: stages.map((stage) {
                        final isUpdating = stageProvider.isLoading;
                        return ChoiceChip(
                          label: Text(stage),
                          selected: false,
                          onSelected: isUpdating
                              ? null
                              : (_) async {
                                  final success = await stageProvider.updateStage(
                                    orderId: orderId,
                                    status: stage,
                                  );
                                  if (context.mounted) {
                                    if (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Processing stage successfully updated to '$stage'"),
                                          backgroundColor: AppColors.success,
                                        ),
                                      );
                                      Navigator.pop(context);
                                      // Refresh order details to update status in the screen
                                      if (order.packetQr != null) {
                                        qrProvider.scanQrCode(order.packetQr!);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(stageProvider.error ?? "Failed to update stage"),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                    }
                                  }
                                },
                          labelStyle: TextStyle(
                            color: isUpdating ? Colors.grey : AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.white,
                          selectedColor: AppColors.primary.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

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
                  const SizedBox(height: 16),

                  // Actions Section
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              context.goOrderTimeline(currentOrder.id ?? 'dc943695-1223-46d1-9234-f385d42868e0');
                            },
                            icon: const Icon(Icons.timeline),
                            label: const Text("Timeline", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              _showUpdateStageBottomSheet(context, currentOrder.id ?? "", provider);
                            },
                            icon: const Icon(Icons.edit_note),
                            label: const Text("Update Stage", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // QC Evidence Upload Section
                  _buildSectionTitle("QC Evidence & Upload"),
                  const SizedBox(height: 8),
                  QcEvidenceUploadSection(orderId: currentOrder.orderRef ?? currentOrder.id ?? ""),
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

class QcEvidenceUploadSection extends StatefulWidget {
  final String orderId;

  const QcEvidenceUploadSection({super.key, required this.orderId});

  @override
  State<QcEvidenceUploadSection> createState() => _QcEvidenceUploadSectionState();
}

class _QcEvidenceUploadSectionState extends State<QcEvidenceUploadSection> {
  final TextEditingController _captionController = TextEditingController();
  bool _hasDamage = false;
  bool _isSigned = false;
  String? _uploadedImageUrl;
  bool _isLocalFileUploading = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

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

  Future<void> _handleImageSelection(BuildContext context, String source) async {
    final provider = context.read<QrScanProvider>();
    setState(() {
      _isLocalFileUploading = true;
      _uploadedImageUrl = null;
    });

    await provider.simulateImageSelection(source);

    setState(() {
      _isLocalFileUploading = false;
      _uploadedImageUrl = "https://images.unsplash.com/photo-1545156521-77bd85671d30"; // Mock laundry packet photo
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mock image selected and uploaded to cloud storage successfully!")),
      );
    }
  }

  Future<void> _handleUpload(BuildContext context) async {
    if (_uploadedImageUrl == null || _uploadedImageUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Validation Error: Please capture or select an image first"),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (widget.orderId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Validation Error: Order ID is required"),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final provider = context.read<QrScanProvider>();
    final success = await provider.uploadMediaEvidence(
      orderId: widget.orderId,
      type: "photo",
      url: _uploadedImageUrl!,
      caption: _captionController.text.trim().isEmpty ? null : _captionController.text.trim(),
      hasDamage: _hasDamage,
      isSigned: _isSigned,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Media evidence uploaded successfully!"),
          backgroundColor: AppColors.success,
        ),
      );
      // Clear form
      setState(() {
        _captionController.clear();
        _hasDamage = false;
        _isSigned = false;
        _uploadedImageUrl = null;
      });
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.uploadState is UploadEvidenceError
              ? (provider.uploadState as UploadEvidenceError).message
              : "Failed to upload evidence"),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QrScanProvider>();
    final isUploading = provider.uploadState is UploadEvidenceLoading || _isLocalFileUploading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upload form Card
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload New QC Evidence",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                const SizedBox(height: 16),

                // Capture/Gallery Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: isUploading ? null : () => _handleImageSelection(context, "camera"),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Capture Photo"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          foregroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: isUploading ? null : () => _handleImageSelection(context, "gallery"),
                        icon: const Icon(Icons.photo_library),
                        label: const Text("From Gallery"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Image Upload Progress
                if (_isLocalFileUploading) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Uploading to storage...",
                        style: TextStyle(fontSize: 12, color: AppColors.grey),
                      ),
                      Text(
                        "${(provider.imageUploadProgress * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: provider.imageUploadProgress,
                    backgroundColor: AppColors.greyLight,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                ],

                // Image Preview
                if (_uploadedImageUrl != null) ...[
                  const Text(
                    "Image Preview:",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.greyDark),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.greyLight),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _uploadedImageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: isUploading
                                  ? null
                                  : () => setState(() => _uploadedImageUrl = null),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Caption Field
                TextField(
                  controller: _captionController,
                  enabled: !isUploading,
                  decoration: InputDecoration(
                    labelText: "Caption / Notes",
                    hintText: "e.g. Package picked up successfully",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 16),

                // Damage Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.report_problem_outlined, color: AppColors.warning),
                        SizedBox(width: 8),
                        Text("Has Damage / Issues", style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Switch(
                      value: _hasDamage,
                      activeColor: AppColors.primary,
                      onChanged: isUploading ? null : (val) => setState(() => _hasDamage = val),
                    ),
                  ],
                ),

                // Signature Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.draw_outlined, color: AppColors.primaryLight),
                        SizedBox(width: 8),
                        Text("Is Signed", style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Switch(
                      value: _isSigned,
                      activeColor: AppColors.primary,
                      onChanged: isUploading ? null : (val) => setState(() => _isSigned = val),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: isUploading ? null : () => _handleUpload(context),
                    child: isUploading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            "Upload Evidence",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                  ),
                ),

                // Error Message if any
                if (provider.uploadState is UploadEvidenceError) ...[
                  const SizedBox(height: 12),
                  Text(
                    (provider.uploadState as UploadEvidenceError).message,
                    style: const TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ],
            ),
          ),
        ),

        // Evidence History Card
        if (provider.uploadedEvidences.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Text(
            "Uploaded Evidence List",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          ...provider.uploadedEvidences.map((evidence) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image thumbnail
                    if (evidence.url != null && evidence.url!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          evidence.url!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(width: 12),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Evidence Type: ${evidence.type ?? 'Photo'}",
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Caption: ${evidence.caption ?? 'No caption provided'}",
                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Damage Status: ${evidence.hasDamage == true ? 'Has Damage' : 'No Damage'}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: evidence.hasDamage == true ? AppColors.error : AppColors.success,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Signature Status: ${evidence.isSigned == true ? 'Signed' : 'Not Signed'}",
                            style: const TextStyle(fontSize: 11, color: AppColors.greyDark),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Upload Time: ${_formatDateTimeString(evidence.uploadedAt ?? DateTime.now())}",
                            style: const TextStyle(fontSize: 10, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ],
    );
  }
}
