import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

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

  Future<UserEntity?> getCurrentUser() {
    return repository.getCurrentUser();
  }

  Future<bool> updateProfile(UserEntity user) {
    return repository.updateProfile(user);
  }

  Future<void> logout() {
    return repository.logout();
  }

  Future<bool> isLoggedIn() {
    return repository.isLoggedIn();
  }
}
