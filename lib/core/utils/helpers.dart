import 'package:flutter/material.dart';

class Helpers {
  // Show snackbar
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Show loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Format phone number
  static String formatPhoneNumber(String phone) {
    if (phone.length == 10) {
      return '+91 ${phone.substring(0, 5)} ${phone.substring(5)}';
    }
    return phone;
  }

  // Format currency
  static String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }

  // Format date
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Format time
  static String formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Validate phone number
  static bool isValidPhone(String phone) {
    return phone.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  // Validate OTP
  static bool isValidOtp(String otp) {
    return otp.length == 6 && RegExp(r'^[0-9]+$').hasMatch(otp);
  }
}
