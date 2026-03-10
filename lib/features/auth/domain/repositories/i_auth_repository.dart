import 'dart:convert';
import 'package:clean_go/features/orders/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthRepository {
  bool isValidPhoneNumber(String phoneNumber);
  Future<String> sendOtp(String phoneNumber);
  Future<bool> verifyOtp(String verificationId, String otp);
  Future<bool> verifyOtpLegacy(String phoneNumber, String otp);
  Future<UserModel?> getCurrentUser();
  Future<bool> updateProfile(UserModel user);
  Future<void> logout();
  Future<bool> isLoggedIn();
}
