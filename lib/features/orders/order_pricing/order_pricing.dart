import 'package:clean_go/features/orders/models/item_model.dart';
import 'package:clean_go/features/orders/models/addon_model.dart';

class OrderPricing {
  static double calculateTotal({
    required Map<String, int> cart,
    required Map<int, List<ItemModel>> categorizedItems,
    required List<AddonModel> addons,
    required Set<String> selectedAddons,
    required int selectedMode,
  }) {
    final allItems = categorizedItems.values.expand((e) => e).toList();

    double itemTotal = cart.entries.fold(0.0, (sum, e) {
      final item = allItems.firstWhere(
        (i) => i.name == e.key,
        orElse: () => ItemModel(name: '', price: 0),
      );
      return sum + (e.value * item.price);
    });

    double addonTotal = addons
        .where((a) => selectedAddons.contains(a.name))
        .fold(0.0, (sum, a) => sum + a.price);

    double fastTrackFee = selectedMode == 0 ? 40 : 0;

    return itemTotal + addonTotal + fastTrackFee;
  }
}
