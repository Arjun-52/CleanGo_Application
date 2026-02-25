import 'package:flutter/material.dart';
import 'order_review_screen.dart';
import '../../../widgets/bottom_navbar.dart';

class SelectPickupSlotScreen extends StatefulWidget {
  const SelectPickupSlotScreen({super.key});

  @override
  State<SelectPickupSlotScreen> createState() => _SelectPickupSlotScreenState();
}

class _SelectPickupSlotScreenState extends State<SelectPickupSlotScreen> {
  int selectedDate = 0;
  int selectedSlot = 0;

  // Bottom nav selected index (Track tab)
  int _currentIndex = 2;

  final dates = [
    {"day": "Today", "date": "01 Jan"},
    {"day": "Tomorrow", "date": "02 Jan"},
    {"day": "Saturday", "date": "03 Jan"},
    {"day": "Sunday", "date": "04 Jan"},
  ];

  final slots = [
    {"time": "09:00 - 11:00", "left": "3 slots left"},
    {"time": "11:00 - 13:00", "left": "3 slots left"},
    {"time": "14:00 - 16:00", "left": "4 slots left"},
    {"time": "16:00 - 18:00", "left": "2 slots left"},
    {"time": "18:00 - 20:00", "left": "1 slot left"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Select Pickup Slot",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Date",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        bool selected = selectedDate == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedDate = index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: selected
                                    ? const Color(0xff0D47A1)
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(dates[index]["day"]!),
                                const SizedBox(height: 4),
                                Text(
                                  dates[index]["date"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Available Slots",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: slots.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 70,
                        ),
                    itemBuilder: (context, index) {
                      bool selected = selectedSlot == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedSlot = index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xff0D47A1)
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                slots[index]["left"]!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                slots[index]["time"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          /// Bottom button
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
                    "Pickup: ${slots[selectedSlot]["time"]}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderReviewScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0D47A1),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// Bottom navigation added here
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
