import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/home/widgets/service_tile.dart';
import 'package:clean_go/features/location/widgets/location_card.dart';

import 'package:clean_go/features/orders/providers/new_order_provider.dart';
import 'package:clean_go/features/orders/widgets/filter_button.dart';
import 'package:clean_go/features/orders/widgets/mode_card.dart';
import 'package:clean_go/features/orders/models/item_row.dart';
import 'package:clean_go/features/orders/models/addon_row.dart';
import 'package:clean_go/features/orders/screens/select_pickup_slot_screen.dart';

class NewOrderScreen extends StatefulWidget {
  final bool isFastTrack;
  final String serviceName;

  const NewOrderScreen({
    super.key,
    required this.serviceName,
    required this.isFastTrack,
  });

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<NewOrderProvider>().initFastTrack(widget.isFastTrack);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewOrderProvider>();

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
                        selectedMode: provider.selectedMode,
                        icon: Icons.flash_on,
                        title: "Fast Track",
                        onTap: () => provider.selectMode(0),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ModeCard(
                        index: 1,
                        selectedMode: provider.selectedMode,
                        icon: Icons.access_time,
                        title: "Standard",
                        onTap: () => provider.selectMode(1),
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
                  itemCount: provider.services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 29,
                    mainAxisSpacing: 29,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (context, index) {
                    final service = provider.services[index];
                    final isSelected = provider.selectedService == index;

                    return Stack(
                      children: [
                        ServiceTile(
                          icon: service["icon"],
                          iconColor: service["color"],
                          title: service["title"],
                          subtitle: service["subtitle"],
                          isSelected: isSelected,
                          onTap: () => provider.selectService(index),
                        ),

                        if (isSelected)
                          const Positioned(
                            top: 2,
                            right: 2,
                            child: Icon(Icons.check_circle, color: Colors.blue),
                          ),
                      ],
                    );
                  },
                ),

                if (provider.canSelectItems) ...[
                  const SizedBox(height: 30),

                  const Text(
                    "Service Type",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      FilterButton(
                        title: "Clothing",
                        isSelected: provider.selectedFilter == 0,
                        onTap: () => provider.changeFilter(0),
                      ),

                      const SizedBox(width: 10),

                      FilterButton(
                        title: "Household",
                        isSelected: provider.selectedFilter == 1,
                        onTap: () => provider.changeFilter(1),
                      ),

                      const SizedBox(width: 10),

                      FilterButton(
                        title: "Speciality",
                        isSelected: provider.selectedFilter == 2,
                        onTap: () => provider.changeFilter(2),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  ...provider.categorizedItems[provider.selectedFilter]!.map((
                    item,
                  ) {
                    int qty = provider.cart[item.name] ?? 0;

                    return ItemRow(
                      item: item,
                      qty: qty,
                      onAdd: () => provider.addItem(item.name),
                      onRemove: () => provider.removeItem(item.name),
                    );
                  }),

                  const SizedBox(height: 30),

                  const Text(
                    "Add-ons",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  ...provider.addons.map((addon) {
                    bool selected = provider.selectedAddons.contains(
                      addon.name,
                    );

                    return AddonRow(
                      addon: addon,
                      selected: selected,
                      onTap: () => provider.toggleAddon(addon.name),
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
                    "₹${provider.totalPrice}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: provider.totalPrice == 0
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
