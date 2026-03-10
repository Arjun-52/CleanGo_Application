import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/orders/presentation/screens/order_placed_screen.dart';
import 'package:clean_go/features/payment/presentation/widgets/add_upi_row.dart';
import 'package:clean_go/features/payment/presentation/widgets/upi_option_tile.dart';

import 'package:clean_go/features/wallet/presentation/widgets/wallet_card.dart';

import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedUpi = 0;

  /// UPI options list
  final List<Map<String, String>> upiOptions = [
    {"name": "Paytm", "icon": "assets/images/paytm.png"},
    {"name": "PhonePe", "icon": "assets/images/phonepe.png"},
    {"name": "GPay", "icon": "assets/images/gpay.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
        title: const Text("Payment", style: TextStyle(color: Colors.black)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 14),

            /// Wallet Card
            const WalletCard(balance: "250"),

            const SizedBox(height: 20),

            /// UPI Options Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                children: [
                  /// Generate UPI options
                  ...List.generate(upiOptions.length, (index) {
                    return Column(
                      children: [
                        UpiOptionTile(
                          index: index,
                          selectedIndex: selectedUpi,
                          name: upiOptions[index]["name"]!,
                          iconPath: upiOptions[index]["icon"]!,
                          onSelect: (val) {
                            setState(() {
                              selectedUpi = val;
                            });
                          },
                        ),
                        if (index != upiOptions.length - 1)
                          const Divider(height: 1),
                      ],
                    );
                  }),

                  const Divider(height: 1),

                  /// Add UPI row
                  AddUpiRow(
                    onTap: () {
                      print("Add UPI clicked");
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// Pay Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const OrderPlacedScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text("Pay ₹95", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
