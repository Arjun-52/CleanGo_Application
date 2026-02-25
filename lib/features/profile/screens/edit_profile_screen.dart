import 'package:flutter/material.dart';
import '../../../widgets/bottom_navbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'John Kevin');
  final _emailController = TextEditingController(text: 'johnkevin@gmail.com');
  final _phoneController = TextEditingController(text: '+91 9123456789');
  final int _currentIndex = 2;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Profile Picture
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff0B3C5D),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 40),

            /// Full Name Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(color: Color(0xff64748B), fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xff1F2A44)),
              ),
            ),

            const SizedBox(height: 20),

            /// Mobile Number Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  labelStyle: TextStyle(color: Color(0xff64748B), fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xff1F2A44)),
                keyboardType: TextInputType.phone,
              ),
            ),

            const SizedBox(height: 20),

            /// Email Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Enter Email",
                  labelStyle: TextStyle(color: Color(0xff64748B), fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xff1F2A44)),
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            const SizedBox(height: 40),

            /// Save Changes Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0B3C5D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
