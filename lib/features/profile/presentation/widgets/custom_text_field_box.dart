import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldBox extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final TextInputType keyboardType;

  const CustomTextFieldBox({
    super.key,
    required this.controller,
    this.labelText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
