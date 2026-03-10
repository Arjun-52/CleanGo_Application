import '../entities/user_entity.dart';

abstract class IAuthRepository {
  bool isValidPhoneNumber(String phoneNumber);
  Future<String> sendOtp(String phoneNumber);
  Future<bool> verifyOtp(String verificationId, String otp);
  Future<bool> verifyOtpLegacy(String phoneNumber, String otp);
  Future<UserEntity?> getCurrentUser();
  Future<bool> updateProfile(UserEntity user);
  Future<void> logout();
  Future<bool> isLoggedIn();
}
