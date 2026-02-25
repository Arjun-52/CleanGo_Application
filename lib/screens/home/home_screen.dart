import 'package:flutter/material.dart';
import 'home_content.dart';
import '../../features/orders/screens/order_tracking_screen.dart';
import '../../features/orders/screens/new_order_screen.dart';
import '../../../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeContent(),
    NewOrderScreen(),
    OrderTrackingScreen(),
    Center(child: Text("Wallet")),
    Center(child: Text("Profile")),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
