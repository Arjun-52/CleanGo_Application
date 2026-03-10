import 'package:clean_go/features/booking/data/models/booking_model.dart';
import 'package:clean_go/features/services/data/models/service_model.dart';

abstract class IBookingRepository {
  Future<List<ServiceModel>> getServices();
  Future<ServiceModel?> getServiceById(String serviceId);
  Future<BookingModel?> createBooking(BookingModel booking);
  Future<List<String>> getAvailablePickupSlots(DateTime date);
  Future<List<String>> getAvailableDeliverySlots(DateTime date);
  Future<double?> applyCoupon(String couponCode, double amount);
}
