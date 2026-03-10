import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String? label;
  final String? fullAddress;
  final String? landmark;
  final String? city;
  final String? state;
  final String? pincode;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  const AddressEntity({
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

  @override
  List<Object?> get props => [
        id,
        label,
        fullAddress,
        landmark,
        city,
        state,
        pincode,
        latitude,
        longitude,
        isDefault,
      ];
}
