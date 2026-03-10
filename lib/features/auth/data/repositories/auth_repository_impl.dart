import 'dart:convert';
import 'package:clean_go/features/orders/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_go/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:clean_go/features/auth/data/datasources/auth_service.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthService remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  bool isValidPhoneNumber(String phoneNumber) {
    return remoteDataSource.isValidPhoneNumber(phoneNumber);
  }

  @override
  Future<String> sendOtp(String phoneNumber) {
    return remoteDataSource.sendOtp(phoneNumber);
  }

  @override
  Future<bool> verifyOtp(String verificationId, String otp) {
    return remoteDataSource.verifyOtp(verificationId, otp);
  }

  @override
  Future<bool> verifyOtpLegacy(String phoneNumber, String otp) {
    return remoteDataSource.verifyOtpLegacy(phoneNumber, otp);
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<bool> updateProfile(UserModel user) {
    return remoteDataSource.updateProfile(user);
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<bool> isLoggedIn() {
    return remoteDataSource.isLoggedIn();
  }
}
