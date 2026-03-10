class TrackingModel {
  final String? orderId;
  final List<TrackingStep>? steps;
  final String? currentStatus;
  final DateTime? estimatedDelivery;

  TrackingModel({
    this.orderId,
    this.steps,
    this.currentStatus,
    this.estimatedDelivery,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      orderId: json['order_id'],
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map((e) => TrackingStep.fromJson(e))
              .toList()
          : null,
      currentStatus: json['current_status'],
      estimatedDelivery: json['estimated_delivery'] != null
          ? DateTime.parse(json['estimated_delivery'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'steps': steps?.map((e) => e.toJson()).toList(),
      'current_status': currentStatus,
      'estimated_delivery': estimatedDelivery?.toIso8601String(),
    };
  }
}

class TrackingStep {
  final String? title;
  final String? description;
  final DateTime? timestamp;
  final bool isCompleted;
  final bool isCurrent;

  TrackingStep({
    this.title,
    this.description,
    this.timestamp,
    this.isCompleted = false,
    this.isCurrent = false,
  });

  factory TrackingStep.fromJson(Map<String, dynamic> json) {
    return TrackingStep(
      title: json['title'],
      description: json['description'],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : null,
      isCompleted: json['is_completed'] ?? false,
      isCurrent: json['is_current'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp?.toIso8601String(),
      'is_completed': isCompleted,
      'is_current': isCurrent,
    };
  }
}
