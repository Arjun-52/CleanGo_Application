import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user_model.dart';

class AuthService {
  static const String tokenKey = "auth_token";
  static const String userKey = "user_data";

  // Send OTP
  Future<bool> sendOtp(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // Verify OTP
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
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
