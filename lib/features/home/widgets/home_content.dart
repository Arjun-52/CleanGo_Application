import 'active_order_card.dart';
import 'fast_track_banner.dart';
import 'home_header.dart';
import 'package:flutter/material.dart';
import 'service_tile.dart';
import 'package:clean_go/features/orders/screens/new_order_screen.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Hello, John!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
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
            const ActiveOrderCard(),
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
