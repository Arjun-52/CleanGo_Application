import 'package:clean_go/features/location/data/models/address_model.dart';
import 'package:clean_go/features/location/domain/repositories/i_location_repository.dart';

class LocationUseCases {
  final ILocationRepository repository;

  LocationUseCases(this.repository);

  Future<Map<String, double>?> getCurrentLocation() {
    return repository.getCurrentLocation();
  }

  Future<String?> getAddressFromCoordinates(double latitude, double longitude) {
    return repository.getAddressFromCoordinates(latitude, longitude);
  }

  Future<List<AddressModel>> searchLocation(String query) {
    return repository.searchLocation(query);
  }

  Future<bool> saveAddress(AddressModel address) {
    return repository.saveAddress(address);
  }

  Future<List<AddressModel>> getSavedAddresses() {
    return repository.getSavedAddresses();
  }

  Future<bool> deleteAddress(String addressId) {
    return repository.deleteAddress(addressId);
  }

  Future<bool> setDefaultAddress(String addressId) {
    return repository.setDefaultAddress(addressId);
  }

}
