import 'package:flutter/foundation.dart';
import 'package:clean_go/features/orders/data/models/user_model.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSuccess &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class OtpState {
  final int secondsRemaining;
  final bool canResend;

  const OtpState({required this.secondsRemaining, required this.canResend});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtpState &&
          runtimeType == other.runtimeType &&
          secondsRemaining == other.secondsRemaining &&
          canResend == other.canResend;

  @override
  int get hashCode => Object.hash(secondsRemaining, canResend);
}
