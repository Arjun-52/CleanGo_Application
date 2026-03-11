import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/profile/presentation/widgets/profile_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';
import '../widgets/logout_button.dart';
import './edit_profile_screen.dart';
import './saved_addresses_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// PROFILE CARD
            GestureDetector(
              onTap: () {
                context.go('/main/edit-profile');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFF0B3C5D),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "John Kevin",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "johnkevin@gmail.com",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// SAVED ADDRESSES
            ProfileMenuCard(
              icon: Icons.location_on_outlined,
              title: "Saved Addresses",
              onTap: () {
                context.go('/main/saved-addresses');
              },
            ),

            /// ORDER HISTORY
            ProfileMenuCard(
              icon: Icons.receipt_long_outlined,
              title: "Order History",
              onTap: () {
                context.go('/main/order-history');
              },
            ),

            const SizedBox(height: 24),

            LogoutButton(
              onTap: () {
                context.goLogin();
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
