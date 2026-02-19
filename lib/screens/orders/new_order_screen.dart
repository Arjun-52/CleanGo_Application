import 'package:flutter/material.dart';
import 'package:clean_go/models/item_model.dart';
import 'package:clean_go/models/addon_model.dart';
import 'package:clean_go/widgets/location_card.dart';
import 'package:clean_go/widgets/mode_card.dart';
import 'package:clean_go/widgets/item_row.dart';
import 'package:clean_go/widgets/addon_row.dart';
import 'package:clean_go/screens/orders/select_pickup_slot_screen.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  int selectedMode = 1;

  Map<String, int> cart = {};
  Set<String> selectedAddons = {};

  final List<ItemModel> items = [
    ItemModel(name: "Shirt", price: 30),
    ItemModel(name: "T-Shirt", price: 25),
    ItemModel(name: "Trousers", price: 40),
    ItemModel(name: "Jeans", price: 50),
  ];

  final List<AddonModel> addons = [
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
  ];

  int get totalPrice {
    int itemTotal = cart.entries.fold(
      0,
      (sum, e) =>
          sum + e.value * items.firstWhere((i) => i.name == e.key).price,
    );

    int addonTotal = addons
        .where((a) => selectedAddons.contains(a.name))
        .fold(0, (sum, a) => sum + a.price);

    return itemTotal + addonTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text("New Order", style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const LocationCard(),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ModeCard(
                        index: 0,
                        selectedMode: selectedMode,
                        icon: Icons.flash_on,
                        title: "Fast Track",
                        onTap: () => setState(() => selectedMode = 0),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ModeCard(
                        index: 1,
                        selectedMode: selectedMode,
                        icon: Icons.access_time,
                        title: "Standard",
                        onTap: () => setState(() => selectedMode = 1),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ...items.map((item) {
                  int qty = cart[item.name] ?? 0;

                  return ItemRow(
                    item: item,
                    qty: qty,
                    onAdd: () => setState(() => cart[item.name] = qty + 1),
                    onRemove: () => setState(() {
                      if (qty == 1) {
                        cart.remove(item.name);
                      } else {
                        cart[item.name] = qty - 1;
                      }
                    }),
                  );
                }),

                const SizedBox(height: 20),

                ...addons.map((addon) {
                  bool selected = selectedAddons.contains(addon.name);

                  return AddonRow(
                    addon: addon,
                    selected: selected,
                    onTap: () => setState(() {
                      selected
                          ? selectedAddons.remove(addon.name)
                          : selectedAddons.add(addon.name);
                    }),
                  );
                }),

                const SizedBox(height: 80),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "₹$totalPrice",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SelectPickupSlotScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0D47A1),
                  ),
                  child: const Text(
                    "Select Slot",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
