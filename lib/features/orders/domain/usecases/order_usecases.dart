import 'package:clean_go/features/orders/data/models/order_model.dart';
import 'package:clean_go/features/orders/data/models/tracking_model.dart';
import 'package:clean_go/features/orders/domain/repositories/i_order_repository.dart';

class OrderUseCases {
  final IOrderRepository repository;

  OrderUseCases(this.repository);

  Future<List<OrderModel>> getOrders() {
    return repository.getOrders();
  }

  Future<List<OrderModel>> getActiveOrders() {
    return repository.getActiveOrders();
  }

  Future<List<OrderModel>> getPastOrders() {
    return repository.getPastOrders();
  }

  Future<OrderModel?> getOrderById(String orderId) {
    return repository.getOrderById(orderId);
  }

  Future<TrackingModel?> getOrderTracking(String orderId) {
    return repository.getOrderTracking(orderId);
  }

  Future<bool> verifyPickupOtp(String orderId, String otp) {
    return repository.verifyPickupOtp(orderId, otp);
  }

  Future<bool> verifyDeliveryOtp(String orderId, String otp) {
    return repository.verifyDeliveryOtp(orderId, otp);
  }

  Future<bool> cancelOrder(String orderId) {
    return repository.cancelOrder(orderId);
  }

  Future<bool> rateOrder(String orderId, int rating, String? review) {
    return repository.rateOrder(orderId, rating, review);
  }

}
