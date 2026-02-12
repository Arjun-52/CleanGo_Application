import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/address_model.dart';

class LocationService {
  static const String addressKey = "saved_addresses";

  /// Get current location (dummy)
  Future<Map<String, double>?> getCurrentLocation() async {
    await Future.delayed(const Duration(seconds: 1));

    // Dummy coordinates
    return {"latitude": 17.3850, "longitude": 78.4867};
  }

  /// Convert coordinates to address (dummy)
  Future<String?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return "Hyderabad, India";
  }

  /// Search location (dummy results)
  Future<List<AddressModel>> searchLocation(String query) async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      AddressModel(
        id: "1",
        title: "Home",
        addressLine: "$query Street, Hyderabad",
        isDefault: false,
      ),
      AddressModel(
        id: "2",
        title: "Office",
        addressLine: "$query Business Park, Hyderabad",
        isDefault: false,
      ),
    ];
  }

  /// Save address locally
  Future<bool> saveAddress(AddressModel address) async {
    final prefs = await SharedPreferences.getInstance();

    final list = await getSavedAddresses();
    list.add(address);

    await prefs.setString(
      addressKey,
      jsonEncode(list.map((e) => e.toJson()).toList()),
    );

    return true;
  }

  /// Get saved addresses
  Future<List<AddressModel>> getSavedAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(addressKey);

    if (data == null) return [];

    List decoded = jsonDecode(data);

    return decoded.map((e) => AddressModel.fromJson(e)).toList();
  }

  /// Delete address
  Future<bool> deleteAddress(String addressId) async {
    final prefs = await SharedPreferences.getInstance();

    final list = await getSavedAddresses();
    list.removeWhere((a) => a.id == addressId);

    await prefs.setString(
      addressKey,
      jsonEncode(list.map((e) => e.toJson()).toList()),
    );

    return true;
  }

  /// Set default address
  Future<bool> setDefaultAddress(String addressId) async {
    final prefs = await SharedPreferences.getInstance();

    final list = await getSavedAddresses();

    for (var a in list) {
      a.isDefault = a.id == addressId;
    }

    await prefs.setString(
      addressKey,
      jsonEncode(list.map((e) => e.toJson()).toList()),
    );

    return true;
  }
}
