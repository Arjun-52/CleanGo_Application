class UpdateProcessingStageResponse {
  final String status;
  final UpdateProcessingStageData data;

  UpdateProcessingStageResponse({required this.status, required this.data});

  factory UpdateProcessingStageResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProcessingStageResponse(
      status: json['status'] as String,
      data: UpdateProcessingStageData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class UpdateProcessingStageData {
  final String id;
  final String orderRef;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  UpdateProcessingStageData({
    required this.id,
    required this.orderRef,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdateProcessingStageData.fromJson(Map<String, dynamic> json) {
    return UpdateProcessingStageData(
      id: json['id'] as String,
      orderRef: json['orderRef'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
