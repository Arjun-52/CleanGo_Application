import 'package:clean_go/features/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'active_order_card.dart';
import 'fast_track_banner.dart';
import 'home_header.dart';
import 'service_tile.dart';

import 'package:clean_go/features/auth/providers/auth_provider.dart';
import 'package:clean_go/features/orders/providers/order_provider.dart';
import 'package:clean_go/features/orders/screens/new_order_screen.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final orderProvider = context.watch<OrderProvider>();

    final userName = authProvider.user?.name ?? "User";

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Hello, $userName!",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Fresh clothes, delivered with care",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const FastTrackBanner(),
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Active Order",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 12),

            ActiveOrderCard(
              order: orderProvider.activeOrders.isNotEmpty
                  ? orderProvider.activeOrders.first
                  : OrderModel(
                      id: "CLN-2026-001",
                      userId: "1",
                      items: [],
                      totalAmount: 0,
                      status: OrderStatus.processing,
                      deliveryTime: DateTime.now(),
                      createdAt: DateTime.now(),
                    ),
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                padding: const EdgeInsets.all(12),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
                children: [
                  ServiceTile(
                    title: "Wash & Iron",
                    subtitle: "Complete care",
                    icon: Icons.checkroom,
                    iconColor: const Color(0xff1E8E7E),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewOrderScreen(
                            serviceName: "Wash & Iron",
                            isFastTrack: false,
                          ),
                        ),
                      );
                    },
                  ),

                  ServiceTile(
                    title: "Iron Only",
                    subtitle: "Crisp finish",
                    icon: Icons.iron,
                    iconColor: const Color(0xffF4A300),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewOrderScreen(
                            serviceName: "Iron Only",
                            isFastTrack: false,
                          ),
                        ),
                      );
                    },
                  ),

                  ServiceTile(
                    title: "Dry Clean",
                    subtitle: "Premium care",
                    icon: Icons.auto_awesome,
                    iconColor: const Color(0xff0B3C5D),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewOrderScreen(
                            serviceName: "Dry Clean",
                            isFastTrack: false,
                          ),
                        ),
                      );
                    },
                  ),

                  ServiceTile(
                    title: "Wash & Fold",
                    subtitle: "Quick service",
                    icon: Icons.local_laundry_service,
                    iconColor: const Color(0xff0B3C5D),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewOrderScreen(
                            serviceName: "Wash & Fold",
                            isFastTrack: true,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
