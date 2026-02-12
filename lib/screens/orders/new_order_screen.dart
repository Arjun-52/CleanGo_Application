import 'package:flutter/material.dart';
import 'select_pickup_slot_screen.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  int selectedMode = 1;
  int selectedService = -1;
  int selectedCategory = 0;

  final ScrollController _scrollController = ScrollController();
  bool showItems = false;

  Map<String, int> cart = {};
  Set<String> selectedAddons = {};

  List<Map<String, dynamic>> items = [
    {"name": "Shirt", "price": 30},
    {"name": "T-Shirt", "price": 25},
    {"name": "Trousers", "price": 40},
    {"name": "Jeans", "price": 50},
    {"name": "Dress", "price": 80},
    {"name": "Saree", "price": 120},
  ];

  List<Map<String, dynamic>> addons = [
    {
      "name": "Fabric Softener",
      "price": 25,
      "desc": "Premium fabric softener for extra softness",
    },
    {
      "name": "Stain Treatment",
      "price": 50,
      "desc": "Specialized stain removal treatment",
    },
    {
      "name": "Fragrance Boost",
      "price": 15,
      "desc": "Long lasting fresh fragrance",
    },
    {
      "name": "Express Processing",
      "price": 100,
      "desc": "Priority processing queue",
    },
  ];

  int get totalPrice {
    int itemTotal = cart.entries.fold(
      0,
      (sum, e) =>
          sum +
          e.value *
              (items.firstWhere((i) => i["name"] == e.key)["price"] as int),
    );

    int addonTotal = addons
        .where((a) => selectedAddons.contains(a["name"]))
        .fold(0, (sum, a) => sum + (a["price"] as int));

    return itemTotal + addonTotal;
  }

  void _autoScrollDown() {
    if (selectedMode != -1 && selectedService != -1) {
      setState(() => showItems = true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    }
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
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationCard(),
                  const SizedBox(height: 20),

                  const Text(
                    "Service Mode",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _modeCard(0, Icons.flash_on, "Fast Track"),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _modeCard(1, Icons.access_time, "Standard"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  _serviceCards(),
                  const SizedBox(height: 20),

                  const Text(
                    "Service Type",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  _categoryChips(),
                  const SizedBox(height: 12),

                  ..._itemsList(),
                  const SizedBox(height: 20),

                  const Text(
                    "Add-ons",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  ..._addonList(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          _bottomBar(),
        ],
      ),
    );
  }

  Widget _serviceCards() {
    List<Map<String, String>> services = [
      {"title": "Wash & Iron", "subtitle": "Complete care"},
      {"title": "Iron Only", "subtitle": "Crisp finish"},
      {"title": "Dry Clean", "subtitle": "Premium care"},
      {"title": "Wash & Fold", "subtitle": "Quick service"},
    ];

    final icons = [
      Icons.local_laundry_service,
      Icons.iron,
      Icons.dry_cleaning,
      Icons.checkroom,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (_, i) {
        final s = services[i];

        return GestureDetector(
          onTap: () {
            setState(() => selectedService = i);
            _autoScrollDown();
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selectedService == i
                    ? const Color(0xff0D47A1)
                    : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),

            /// Stack added for tick
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xff0D47A1),
                      child: Icon(icons[i], color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      s["title"]!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      s["subtitle"]!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                /// Tick icon when selected
                if (selectedService == i)
                  const Positioned(
                    right: 0,
                    top: 0,
                    child: Icon(Icons.check_circle, color: Color(0xff0D47A1)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _locationCard() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ),
    child: const Row(
      children: [
        Icon(Icons.location_on, color: Color(0xff0D47A1)),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pickup & Delivery Address"),
              SizedBox(height: 4),
              Text(
                "Mega Hills, 18, Hyderabad",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios, size: 16),
      ],
    ),
  );

  Widget _modeCard(int index, IconData icon, String title) => GestureDetector(
    onTap: () {
      setState(() => selectedMode = index);
      _autoScrollDown();
    },
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selectedMode == index
              ? const Color(0xff0D47A1)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text(
                "Same-day delivery,\nno add-ons",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          if (selectedMode == index)
            const Positioned(
              right: 0,
              top: 0,
              child: Icon(Icons.check_circle, color: Color(0xff0D47A1)),
            ),
        ],
      ),
    ),
  );

  Widget _categoryChips() {
    List<String> cats = ["Clothing", "Household", "Specialty"];

    return Row(
      children: List.generate(cats.length, (i) {
        bool active = selectedCategory == i;

        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => setState(() => selectedCategory = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: active ? Colors.blue.shade50 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active ? Colors.blue : Colors.grey.shade300,
                ),
              ),
              child: Text(cats[i]),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _itemsList() {
    return items.map((item) {
      int qty = cart[item["name"]] ?? 0;

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.checkroom),
            const SizedBox(width: 12),
            Expanded(child: Text(item["name"])),

            /// ADD BUTTON
            qty == 0
                ? GestureDetector(
                    onTap: () => setState(() => cart[item["name"]] = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white, // white before adding
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xff013E6D)),
                      ),
                      child: const Text(
                        "+ Add",
                        style: TextStyle(color: Color(0xff013E6D)),
                      ),
                    ),
                  )
                /// QUANTITY CONTROLS
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xff013E6D), // blue after add
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              if (qty == 1) {
                                cart.remove(item["name"]);
                              } else {
                                cart[item["name"]] = qty - 1;
                              }
                            });
                          },
                        ),
                        Text(
                          "$qty",
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () =>
                              setState(() => cart[item["name"]] = qty + 1),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _addonList() {
    return addons.map((addon) {
      bool selected = selectedAddons.contains(addon["name"]);

      return GestureDetector(
        onTap: () {
          setState(() {
            selected
                ? selectedAddons.remove(addon["name"])
                : selectedAddons.add(addon["name"]);
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? const Color(0xff013E6D) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              /// LEFT ICON CHANGES
              selected
                  ? const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xff013E6D),
                      child: Icon(Icons.check, size: 16, color: Colors.white),
                    )
                  : const Icon(Icons.add_circle_outline),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(addon["name"]),
                    const SizedBox(height: 2),
                    Text(
                      addon["desc"],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Text("+ ₹${addon["price"]}"),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _bottomBar() {
    return Container(
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
    );
  }
}
