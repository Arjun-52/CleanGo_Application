import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../domain/usecases/update_processing_stage_usecase.dart';
import 'states/order_stage_state.dart';

class OrderStageProvider with ChangeNotifier {
  final UpdateProcessingStageUseCase _updateProcessingStageUseCase;

  OrderStageState _state = const OrderStageInitial();

  OrderStageProvider(this._updateProcessingStageUseCase);

  OrderStageState get state => _state;
  bool get isLoading => _state is OrderStageLoading;
  String? get error => _state is OrderStageError ? (_state as OrderStageError).message : null;

  void reset() {
    _state = const OrderStageInitial();
    notifyListeners();
  }

  Future<bool> updateStage({
    required String orderId,
    required String status,
  }) async {
    _state = const OrderStageLoading();
    notifyListeners();

    try {
      final response = await _updateProcessingStageUseCase(orderId: orderId, status: status);
      _state = OrderStageSuccess(response);
      notifyListeners();
      return true;
    } catch (e) {
      String errorMessage = "Failed to update processing stage";
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data is Map) {
          final data = e.response?.data as Map;
          if (data['message'] != null) {
            errorMessage = data['message'].toString();
          }
        } else {
          errorMessage = e.message ?? "Network failure";
        }
      } else {
        errorMessage = e.toString().replaceAll("Exception: ", "");
      }
      _state = OrderStageError(errorMessage);
      notifyListeners();
      return false;
    }
  }
}
