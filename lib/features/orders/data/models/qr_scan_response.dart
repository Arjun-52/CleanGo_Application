import 'qr_scan_order_model.dart';

class QrScanResponse {
  final String status;
  final String message;
  final QrScanOrderModel? data;

  QrScanResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory QrScanResponse.fromJson(Map<String, dynamic> json) {
    return QrScanResponse(
      status: json['status'] as String? ?? 'error',
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? QrScanOrderModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}
