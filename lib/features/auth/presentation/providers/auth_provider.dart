import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'states/auth_state.dart';

class AuthProvider with ChangeNotifier {
  final AuthUseCases _authUseCases;

  AuthState _authState = const AuthInitial();
  OtpState _otpState = const OtpState(secondsRemaining: 30, canResend: false);
  Timer? _timer;

  AuthProvider(this._authUseCases) {
    checkLoginStatus();
  }

  AuthState get authState => _authState;
  OtpState get otpState => _otpState;

  UserEntity? get user =>
      _authState is AuthSuccess ? (_authState as AuthSuccess).user : null;

  bool get isLoading =>
      _authState is AuthLoading ||
      _authState is SendOtpLoading ||
      _authState is VerifyOtpLoading;

  String? get error {
    if (_authState is AuthError) return (_authState as AuthError).message;
    if (_authState is SendOtpError) return (_authState as SendOtpError).message;
    if (_authState is VerifyOtpError) return (_authState as VerifyOtpError).message;
    return null;
  }

  bool get isLoggedIn => user != null;

  int get secondsRemaining => _otpState.secondsRemaining;
  bool get canResend => _otpState.canResend;

  void _emitAuthState(AuthState newState) {
    _authState = newState;
    notifyListeners();
  }

  void _emitOtpState(OtpState newState) {
    _otpState = newState;
    notifyListeners();
  }

  /// Check Login Status on App Start
  Future<void> checkLoginStatus() async {
    try {
      final loggedIn = await _authUseCases.isLoggedIn();
      if (loggedIn) {
        final currentUser = await _authUseCases.getCurrentUser();
        if (currentUser != null) {
          _emitAuthState(AuthSuccess(currentUser));
        }
      }
    } catch (_) {}
  }

  /// Send OTP
  Future<String?> sendOtp(String phoneNumber) async {
    if (isLoading) return null;

    if (!_authUseCases.isValidPhoneNumber(phoneNumber)) {
      _emitAuthState(const SendOtpError('Enter valid number'));
      return null;
    }

    _emitAuthState(const SendOtpLoading());

    try {
      final formattedPhone = phoneNumber.startsWith('+') ? phoneNumber : '+91$phoneNumber';
      final response = await _authUseCases
          .sendOtpCustomer(formattedPhone)
          .timeout(const Duration(seconds: 15));

      _emitAuthState(SendOtpSuccess(phone: formattedPhone, devOtp: response.devOtp));
      return formattedPhone;
    } catch (e) {
      String errMsg = 'Failed to send OTP. Please try again.';
      if (e is DioException) {
        final data = e.response?.data;
        if (data is Map && data['message'] != null) {
          errMsg = data['message'].toString();
        }
      }
      _emitAuthState(SendOtpError(errMsg));
      return null;
    }
  }

  /// Verify OTP
  Future<bool> verifyOtp(String phone, String otp) async {
    if (otp.length < 6) {
      _emitAuthState(const VerifyOtpError("Enter 6 digit OTP"));
      return false;
    }

    _emitAuthState(const VerifyOtpLoading());

    try {
      final formattedPhone = phone.startsWith('+') ? phone : '+91$phone';
      final response = await _authUseCases
          .verifyOtpCustomer(phone: formattedPhone, otp: otp)
          .timeout(const Duration(seconds: 15));

      print("DEBUG: Verify OTP Response status: ${response.status}, message: ${response.message}, data: ${response.data}");

      if (response.data == null) {
        _emitAuthState(VerifyOtpError(response.message.isNotEmpty ? response.message : "Authentication failed"));
        return false;
      }

      final authData = response.data!;
      final userModel = authData.user;
      final prefs = await SharedPreferences.getInstance();

      // Store Authentication Data securely/persistently
      await prefs.setString("auth_token", authData.accessToken);
      await prefs.setString("accessToken", authData.accessToken);
      await prefs.setString("userId", userModel.id);
      await prefs.setString("phone", userModel.phone);
      await prefs.setString("userName", userModel.name);
      await prefs.setString("role", userModel.role);
      await prefs.setString("subscriptionStatus", userModel.subscriptionStatus);

      print("DEBUG: Saved token after login success: ${prefs.getString("auth_token")}");

      // Create a compatible user map for the existing getCurrentUser()
      final userMap = {
        'id': userModel.id,
        'name': userModel.name,
        'phone': userModel.phone,
        'role': userModel.role,
        'subscriptionStatus': userModel.subscriptionStatus,
      };
      await prefs.setString("user_data", jsonEncode(userMap));

      final userEntity = UserEntity(
        id: userModel.id,
        name: userModel.name,
        phone: userModel.phone,
      );

      _emitAuthState(AuthSuccess(userEntity));
      _emitAuthState(VerifyOtpSuccess(accessToken: authData.accessToken));
      return true;
    } on TimeoutException {
      _emitAuthState(const VerifyOtpError("Request timeout. Try again."));
      return false;
    } catch (e) {
      String errMsg = 'OTP verification failed.';
      if (e is DioException) {
        final data = e.response?.data;
        print("DEBUG: Verify OTP Error Response payload: $data");
        if (data is Map) {
          final message = data['message']?.toString() ?? data['error']?.toString();
          if (message != null && message.isNotEmpty) {
            final lowerMsg = message.toLowerCase();
            if (lowerMsg.contains('invalid') || lowerMsg.contains('wrong')) {
              errMsg = 'Invalid OTP';
            } else if (lowerMsg.contains('expire')) {
              errMsg = 'OTP expired';
            } else {
              errMsg = message;
            }
          }
        }
      }
      _emitAuthState(VerifyOtpError(errMsg));
      return false;
    }
  }

  /// OTP Timer
  void startOtpTimer() {
    _emitOtpState(const OtpState(secondsRemaining: 30, canResend: false));

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int current = _otpState.secondsRemaining;

      if (current > 0) {
        _emitOtpState(
          OtpState(secondsRemaining: current - 1, canResend: false),
        );
      } else {
        timer.cancel();
        _emitOtpState(const OtpState(secondsRemaining: 0, canResend: true));
      }
    });
  }

  /// Clear errors
  void clearError() {
    if (_authState is AuthError || _authState is SendOtpError || _authState is VerifyOtpError) {
      _emitAuthState(const AuthInitial());
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _authUseCases.logout();
    } catch (_) {}

    _emitAuthState(const AuthInitial());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
