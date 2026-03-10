import 'package:clean_go/features/booking/data/models/booking_model.dart';
import 'package:clean_go/features/services/data/models/service_model.dart';
import 'package:clean_go/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:clean_go/features/booking/data/datasources/booking_service.dart';

class BookingRepositoryImpl implements IBookingRepository {
  final BookingService remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ServiceModel>> getServices() {
    return remoteDataSource.getServices();
  }

  @override
  Future<ServiceModel?> getServiceById(String serviceId) {
    return remoteDataSource.getServiceById(serviceId);
  }

  @override
  Future<List<String>> getAvailablePickupSlots(DateTime date) {
    return remoteDataSource.getAvailablePickupSlots(date);
  }

  @override
  Future<List<String>> getAvailableDeliverySlots(DateTime date) {
    return remoteDataSource.getAvailableDeliverySlots(date);
  }

  @override
  Future<BookingModel?> createBooking(BookingModel booking) {
    return remoteDataSource.createBooking(booking);
  }

  @override
  Future<double?> applyCoupon(String couponCode, double amount) {
    return remoteDataSource.applyCoupon(couponCode, amount);
  }
}
