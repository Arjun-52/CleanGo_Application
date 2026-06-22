import '../models/tracking_model.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/i_order_repository.dart';
import '../datasources/order_service.dart';
import '../models/qr_scan_order_model.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final OrderService remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderEntity>> getOrders() async {
    final orders = await remoteDataSource.getOrders();
    return orders.map((order) => order.toEntity()).toList();
  }

  @override
  Future<List<OrderEntity>> getActiveOrders() async {
    final orders = await remoteDataSource.getActiveOrders();
    return orders.map((order) => order.toEntity()).toList();
  }

  @override
  Future<List<OrderEntity>> getPastOrders() async {
    final orders = await remoteDataSource.getPastOrders();
    return orders.map((order) => order.toEntity()).toList();
  }

  @override
  Future<OrderEntity?> getOrderById(String orderId) async {
    final order = await remoteDataSource.getOrderById(orderId);
    return order?.toEntity();
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

  @override
  Future<QrScanOrderModel> scanQrCode(String qrCode) {
    return remoteDataSource.scanQrCode(qrCode);
  }
}
