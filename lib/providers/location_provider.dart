import 'package:flutter/foundation.dart';
import '../models/address_model.dart';
import '../services/location_service.dart';

class LocationProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();
  
  List<AddressModel> _addresses = [];
  AddressModel? _selectedAddress;
  bool _isLoading = false;
  String? _error;

  List<AddressModel> get addresses => _addresses;
  AddressModel? get selectedAddress => _selectedAddress;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAddresses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _addresses = await _locationService.getSavedAddresses();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveAddress(AddressModel address) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _locationService.saveAddress(address);
      if (result) await loadAddresses();
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void selectAddress(AddressModel address) {
    _selectedAddress = address;
    notifyListeners();
  }
}
