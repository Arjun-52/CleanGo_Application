import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/bottom_navbar.dart';
import '../widgets/custom_text_field_box.dart';
import '../widgets/bottom_primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: "John Kevin");
  final _emailController = TextEditingController(text: "johnkevin@gmail.com");
  final _phoneController = TextEditingController(text: "+91 9123456789");

  final int _currentIndex = 2;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: AppColors.white,
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
            /// Profile Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff0B3C5D),
                border: Border.all(color: AppColors.white, width: 4),
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

            /// Name Field
            CustomTextFieldBox(
              controller: _nameController,
              labelText: "Full Name",
            ),

            const SizedBox(height: 20),

            /// Phone Field
            CustomTextFieldBox(
              controller: _phoneController,
              labelText: "Mobile Number",
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 20),

            /// Email Field
            CustomTextFieldBox(
              controller: _emailController,
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 40),

            /// Save Button
            BottomPrimaryButton(text: "Save Changes", onPressed: _saveProfile),

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
