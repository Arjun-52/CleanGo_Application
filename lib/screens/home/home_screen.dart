import 'package:flutter/material.dart';
import '../../widgets/home_header.dart';
import '../../widgets/fast_track_banner.dart';
import '../../widgets/active_order_card.dart';
import '../../widgets/service_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomeHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Hello, John!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Fresh clothes, delivered with care",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              FastTrackBanner(),
              SizedBox(height: 20),
              ActiveOrderCard(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
