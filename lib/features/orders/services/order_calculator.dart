import '../models/item_model.dart';
import '../models/addon_model.dart';

class OrderCalculator {
  static double calculateTotal({
    required Map<String, int> cart,
    required Map<int, List<ItemModel>> categorizedItems,
    required int selectedFilter,
    required List<AddonModel> addons,
    required Set<String> selectedAddons,
    required int selectedMode,
  }) {
    double itemTotal = cart.entries.fold(
      0.0,
      (sum, e) =>
          sum +
          e.value *
              categorizedItems[selectedFilter]!
                  .firstWhere((i) => i.name == e.key)
                  .price,
    );

    double addonTotal = addons
        .where((a) => selectedAddons.contains(a.name))
        .fold(0, (sum, a) => sum + a.price);

    double fastTrackFee = selectedMode == 0 ? 40 : 0;

    return itemTotal + addonTotal + fastTrackFee;
  }
}
