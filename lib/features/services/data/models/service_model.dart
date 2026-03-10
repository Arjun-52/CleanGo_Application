import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/service_entity.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'is_available')
  final bool isAvailable;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.price,
    this.unit,
    this.isAvailable = true,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  // Mapping to domain entity
  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      name: name,
      description: description,
      icon: icon,
      price: price,
      unit: unit,
      isAvailable: isAvailable,
    );
  }

  // Mapping from domain entity
  factory ServiceModel.fromEntity(ServiceEntity entity) {
    return ServiceModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      icon: entity.icon,
      price: entity.price,
      unit: entity.unit,
      isAvailable: entity.isAvailable,
    );
  }

  ServiceModel copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    double? price,
    String? unit,
    bool? isAvailable,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
