import 'package:clean_go/features/orders/data/models/order_model.dart';
import 'package:clean_go/features/orders/data/models/tracking_model.dart';

abstract class IOrderRepository {
  Future<List<OrderModel>> getOrders();
  Future<List<OrderModel>> getActiveOrders();
  Future<List<OrderModel>> getPastOrders();
  Future<OrderModel?> getOrderById(String orderId);
  Future<TrackingModel?> getOrderTracking(String orderId);
  Future<bool> verifyPickupOtp(String orderId, String otp);
  Future<bool> verifyDeliveryOtp(String orderId, String otp);
  Future<bool> cancelOrder(String orderId);
  Future<bool> rateOrder(String orderId, int rating, String? review);
}
