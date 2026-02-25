import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'saved_addresses_screen.dart';
import '../../../screens/orders/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
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

            /// Profile Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff0B3C5D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                title: const Text(
                  "John Kevin",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xff1F2A44),
                  ),
                ),
                subtitle: const Text(
                  "johnkevin@gmail.com",
                  style: TextStyle(fontSize: 14, color: Color(0xff64748B)),
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xff0B3C5D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xff0B3C5D),
                    size: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// Menu Items
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _menuItem(
                    Icons.location_on_outlined,
                    "Saved Addresses",
                    "Manage your pickup & delivery addresses",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SavedAddressesScreen(),
                        ),
                      );
                    },
                  ),
                  _divider(),
                  _menuItem(
                    Icons.receipt_long_outlined,
                    "Order History",
                    "View your past orders",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  _divider(),
                  _menuItem(
                    Icons.notifications_outlined,
                    "Notifications",
                    "Manage notification preferences",
                    () {},
                  ),
                  _divider(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Logout Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xff0B3C5D).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xff0B3C5D), size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
      ),
      trailing: const Icon(Icons.chevron_right, color: Color(0xff0B3C5D)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
    );
  }
}
