import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/home/widgets/service_tile.dart';
import 'package:clean_go/features/orders/order_constans/order_constans.dart';
import 'package:clean_go/features/orders/order_pricing/order_pricing.dart';
import 'package:flutter/material.dart';
import 'package:clean_go/features/orders/models/item_model.dart';
import 'package:clean_go/features/orders/models/addon_model.dart';
import 'package:clean_go/features/location/widgets/location_card.dart';
import 'package:clean_go/features/orders/widgets/mode_card.dart';
import 'package:clean_go/features/orders/models/item_row.dart';
import 'package:clean_go/features/orders/models/addon_row.dart';
import 'package:clean_go/features/orders/screens/select_pickup_slot_screen.dart';

class NewOrderScreen extends StatefulWidget {
  final bool isFastTrack;
  const NewOrderScreen({
    super.key,
    required this.serviceName,
    required this.isFastTrack,
  });

  final String serviceName;

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  bool get canSelectItems => selectedMode != -1 && selectedService != -1;
  int selectedMode = -1;
  int selectedService = -1;
  @override
  void initState() {
    super.initState();

    if (widget.isFastTrack) {
      selectedMode = 0; // Select Fast Track mode
      selectedAddons.add("Express Processing");
    }
  }

  Map<String, int> cart = {};
  Set<String> selectedAddons = {};

  int selectedFilter = 0;

  final categorizedItems = OrderConstants.categorizedItems;
  final addons = OrderConstants.addons;
  final services = OrderConstants.services;

  double get totalPrice => OrderPricing.calculateTotal(
    cart: cart,
    categorizedItems: categorizedItems,
    addons: addons,
    selectedAddons: selectedAddons,
    selectedMode: selectedMode,
  );

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
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 29,
                    mainAxisSpacing: 29,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    final bool isSelected = selectedService == index;

                    return Stack(
                      children: [
                        ServiceTile(
                          icon: service["icon"],
                          iconColor: service["color"],
                          title: service["title"],
                          subtitle: service["subtitle"],
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedService = index;
                            });
                          },
                        ),

                        if (isSelected)
                          Positioned(
                            top: 2,
                            right: 2,
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
                    );
                  },
                ),

                if (canSelectItems) ...[
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
                ],

                const SizedBox(height: 100),
              ],
            ),
          ),

          /// BOTTOM BAR
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
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
                    backgroundColor: AppColors.primary,
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
