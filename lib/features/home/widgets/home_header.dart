import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_go/features/home/screens/notification_screen.dart';
import 'package:clean_go/features/location/providers/location_provider.dart';
import 'package:clean_go/features/location/models/address_model.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  void _showAddressSelector(BuildContext context) {
    final locationProvider = context.read<LocationProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<LocationProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.addresses.isEmpty) {
                return const Center(child: Text("No saved addresses"));
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  ...provider.addresses.map((AddressModel address) {
                    final isSelected =
                        provider.selectedAddress?.id == address.id;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(address.fullAddress ?? "Unknown address"),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        locationProvider.selectAddress(address);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();

    final selectedAddress =
        locationProvider.selectedAddress?.fullAddress ?? "Select Address";

    return Container(
      height: 69,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Address Section
          Row(
            children: [
              const Icon(Icons.home_outlined),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _showAddressSelector(context),
                    child: const Row(
                      children: [
                        Text(
                          "Home",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    selectedAddress,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          /// Notification Icon
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            child: Stack(
              children: [
                const Icon(Icons.notifications_none, size: 26),
                Positioned(
                  right: 3,
                  top: 3,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
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
