import 'package:clean_go/features/booking/data/models/booking_model.dart';
import 'package:clean_go/features/services/data/models/service_model.dart';
import 'package:clean_go/features/booking/domain/repositories/i_booking_repository.dart';

class BookingUseCases {
  final IBookingRepository repository;

  BookingUseCases(this.repository);

  Future<List<ServiceModel>> getServices() {
    return repository.getServices();
  }

  Future<ServiceModel?> getServiceById(String serviceId) {
    return repository.getServiceById(serviceId);
  }

  Future<List<String>> getAvailablePickupSlots(DateTime date) {
    return repository.getAvailablePickupSlots(date);
  }

  Future<List<String>> getAvailableDeliverySlots(DateTime date) {
    return repository.getAvailableDeliverySlots(date);
  }

  Future<BookingModel?> createBooking(BookingModel booking) {
    return repository.createBooking(booking);
  }

  Future<double?> applyCoupon(String couponCode, double amount) {
    return repository.applyCoupon(couponCode, amount);
  }

}
