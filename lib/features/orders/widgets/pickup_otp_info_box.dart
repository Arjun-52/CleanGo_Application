import 'package:flutter/material.dart';

class PickupOtpInfoBox extends StatelessWidget {
  const PickupOtpInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffE3F2FD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xff90CAF9)),
      ),
      child: const Row(
        children: [
          Icon(Icons.sms, color: Color(0xff0D47A1)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "You'll receive pickup OTP via SMS before the pickup slot",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
