import '../../../data/models/update_processing_stage_response.dart';

abstract class OrderStageState {
  const OrderStageState();
}

class OrderStageInitial extends OrderStageState {
  const OrderStageInitial();
}

class OrderStageLoading extends OrderStageState {
  const OrderStageLoading();
}

class OrderStageSuccess extends OrderStageState {
  final UpdateProcessingStageResponse response;
  const OrderStageSuccess(this.response);
}

class OrderStageError extends OrderStageState {
  final String message;
  const OrderStageError(this.message);
}
