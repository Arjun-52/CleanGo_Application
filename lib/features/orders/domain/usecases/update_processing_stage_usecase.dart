import '../../data/models/update_processing_stage_response.dart';
import '../repositories/i_order_repository.dart';

class UpdateProcessingStageUseCase {
  final IOrderRepository repository;

  UpdateProcessingStageUseCase(this.repository);

  Future<UpdateProcessingStageResponse> call({
    required String orderId,
    required String status,
  }) async {
    return await repository.updateProcessingStage(orderId: orderId, status: status);
  }
}
