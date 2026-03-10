import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? profileImage;
  final DateTime? createdAt;

  const UserEntity({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.profileImage,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        profileImage,
        createdAt,
      ];
}
