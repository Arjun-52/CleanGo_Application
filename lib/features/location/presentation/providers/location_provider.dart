import 'package:flutter/foundation.dart';
import '../../data/models/address_model.dart';
import '../../data/datasources/location_service.dart';

import 'package:clean_go/features/location/domain/usecases/location_usecases.dart';
import 'package:clean_go/features/location/data/repositories/location_repository_impl.dart';

class LocationProvider with ChangeNotifier {
  final LocationUseCases _locationUseCases = LocationUseCases(LocationRepositoryImpl(LocationService()));
  
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
      _addresses = await _locationUseCases.getSavedAddresses();
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
      final result = await _locationUseCases.saveAddress(address);
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
