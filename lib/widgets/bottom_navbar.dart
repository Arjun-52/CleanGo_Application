import 'package:flutter/material.dart';
import '../core/constants/strings.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: AppStrings.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long),
          label: AppStrings.orders,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          activeIcon: Icon(Icons.location_on),
          label: 'Track',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          activeIcon: Icon(Icons.account_balance_wallet),
          label: AppStrings.wallet,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: AppStrings.profile,
        ),
      ],
    );
  }
}
