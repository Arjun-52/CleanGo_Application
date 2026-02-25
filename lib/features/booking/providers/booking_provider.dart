import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';
import '../../../models/service_model.dart';
import '../services/booking_service.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService = BookingService();

  List<ServiceModel> _services = [];
  final List<BookingItem> _cartItems = [];
  bool _isLoading = false;
  String? _error;

  List<ServiceModel> get services => _services;
  List<BookingItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get cartTotal =>
      _cartItems.fold(0, (sum, item) => sum + (item.totalPrice ?? 0));
  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  Future<void> loadServices() async {
    _isLoading = true;
    notifyListeners();

    try {
      _services = await _bookingService.getServices();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(BookingItem item) {
    final existingIndex = _cartItems.indexWhere(
      (i) => i.serviceId == item.serviceId,
    );
    if (existingIndex >= 0) {
      final existing = _cartItems[existingIndex];
      _cartItems[existingIndex] = BookingItem(
        serviceId: existing.serviceId,
        serviceName: existing.serviceName,
        quantity: existing.quantity + item.quantity,
        pricePerUnit: existing.pricePerUnit,
        totalPrice:
            (existing.pricePerUnit ?? 0) * (existing.quantity + item.quantity),
      );
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(String serviceId) {
    _cartItems.removeWhere((item) => item.serviceId == serviceId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
