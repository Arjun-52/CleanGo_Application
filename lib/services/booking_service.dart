import '../models/booking_model.dart';
import '../models/service_model.dart';

class BookingService {
  /// Get all services
  Future<List<ServiceModel>> getServices() async {
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data until API comes
    return [
      ServiceModel(id: "1", name: "Wash & Fold", price: 100),
      ServiceModel(id: "2", name: "Dry Cleaning", price: 200),
    ];
  }

  /// Get service by ID
  Future<ServiceModel?> getServiceById(String serviceId) async {
    final services = await getServices();

    try {
      return services.firstWhere((s) => s.id == serviceId);
    } catch (_) {
      return null;
    }
  }

  /// Create booking
  Future<BookingModel?> createBooking(BookingModel booking) async {
    await Future.delayed(const Duration(seconds: 1));

    // Later this will send booking to backend
    return booking;
  }

  /// Pickup slots
  Future<List<String>> getAvailablePickupSlots(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      '9:00 AM - 11:00 AM',
      '11:00 AM - 1:00 PM',
      '2:00 PM - 4:00 PM',
      '4:00 PM - 6:00 PM',
    ];
  }

  /// Delivery slots
  Future<List<String>> getAvailableDeliverySlots(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      '9:00 AM - 11:00 AM',
      '11:00 AM - 1:00 PM',
      '2:00 PM - 4:00 PM',
      '4:00 PM - 6:00 PM',
    ];
  }

  /// Apply coupon
  Future<double?> applyCoupon(String couponCode, double amount) async {
    await Future.delayed(const Duration(seconds: 1));

    if (couponCode == "SAVE10") {
      return amount * 0.9; // 10% discount
    }

    return null;
  }
}
