import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';

class OrderSuccessIcon extends StatelessWidget {
  const OrderSuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffD7F2E3),
      ),
      child: const CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xff22B573),
        child: Icon(Icons.check, color: AppColors.white, size: 40),
      ),
    );
  }
}
