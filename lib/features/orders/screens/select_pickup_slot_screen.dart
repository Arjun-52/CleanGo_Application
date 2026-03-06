import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'order_review_screen.dart';
import '../../../core/common_widgets/bottom_navbar.dart';

import '../widgets/pickup_date_card.dart';
import '../widgets/pickup_slot_card.dart';
import '../widgets/pickup_slot_bottom_bar.dart';

class SelectPickupSlotScreen extends StatefulWidget {
  const SelectPickupSlotScreen({super.key});

  @override
  State<SelectPickupSlotScreen> createState() => _SelectPickupSlotScreenState();
}

class _SelectPickupSlotScreenState extends State<SelectPickupSlotScreen> {
  int selectedDate = 0;
  int selectedSlot = 0;
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
      backgroundColor: AppColors.scaffoldBackground,

      appBar: AppBar(
        backgroundColor: AppColors.white,
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
                        return PickupDateCard(
                          day: dates[index]["day"]!,
                          date: dates[index]["date"]!,
                          selected: selectedDate == index,
                          onTap: () => setState(() => selectedDate = index),
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
                      return PickupSlotCard(
                        time: slots[index]["time"]!,
                        slotsLeft: slots[index]["left"]!,
                        selected: selectedSlot == index,
                        onTap: () => setState(() => selectedSlot = index),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          PickupSlotBottomBar(
            time: slots[selectedSlot]["time"]!,
            onNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderReviewScreen()),
              );
            },
          ),
        ],
      ),

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
