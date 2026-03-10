// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  unit: json['unit'] as String?,
  isAvailable: json['is_available'] as bool? ?? true,
);

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'price': instance.price,
      'unit': instance.unit,
      'is_available': instance.isAvailable,
    };
