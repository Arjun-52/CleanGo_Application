import '../models/item_model.dart';
import '../models/addon_model.dart';

class OrderData {
  static final Map<int, List<ItemModel>> categorizedItems = {
    0: [
      ItemModel(name: "Shirt", price: 30),
      ItemModel(name: "T-Shirt", price: 25),
      ItemModel(name: "Trousers", price: 40),
      ItemModel(name: "Jeans", price: 50),
      ItemModel(name: "Saree", price: 70),
      ItemModel(name: "Dress", price: 80),
      ItemModel(name: "Suit(2pc)", price: 200),
      ItemModel(name: "Kurta", price: 45),
    ],
    1: [
      ItemModel(name: "Bedsheet", price: 60),
      ItemModel(name: "Curtains", price: 80),
      ItemModel(name: "Blanket", price: 100),
    ],
    2: [
      ItemModel(name: "Blazer", price: 120),
      ItemModel(name: "Suit", price: 200),
      ItemModel(name: "Lehenga", price: 250),
    ],
  };

  static final List<AddonModel> addons = [
    AddonModel(
      name: "Fabric Softener",
      price: 25,
      desc: "Premium fabric softener",
    ),
    AddonModel(
      name: "Stain Treatment",
      price: 50,
      desc: "Specialized stain removal",
    ),
    AddonModel(
      name: "Fragrance Boost",
      price: 25,
      desc: "Long-lasting fresh fragrance",
    ),
    AddonModel(
      name: "Express Processing",
      price: 100,
      desc: "Priority processing queue",
    ),
  ];
}
