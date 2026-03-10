import 'package:flutter/foundation.dart';
import '../../data/models/tracking_model.dart';
import '../../data/models/order_model.dart';
import '../../data/datasources/order_service.dart';
import 'package:clean_go/features/orders/domain/usecases/order_usecases.dart';
import 'package:clean_go/features/orders/data/repositories/order_repository_impl.dart';
import 'states/order_state.dart';

class OrderProvider with ChangeNotifier {
  final OrderUseCases _orderUseCases;

  OrderState _state = const OrderInitial();

  OrderProvider(this._orderUseCases);

  OrderState get state => _state;

  List<OrderModel> get activeOrders =>
      _state is OrderSuccess ? (_state as OrderSuccess).activeOrders : [];

  List<OrderModel> get pastOrders =>
      _state is OrderSuccess ? (_state as OrderSuccess).pastOrders : [];

  OrderModel? get currentOrder =>
      _state is OrderSuccess ? (_state as OrderSuccess).currentOrder : null;

  TrackingModel? get currentTracking =>
      _state is OrderSuccess ? (_state as OrderSuccess).currentTracking : null;

  bool get isLoading => _state is OrderLoading;

  String? get error =>
      _state is OrderError ? (_state as OrderError).message : null;

  void _emitState(OrderState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> loadActiveOrders() async {
    _emitState(const OrderLoading());

    try {
      final orders = await _orderUseCases.getActiveOrders();
      final currentPastOrders = pastOrders;
      _emitState(
        OrderSuccess(
          activeOrders: orders,
          pastOrders: currentPastOrders,
          currentOrder: currentOrder,
          currentTracking: currentTracking,
        ),
      );
    } catch (e) {
      _emitState(OrderError(e.toString()));
    }
  }

  Future<void> loadPastOrders() async {
    _emitState(const OrderLoading());

    try {
      final orders = await _orderUseCases.getPastOrders();
      final currentActiveOrders = activeOrders;
      _emitState(
        OrderSuccess(
          activeOrders: currentActiveOrders,
          pastOrders: orders,
          currentOrder: currentOrder,
          currentTracking: currentTracking,
        ),
      );
    } catch (e) {
      _emitState(OrderError(e.toString()));
    }
  }

  Future<void> loadOrderDetails(String orderId) async {
    _emitState(const OrderLoading());

    try {
      final order = await _orderUseCases.getOrderById(orderId);
      final tracking = await _orderUseCases.getOrderTracking(orderId);
      _emitState(
        OrderSuccess(
          activeOrders: activeOrders,
          pastOrders: pastOrders,
          currentOrder: order,
          currentTracking: tracking,
        ),
      );
    } catch (e) {
      _emitState(OrderError(e.toString()));
    }
  }
}
