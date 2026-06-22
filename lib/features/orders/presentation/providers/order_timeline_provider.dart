import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../domain/usecases/order_usecases.dart';
import 'states/order_timeline_state.dart';

class OrderTimelineProvider with ChangeNotifier {
  final OrderUseCases _orderUseCases;

  OrderTimelineState _state = const OrderTimelineInitial();
  String? _lastOrderId;

  OrderTimelineProvider(this._orderUseCases);

  OrderTimelineState get state => _state;
  bool get isLoading => _state is OrderTimelineLoading;
  String? get error => _state is OrderTimelineError ? (_state as OrderTimelineError).message : null;

  void reset() {
    _state = const OrderTimelineInitial();
    _lastOrderId = null;
    notifyListeners();
  }

  Future<void> getOrderTimeline(String orderId) async {
    _state = const OrderTimelineLoading();
    notifyListeners();

    try {
      final orderTimeline = await _orderUseCases.getOrderTimeline(orderId);
      _state = OrderTimelineSuccess(orderTimeline);
      _lastOrderId = orderId;
      notifyListeners();
    } catch (e) {
      String errorMessage = "Failed to fetch order timeline";
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data is Map) {
          final data = e.response?.data as Map;
          if (data['message'] != null) {
            errorMessage = data['message'].toString();
          }
        } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
          errorMessage = "Network Timeout. Please try again.";
        } else {
          errorMessage = e.message ?? "Network failure";
        }
      } else {
        errorMessage = e.toString().replaceAll("Exception: ", "");
      }

      _state = OrderTimelineError(errorMessage);
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    if (_lastOrderId != null) {
      await getOrderTimeline(_lastOrderId!);
    }
  }
}
