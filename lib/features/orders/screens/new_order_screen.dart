import 'package:clean_go/widgets/service_tile.dart';
import 'package:flutter/material.dart';
import 'package:clean_go/models/item_model.dart';
import 'package:clean_go/models/addon_model.dart';
import 'package:clean_go/widgets/location_card.dart';
import 'package:clean_go/widgets/mode_card.dart';
import 'package:clean_go/widgets/item_row.dart';
import 'package:clean_go/widgets/addon_row.dart';
import 'package:clean_go/features/orders/screens/select_pickup_slot_screen.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  int selectedMode = 1;
  int selectedService = -1;

  Map<String, int> cart = {};
  Set<String> selectedAddons = {};
  int selectedFilter = 0;
  final Map<int, List<ItemModel>> categorizedItems = {
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

  final List<Map<String, dynamic>> services = [
    {
      "title": "Wash & Iron",
      "subtitle": "Complete care",
      "icon": Icons.local_laundry_service,
      "color": Colors.green,
    },
    {
      "title": "Iron Only",
      "subtitle": "Crisp finish",
      "icon": Icons.iron,
      "color": Colors.orange,
    },
    {
      "title": "Dry Clean",
      "subtitle": "Premium care",
      "icon": Icons.dry_cleaning,
      "color": Colors.blue,
    },
    {
      "title": "Wash & Fold",
      "subtitle": "Quick service",
      "icon": Icons.checkroom,
      "color": Colors.indigo,
    },
  ];

  double get totalPrice {
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

  Widget _buildFilterButton(String title, int index) {
    final bool isSelected = selectedFilter == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff0D47A1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xff0D47A1)),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xff0D47A1),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                const SizedBox(height: 24),

                /// SERVICE MODE
                const Text(
                  "Service Mode",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),

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

                const SizedBox(height: 30),

                /// SERVICE TYPE
                const Text(
                  "Service Type",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.24,
                  children: [
                    ///  Wash & Iron
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selectedService == 0
                                  ? const Color(0xff0D47A1)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.08,
                                ), // soft shadow
                                blurRadius: 12,
                                offset: const Offset(0, 6), // downward shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                /// Service Card
                                ServiceTile(
                                  title: "Wash and Iron",
                                  subtitle: "Elegant Finish",
                                  icon: Icons.iron,
                                  iconColor: const Color(0xffF4A300),
                                  onTap: () {
                                    setState(() {
                                      selectedService = 0;
                                    });
                                  },
                                ),

                                /// Tick INSIDE container
                                if (selectedService == 0)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff0D47A1),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Iron Only
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selectedService == 1
                                  ? const Color(0xff0D47A1)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.08,
                                ), // soft shadow
                                blurRadius: 12,
                                offset: const Offset(0, 6), // downward shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                /// Service Card
                                ServiceTile(
                                  title: "Iron Only",
                                  subtitle: "Crisp finish",
                                  icon: Icons.iron,
                                  iconColor: const Color(0xffF4A300),
                                  onTap: () {
                                    setState(() {
                                      selectedService = 1;
                                    });
                                  },
                                ),

                                /// Tick INSIDE the bordered container
                                if (selectedService == 1)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff0D47A1),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///  Dry Clean
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedService == 2
                                  ? const Color(0xff0D47A1)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.08,
                                ), // soft shadow
                                blurRadius: 12,
                                offset: const Offset(0, 6), // downward shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                /// Service Card
                                ServiceTile(
                                  title: "Dry Clean",
                                  subtitle: "Premium care",
                                  icon: Icons.auto_awesome,
                                  iconColor: const Color(0xff0B3C5D),
                                  onTap: () {
                                    setState(() {
                                      selectedService = 2;
                                    });
                                  },
                                ),

                                /// Tick INSIDE border
                                if (selectedService == 2)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff0D47A1),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Wash & Fold
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedService == 3
                                  ? const Color(0xff0D47A1)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.08,
                                ), // soft shadow
                                blurRadius: 12,
                                offset: const Offset(0, 6), // downward shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                /// Service Card
                                ServiceTile(
                                  title: "Wash & Fold",
                                  subtitle: "Quick service",
                                  icon: Icons.local_laundry_service,
                                  iconColor: const Color(0xff0B3C5D),
                                  onTap: () {
                                    setState(() {
                                      selectedService = 3;
                                    });
                                  },
                                ),

                                /// Tick INSIDE border
                                if (selectedService == 3)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff0D47A1),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                const Text(
                  "Service Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    _buildFilterButton("Clothing", 0),
                    const SizedBox(width: 10),
                    _buildFilterButton("Household", 1),
                    const SizedBox(width: 10),
                    _buildFilterButton("Speciality", 2),
                  ],
                ),

                const SizedBox(height: 16),

                /// CLOTHES SELECTION
                const Text(
                  "Clothes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),

                ...categorizedItems[selectedFilter]!.map((item) {
                  int qty = cart[item.name] ?? 0;

                  return ItemRow(
                    item: item,
                    qty: qty,
                    onAdd: () => setState(() => cart[item.name] = qty + 1),
                    onRemove: () => setState(() {
                      if (qty == 1) {
                        cart.remove(item.name);
                      } else if (qty > 1) {
                        cart[item.name] = qty - 1;
                      }
                    }),
                  );
                }),
                const SizedBox(height: 30),

                /// ADDONS
                const Text(
                  "Add-ons",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),

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

                const SizedBox(height: 100),
              ],
            ),
          ),

          /// BOTTOM BAR
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "₹$totalPrice",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: totalPrice == 0
                      ? null
                      : () {
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
