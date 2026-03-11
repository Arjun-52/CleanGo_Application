import 'package:flutter/foundation.dart';
import '../../domain/order_constans/order_constans.dart';
import '../../domain/usecases/order_pricing.dart';
import 'states/new_order_state.dart';

class NewOrderProvider with ChangeNotifier {
  NewOrderState _state = const NewOrderInitial();

  final categorizedItems = OrderConstants.categorizedItems;
  final addons = OrderConstants.addons;
  final services = OrderConstants.services;

  NewOrderProvider();

  NewOrderState get state => _state;

  Map<String, int> get cart =>
      _state is NewOrderSuccess ? (_state as NewOrderSuccess).cart : {};

  Set<String> get selectedAddons => _state is NewOrderSuccess
      ? (_state as NewOrderSuccess).selectedAddons
      : {};

  int get selectedMode =>
      _state is NewOrderSuccess ? (_state as NewOrderSuccess).selectedMode : -1;

  int get selectedService => _state is NewOrderSuccess
      ? (_state as NewOrderSuccess).selectedService
      : -1;

  int get selectedFilter => _state is NewOrderSuccess
      ? (_state as NewOrderSuccess).selectedFilter
      : 0;

  bool get canSelectItems => selectedMode != -1 && selectedService != -1;

  double get totalPrice => OrderPricing.calculateTotal(
    cart: cart,
    categorizedItems: categorizedItems,
    addons: addons,
    selectedAddons: selectedAddons,
    selectedMode: selectedMode,
  );
  int get totalClothes {
    int count = 0;

    for (var qty in cart.values) {
      count += qty;
    }

    return count;
  }

  void _emitState(NewOrderState newState) {
    _state = newState;
    notifyListeners();
  }

  void selectMode(int mode) {
    final currentCart = cart;
    final currentAddons = selectedAddons;
    final currentService = selectedService;
    final currentFilter = selectedFilter;

    _emitState(
      NewOrderSuccess(
        cart: currentCart,
        selectedAddons: currentAddons,
        selectedMode: mode,
        selectedService: currentService,
        selectedFilter: currentFilter,
      ),
    );
  }

  void selectService(int index) {
    final currentCart = cart;
    final currentAddons = selectedAddons;
    final currentMode = selectedMode;
    final currentFilter = selectedFilter;

    _emitState(
      NewOrderSuccess(
        cart: currentCart,
        selectedAddons: currentAddons,
        selectedMode: currentMode,
        selectedService: index,
        selectedFilter: currentFilter,
      ),
    );
  }

  void changeFilter(int index) {
    final currentCart = cart;
    final currentAddons = selectedAddons;
    final currentMode = selectedMode;
    final currentService = selectedService;

    _emitState(
      NewOrderSuccess(
        cart: currentCart,
        selectedAddons: currentAddons,
        selectedMode: currentMode,
        selectedService: currentService,
        selectedFilter: index,
      ),
    );
  }

  void addItem(String name) {
    final currentCart = Map<String, int>.from(cart);
    currentCart[name] = (currentCart[name] ?? 0) + 1;

    final currentAddons = selectedAddons;
    final currentMode = selectedMode;
    final currentService = selectedService;
    final currentFilter = selectedFilter;

    _emitState(
      NewOrderSuccess(
        cart: currentCart,
        selectedAddons: currentAddons,
        selectedMode: currentMode,
        selectedService: currentService,
        selectedFilter: currentFilter,
      ),
    );
  }

  void removeItem(String name) {
    final currentCart = Map<String, int>.from(cart);
    int qty = currentCart[name] ?? 0;

    if (qty <= 1) {
      currentCart.remove(name);
    } else {
      currentCart[name] = qty - 1;
    }

    final currentAddons = selectedAddons;
    final currentMode = selectedMode;
    final currentService = selectedService;
    final currentFilter = selectedFilter;

    _emitState(
      NewOrderSuccess(
        cart: currentCart,
        selectedAddons: currentAddons,
        selectedMode: currentMode,
        selectedService: currentService,
        selectedFilter: currentFilter,
      ),
    );
  }

  void toggleAddon(String name) {
    final currentCart = cart;
    final currentAddons = Set<String>.from(selectedAddons);

    if (currentAddons.contains(name)) {
      currentAddons.remove(name);
    } else {
      currentAddons.add(name);
    }

    final currentMode = selectedMode;
    final currentService = selectedService;
    final currentFilter = selectedFilter;

    _emitState(
      NewOrderSuccess(
        cart: currentCart,
        selectedAddons: currentAddons,
        selectedMode: currentMode,
        selectedService: currentService,
        selectedFilter: currentFilter,
      ),
    );
  }

  void initFastTrack(bool isFastTrack) {
    final currentCart = cart;
    final currentAddons = Set<String>.from(selectedAddons);

    if (isFastTrack) {
      currentAddons.add("Express Processing");
    }

    final currentMode = isFastTrack ? 0 : selectedMode;
    final currentService = selectedService;
    final currentFilter = selectedFilter;

    _emitState(
      NewOrderSuccess(
        cart: currentCart,
        selectedAddons: currentAddons,
        selectedMode: currentMode,
        selectedService: currentService,
        selectedFilter: currentFilter,
      ),
    );
  }
}
