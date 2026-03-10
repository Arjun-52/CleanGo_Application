import '../../../orders/data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/auth_service.dart';

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
  Future<UserEntity?> getCurrentUser() async {
    final user = await remoteDataSource.getCurrentUser();
    return user?.toEntity();
  }

  @override
  Future<bool> updateProfile(UserEntity user) {
    final userModel = UserModel.fromEntity(user);
    return remoteDataSource.updateProfile(userModel);
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
