import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'states/auth_state.dart';

class AuthProvider with ChangeNotifier {
  final AuthUseCases _authUseCases;

  AuthState _authState = const AuthInitial();
  OtpState _otpState = const OtpState(secondsRemaining: 30, canResend: false);
  Timer? _timer;

  AuthProvider(this._authUseCases);

  AuthState get authState => _authState;
  OtpState get otpState => _otpState;

  UserEntity? get user =>
      _authState is AuthSuccess ? (_authState as AuthSuccess).user : null;

  bool get isLoading => _authState is AuthLoading;

  String? get error =>
      _authState is AuthError ? (_authState as AuthError).message : null;

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

  /// Send OTP
  Future<String?> sendOtp(String phoneNumber) async {
    if (isLoading) return null;

    if (!_authUseCases.isValidPhoneNumber(phoneNumber)) {
      _emitAuthState(AuthError('Enter valid number'));
      return null;
    }

    _emitAuthState(const AuthLoading());

    try {
      String verificationId = await _authUseCases
          .sendOtp(phoneNumber)
          .timeout(const Duration(seconds: 10));

      _emitAuthState(const AuthInitial());
      return verificationId;
    } catch (e) {
      _emitAuthState(AuthError('Failed to send OTP. Please try again.'));
      return null;
    }
  }

  /// Verify OTP
  Future<bool> verifyOtp(String verificationId, String otp) async {
    if (otp.length != 6) {
      _emitAuthState(AuthError("Enter 6 digit OTP"));
      return false;
    }

    _emitAuthState(const AuthLoading());

    try {
      /// Prevent infinite loading
      bool result = await _authUseCases
          .verifyOtp(verificationId, otp)
          .timeout(const Duration(seconds: 10));

      if (result) {
        _emitAuthState(
          AuthSuccess(
            UserEntity(id: "1", name: "Demo User", phone: "9347830977"),
          ),
        );
      } else {
        _emitAuthState(AuthError("Invalid OTP"));
      }

      return result;
    } on TimeoutException {
      _emitAuthState(AuthError("Request timeout. Try again."));
      return false;
    } catch (e) {
      _emitAuthState(AuthError('OTP verification failed.'));
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
    if (_authState is AuthError) {
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
