import 'package:flutter/foundation.dart';
import '../../../models/tracking_model.dart';
import '../models/order_model.dart';

import '../services/order_service.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

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
      _activeOrders = await _orderService.getActiveOrders();
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
      _pastOrders = await _orderService.getPastOrders();
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
      _currentOrder = await _orderService.getOrderById(orderId);
      _currentTracking = await _orderService.getOrderTracking(orderId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
