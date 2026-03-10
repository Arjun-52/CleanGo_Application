import 'package:clean_go/features/orders/data/models/tracking_model.dart';
import '../models/order_model.dart';

class OrderService {
  /// Get all orders
  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [...await getActiveOrders(), ...await getPastOrders()];
  }

  /// Active Orders
  Future<List<OrderModel>> getActiveOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      OrderModel(
        id: "CLN-2026-001",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "1",
            serviceName: "Wash & Iron",
            quantity: 2,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.inProgress,
        pickupOtp: "1234",
        deliveryOtp: "5678",
        pickupTime: DateTime.now(),
        deliveryTime: DateTime.now().add(const Duration(days: 2)),
        addressId: "address1",
        createdAt: DateTime.now(),
      ),
    ];
  }

  /// Past Orders (THIS FIXES YOUR SCREEN)
  Future<List<OrderModel>> getPastOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      OrderModel(
        id: "CLN-2026-001",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "1",
            serviceName: "Wash & Iron",
            quantity: 2,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.processing,
        pickupOtp: "1234",
        deliveryOtp: "5678",
        pickupTime: DateTime.now().subtract(const Duration(days: 2)),
        deliveryTime: DateTime.now().subtract(const Duration(days: 1)),
        addressId: "address1",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),

      OrderModel(
        id: "CLN-2026-002",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "2",
            serviceName: "Dry Clean",
            quantity: 6,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.processing,
        pickupOtp: "2222",
        deliveryOtp: "3333",
        pickupTime: DateTime.now().subtract(const Duration(days: 5)),
        deliveryTime: DateTime.now().subtract(const Duration(days: 4)),
        addressId: "address2",
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),

      OrderModel(
        id: "CLN-2026-003",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "3",
            serviceName: "Steam Iron",
            quantity: 4,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.delivered,
        pickupOtp: "4444",
        deliveryOtp: "5555",
        pickupTime: DateTime.now().subtract(const Duration(days: 8)),
        deliveryTime: DateTime.now().subtract(const Duration(days: 7)),
        addressId: "address3",
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
    ];
  }

  /// Get order by ID
  Future<OrderModel?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));

    return OrderModel(
      id: orderId,
      userId: "user123",
      items: [
        OrderItem(
          serviceId: "1",
          serviceName: "Wash & Iron",
          quantity: 5,
          price: 499,
        ),
        OrderItem(
          serviceId: "2",
          serviceName: "Dry Clean",
          quantity: 2,
          price: 300,
        ),
      ],
      totalAmount: 799,
      status: OrderStatus.inProgress,
      pickupOtp: "5646",
      deliveryOtp: "7890",
      pickupTime: DateTime.now().subtract(const Duration(days: 1)),
      deliveryTime: DateTime.now().add(const Duration(days: 1)),
      addressId: "address123",
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    );
  }

  /// Order Tracking
  Future<TrackingModel?> getOrderTracking(String orderId) async {
    return null;
  }

  Future<bool> verifyPickupOtp(String orderId, String otp) async {
    return true;
  }

  Future<bool> verifyDeliveryOtp(String orderId, String otp) async {
    return true;
  }

  Future<bool> cancelOrder(String orderId) async {
    return true;
  }

  Future<bool> rateOrder(String orderId, int rating, String? review) async {
    return true;
  }
}
