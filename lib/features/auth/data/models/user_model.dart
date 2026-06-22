class UserModel {
  final String id;
  final String phone;
  final String name;
  final String role;
  final String subscriptionStatus;

  UserModel({
    required this.id,
    required this.phone,
    required this.name,
    required this.role,
    required this.subscriptionStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      subscriptionStatus: json['subscriptionStatus'] as String? ?? 'Inactive',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'role': role,
      'subscriptionStatus': subscriptionStatus,
    };
  }
}
