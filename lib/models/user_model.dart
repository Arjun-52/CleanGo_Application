class UserModel {
  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? profileImage;
  final DateTime? createdAt;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.profileImage,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      profileImage: json['profile_image'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'profile_image': profileImage,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? profileImage,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
