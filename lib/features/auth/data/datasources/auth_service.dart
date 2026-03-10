import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../orders/data/models/user_model.dart';
import '../../../../core/network/api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);
  static const String tokenKey = "auth_token";
  static const String userKey = "user_data";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Validate phone number
  bool isValidPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(' ', '');

    if (phoneNumber.length != 10) return false;
    if (!RegExp(r'^[6-9]').hasMatch(phoneNumber)) return false;
    if (!RegExp(r'^\d+$').hasMatch(phoneNumber)) return false;

    return true;
  }

  // Send OTP
  Future<String> sendOtp(String phoneNumber) async {
    try {
      print("DEBUG: Starting OTP verification for +91$phoneNumber");

      /// TEMPORARY BYPASS FOR TESTING - Remove this when Firebase is configured
      await Future.delayed(const Duration(seconds: 2));
      print("DEBUG: Bypass - Returning test verification ID");
      return "test-verification-id";

      // Actual Firebase implementation (uncomment when Firebase is configured):
      // await _auth.verifyPhoneNumber(
      //   phoneNumber: '+91$phoneNumber',
      //   verificationCompleted: (PhoneAuthCredential credential) {},
      //   verificationFailed: (FirebaseAuthException e) {
      //     throw e;
      //   },
      //   codeSent: (String verificationId, int? resendToken) {
      //     return verificationId;
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      // );
    } catch (e) {
      print("DEBUG: OTP sending failed: $e");
      rethrow;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String verificationId, String otp) async {
    try {
      print("DEBUG: Verifying OTP with verificationId: $verificationId");

      /// TEMPORARY BYPASS FOR TESTING - Remove this when Firebase is configured
      await Future.delayed(const Duration(seconds: 1));
      print("DEBUG: Bypass - OTP verification successful");

      // Save dummy token for now
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(tokenKey, "dummy_token");

      return true;

      // Actual Firebase implementation (uncomment when Firebase is configured):
      // PhoneAuthCredential credential = PhoneAuthProvider.credential(
      //   verificationId: verificationId,
      //   smsCode: otp,
      // );
      //
      // await _auth.signInWithCredential(credential);
      // return true;
    } catch (e) {
      print("DEBUG: OTP verification failed: $e");
      rethrow;
    }
  }

  // Verify OTP (legacy method for backward compatibility)
  Future<bool> verifyOtpLegacy(String phoneNumber, String otp) async {
    await Future.delayed(const Duration(seconds: 1));

    // Save dummy token for now
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, "dummy_token");

    return true;
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(userKey);

    if (userJson == null) return null;

    return UserModel.fromJson(jsonDecode(userJson));
  }

  // Update profile
  Future<bool> updateProfile(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(userKey, jsonEncode(user.toJson()));

    return true;
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Check login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(tokenKey);
  }
}
