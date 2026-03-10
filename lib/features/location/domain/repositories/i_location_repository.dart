import 'package:clean_go/features/location/data/models/address_model.dart';

abstract class ILocationRepository {
  Future<Map<String, double>?> getCurrentLocation();
  Future<String?> getAddressFromCoordinates(double latitude, double longitude);
  Future<List<AddressModel>> searchLocation(String query);
  Future<bool> saveAddress(AddressModel address);
  Future<List<AddressModel>> getSavedAddresses();
  Future<bool> deleteAddress(String addressId);
  Future<bool> setDefaultAddress(String addressId);
}
