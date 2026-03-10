import 'package:clean_go/features/location/data/models/address_model.dart';
import 'package:clean_go/features/location/domain/repositories/i_location_repository.dart';
import 'package:clean_go/features/location/data/datasources/location_service.dart';

class LocationRepositoryImpl implements ILocationRepository {
  final LocationService remoteDataSource;

  LocationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, double>?> getCurrentLocation() {
    return remoteDataSource.getCurrentLocation();
  }

  @override
  Future<String?> getAddressFromCoordinates(double latitude, double longitude) {
    return remoteDataSource.getAddressFromCoordinates(latitude, longitude);
  }

  @override
  Future<List<AddressModel>> searchLocation(String query) {
    return remoteDataSource.searchLocation(query);
  }

  @override
  Future<bool> saveAddress(AddressModel address) {
    return remoteDataSource.saveAddress(address);
  }

  @override
  Future<List<AddressModel>> getSavedAddresses() {
    return remoteDataSource.getSavedAddresses();
  }

  @override
  Future<bool> deleteAddress(String addressId) {
    return remoteDataSource.deleteAddress(addressId);
  }

  @override
  Future<bool> setDefaultAddress(String addressId) {
    return remoteDataSource.setDefaultAddress(addressId);
  }

}
