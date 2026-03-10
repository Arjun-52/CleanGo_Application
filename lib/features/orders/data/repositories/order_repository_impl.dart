import 'package:clean_go/features/orders/data/models/order_model.dart';
import 'package:clean_go/features/orders/data/models/tracking_model.dart';
import 'package:clean_go/features/orders/domain/repositories/i_order_repository.dart';
import 'package:clean_go/features/orders/data/datasources/order_service.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final OrderService remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderModel>> getOrders() {
    return remoteDataSource.getOrders();
  }

  @override
  Future<List<OrderModel>> getActiveOrders() {
    return remoteDataSource.getActiveOrders();
  }

  @override
  Future<List<OrderModel>> getPastOrders() {
    return remoteDataSource.getPastOrders();
  }

  @override
  Future<OrderModel?> getOrderById(String orderId) {
    return remoteDataSource.getOrderById(orderId);
  }

  @override
  Future<TrackingModel?> getOrderTracking(String orderId) {
    return remoteDataSource.getOrderTracking(orderId);
  }

  @override
  Future<bool> verifyPickupOtp(String orderId, String otp) {
    return remoteDataSource.verifyPickupOtp(orderId, otp);
  }

  @override
  Future<bool> verifyDeliveryOtp(String orderId, String otp) {
    return remoteDataSource.verifyDeliveryOtp(orderId, otp);
  }

  @override
  Future<bool> cancelOrder(String orderId) {
    return remoteDataSource.cancelOrder(orderId);
  }

  @override
  Future<bool> rateOrder(String orderId, int rating, String? review) {
    return remoteDataSource.rateOrder(orderId, rating, review);
  }

}
