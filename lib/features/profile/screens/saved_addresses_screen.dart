import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/core/common_widgets/bottom_navbar.dart';

import '../widgets/address_summary_card.dart';
import '../widgets/bottom_primary_button.dart';
import 'add_address_sheet.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final int _currentIndex = 2;

  final List<Map<String, dynamic>> addresses = [
    {
      "label": "Home",
      "address": "Mega Hills, 18, Madhapur, Hyderabad, 50003",
      "isDefault": true,
    },
    {"label": "Home", "address": "Kondapur, 21, Hyderabad", "isDefault": false},
  ];

  /// Open Add Address Bottom Sheet
  void _openAddAddressSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddAddressSheet(),
    );
  }

  /// Handle popup menu actions
  void _handleMenuAction(String action, int index) {
    if (action == "set_default") {
      setState(() {
        for (var address in addresses) {
          address["isDefault"] = false;
        }
        addresses[index]["isDefault"] = true;
      });
    }

    if (action == "delete") {
      setState(() {
        addresses.removeAt(index);
      });
    }

    if (action == "edit") {
      _openAddAddressSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Saved Addresses",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          /// Add Address Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: BottomPrimaryButton(
              text: "Add address",
              icon: Icons.add,
              onPressed: _openAddAddressSheet,
              backgroundColor: const Color(0xffEEF8FF),
              textColor: const Color(0xff0D47A1),
              borderColor: const Color(0xff0D47A1),
            ),
          ),

          /// Address List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AddressSummaryCard(
                    label: address["label"],
                    address: address["address"],
                    isDefault: address["isDefault"],

                    /// Popup menu action
                    onMenuSelected: (value) {
                      _handleMenuAction(value, index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      /// Bottom Navigation
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
