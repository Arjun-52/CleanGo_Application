import 'package:flutter/material.dart';

class CustomTextFieldBox extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextFieldBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}
