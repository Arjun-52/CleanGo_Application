import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? icon;
  final double? price;
  final String? unit;
  final bool isAvailable;

  const ServiceEntity({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.price,
    this.unit,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        icon,
        price,
        unit,
        isAvailable,
      ];
}
