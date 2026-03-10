import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/address_entity.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'full_address')
  final String? fullAddress;
  @JsonKey(name: 'landmark')
  final String? landmark;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'pincode')
  final String? pincode;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  AddressModel({
    this.id,
    this.label,
    this.fullAddress,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  // Mapping to domain entity
  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      label: label,
      fullAddress: fullAddress,
      landmark: landmark,
      city: city,
      state: state,
      pincode: pincode,
      latitude: latitude,
      longitude: longitude,
      isDefault: isDefault,
    );
  }

  // Mapping from domain entity
  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      label: entity.label,
      fullAddress: entity.fullAddress,
      landmark: entity.landmark,
      city: entity.city,
      state: entity.state,
      pincode: entity.pincode,
      latitude: entity.latitude,
      longitude: entity.longitude,
      isDefault: entity.isDefault,
    );
  }

  AddressModel copyWith({
    String? id,
    String? label,
    String? fullAddress,
    String? landmark,
    String? city,
    String? state,
    String? pincode,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
