class SendOtpResponse {
  final String status;
  final String message;
  final String? devOtp;

  SendOtpResponse({
    required this.status,
    required this.message,
    this.devOtp,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      devOtp: json['devOtp']?.toString(),
    );
  }
}
