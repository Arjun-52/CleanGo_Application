import 'dart:convert';
import 'package:clean_go/features/orders/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_go/features/auth/domain/repositories/i_auth_repository.dart';

class AuthUseCases {
  final IAuthRepository repository;

  AuthUseCases(this.repository);

  bool isValidPhoneNumber(String phoneNumber) {
    return repository.isValidPhoneNumber(phoneNumber);
  }

  Future<String> sendOtp(String phoneNumber) {
    return repository.sendOtp(phoneNumber);
  }

  Future<bool> verifyOtp(String verificationId, String otp) {
    return repository.verifyOtp(verificationId, otp);
  }

  Future<bool> verifyOtpLegacy(String phoneNumber, String otp) {
    return repository.verifyOtpLegacy(phoneNumber, otp);
  }

  Future<UserModel?> getCurrentUser() {
    return repository.getCurrentUser();
  }

  Future<bool> updateProfile(UserModel user) {
    return repository.updateProfile(user);
  }

  Future<void> logout() {
    return repository.logout();
  }

  Future<bool> isLoggedIn() {
    return repository.isLoggedIn();
  }

}
