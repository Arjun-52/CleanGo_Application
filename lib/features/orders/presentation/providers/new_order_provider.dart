import 'package:flutter/material.dart';
import '../../domain/order_constans/order_constans.dart';
import '../../domain/usecases/order_pricing.dart';

class NewOrderProvider with ChangeNotifier {
  int selectedMode = -1;
  int selectedService = -1;
  int selectedFilter = 0;

  Map<String, int> cart = {};
  Set<String> selectedAddons = {};

  final categorizedItems = OrderConstants.categorizedItems;
  final addons = OrderConstants.addons;
  final services = OrderConstants.services;

  bool get canSelectItems => selectedMode != -1 && selectedService != -1;

  double get totalPrice => OrderPricing.calculateTotal(
    cart: cart,
    categorizedItems: categorizedItems,
    addons: addons,
    selectedAddons: selectedAddons,
    selectedMode: selectedMode,
  );

  void selectMode(int mode) {
    selectedMode = mode;
    notifyListeners();
  }

  void selectService(int index) {
    selectedService = index;
    notifyListeners();
  }

  void changeFilter(int index) {
    selectedFilter = index;
    notifyListeners();
  }

  void addItem(String name) {
    cart[name] = (cart[name] ?? 0) + 1;
    notifyListeners();
  }

  void removeItem(String name) {
    int qty = cart[name] ?? 0;

    if (qty <= 1) {
      cart.remove(name);
    } else {
      cart[name] = qty - 1;
    }

    notifyListeners();
  }

  void toggleAddon(String name) {
    if (selectedAddons.contains(name)) {
      selectedAddons.remove(name);
    } else {
      selectedAddons.add(name);
    }

    notifyListeners();
  }

  void initFastTrack(bool isFastTrack) {
    if (isFastTrack) {
      selectedMode = 0;
      selectedAddons.add("Express Processing");
    }
  }
}
