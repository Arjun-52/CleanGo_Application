class ServiceModel {
  final String? id;
  final String? name;
  final String? description;
  final String? icon;
  final double? price;
  final String? unit;
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

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      price: json['price']?.toDouble(),
      unit: json['unit'],
      isAvailable: json['is_available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'price': price,
      'unit': unit,
      'is_available': isAvailable,
    };
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
