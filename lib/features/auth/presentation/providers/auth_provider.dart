import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../orders/data/models/user_model.dart';
import '../../data/datasources/auth_service.dart';

import 'package:clean_go/features/auth/domain/usecases/auth_usecases.dart';
import 'package:clean_go/features/auth/data/repositories/auth_repository_impl.dart';

class AuthProvider with ChangeNotifier {
  final AuthUseCases _authUseCases;

  AuthProvider(this._authUseCases);

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  // OTP specific state
  int _secondsRemaining = 30;
  bool _canResend = false;
  Timer? _timer;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  // OTP getters
  int get secondsRemaining => _secondsRemaining;
  bool get canResend => _canResend;

  /// Send OTP and return verification ID
  Future<String?> sendOtp(String phoneNumber) async {
    if (_isLoading) return null;

    print("DEBUG: Phone number entered: $phoneNumber");

    // Validate phone number
    if (!_authUseCases.isValidPhoneNumber(phoneNumber)) {
      print("DEBUG: Invalid phone number");
      _error = 'Enter valid number';
      notifyListeners();
      return null;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      String verificationId = await _authUseCases.sendOtp(phoneNumber);
      print("DEBUG: OTP sent successfully");
      return verificationId;
    } catch (e) {
      print("DEBUG: OTP sending failed: $e");
      _error = 'Failed to send OTP. Please try again.';
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Verify OTP
  Future<bool> verifyOtp(String verificationId, String otp) async {
    if (otp.length != 6) {
      _error = "Enter 6 digit OTP";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool result = await _authUseCases.verifyOtp(verificationId, otp);
      print("DEBUG: OTP verification successful");
      return result;
    } catch (e) {
      print("DEBUG: OTP verification failed: $e");
      _error = 'Invalid OTP. Please try again.';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Start OTP resend timer
  void startOtpTimer() {
    _secondsRemaining = 30;
    _canResend = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        timer.cancel();
        _canResend = true;
        notifyListeners();
      }
    });
  }

  /// Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Dispose resources
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> logout() async {
    await _authUseCases.logout();
    _user = null;
    notifyListeners();
  }
}
