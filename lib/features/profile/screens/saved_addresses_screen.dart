import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'add_address_sheet.dart';
import '../../../core/common_widgets/bottom_navbar.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final int _currentIndex = 2; // Profile tab active

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
          Container(
            margin: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => AddAddressSheet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffEEF8FF),
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xff0D47A1)),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.add, size: 20, color: Color(0xff0D47A1)),
                label: const Text(
                  "Add address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0D47A1),
                  ),
                ),
              ),
            ),
          ),

          /// Address List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildAddressCard(
                  "Home",
                  "Mega Hills, 18, Madhapur, Hyderabad, 50003",
                  true,
                ),
                const SizedBox(height: 16),
                _buildAddressCard(
                  "Office",
                  "HiTech City, Hyderabad, Telangana",
                  false,
                ),
              ],
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

  Widget _buildAddressCard(String label, String address, bool isDefault) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xff0B3C5D).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.home,
                  color: Color(0xff0B3C5D),
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff1F2A44),
                    ),
                  ),

                  if (isDefault) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff22B573).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Default",
                        style: TextStyle(
                          color: Color(0xff22B573),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              const Spacer(),

              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Color(0xff64748B)),
                onSelected: (value) {},
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'set_default',
                    child: Text("Set Default"),
                  ),
                  PopupMenuItem(value: 'edit', child: Text("Edit")),
                  PopupMenuItem(value: 'delete', child: Text("Delete")),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
