class UpdateProcessingStageRequest {
  final String status;

  UpdateProcessingStageRequest({required this.status});

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
