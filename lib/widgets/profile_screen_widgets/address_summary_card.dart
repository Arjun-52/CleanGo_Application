import 'package:flutter/material.dart';

class AddressSummaryCard extends StatelessWidget {
  const AddressSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff0B3C5D).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Plot no.209, Kavuri Hills, Madhapur, Telangana 500033",
            style: TextStyle(fontSize: 14, color: Color(0xff1F2A44)),
          ),
          SizedBox(height: 4),
          Text(
            "Ph: +91234567890",
            style: TextStyle(fontSize: 12, color: Color(0xff64748B)),
          ),
        ],
      ),
    );
  }
}
