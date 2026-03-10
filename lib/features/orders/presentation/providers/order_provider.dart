import 'package:flutter/foundation.dart';
import '../../data/models/tracking_model.dart';
import '../../data/models/order_model.dart';

import '../../data/datasources/order_service.dart';

import 'package:clean_go/features/orders/domain/usecases/order_usecases.dart';
import 'package:clean_go/features/orders/data/repositories/order_repository_impl.dart';

class OrderProvider with ChangeNotifier {
  final OrderUseCases _orderUseCases;

  OrderProvider(this._orderUseCases);

  List<OrderModel> _activeOrders = [];
  List<OrderModel> _pastOrders = [];
  OrderModel? _currentOrder;
  TrackingModel? _currentTracking;
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get activeOrders => _activeOrders;
  List<OrderModel> get pastOrders => _pastOrders;
  OrderModel? get currentOrder => _currentOrder;
  TrackingModel? get currentTracking => _currentTracking;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadActiveOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _activeOrders = await _orderUseCases.getActiveOrders();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPastOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pastOrders = await _orderUseCases.getPastOrders();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadOrderDetails(String orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentOrder = await _orderUseCases.getOrderById(orderId);
      _currentTracking = await _orderUseCases.getOrderTracking(orderId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
