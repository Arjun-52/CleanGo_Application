import 'user_model.dart';

class AuthData {
  final String accessToken;
  final UserModel user;

  AuthData({
    required this.accessToken,
    required this.user,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['accessToken'] as String? ?? '',
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : UserModel(
              id: '',
              phone: '',
              name: '',
              role: '',
              subscriptionStatus: 'Inactive',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'user': user.toJson(),
    };
  }
}
