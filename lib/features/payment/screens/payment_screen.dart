import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/orders/screens/order_placed_screen.dart';

import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedUpi = 0;

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

            /// WALLET CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xff013E6D), width: 1.5),
              ),
              child: Row(
                children: [
                  /// Icon left
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xff013E6D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: AppColors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Wallet text
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wallet",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "Balance : ₹250",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  /// Tick
                  const Icon(Icons.check_circle, color: Color(0xff013E6D)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PAYMENT OPTIONS GROUP
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                children: [
                  _upiOption(0, Icons.account_balance, "Paytm"),
                  const Divider(height: 1),

                  _upiOption(1, Icons.account_balance_wallet, "PhonePe"),
                  const Divider(height: 1),

                  _upiOption(2, Icons.account_balance, "GPay"),
                  const Divider(height: 1),

                  _addUpiRow(),
                ],
              ),
            ),

            const Spacer(),

            /// PAY BUTTON
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

  /// ---------- UPI OPTIONS ----------
  Widget _upiOption(int index, IconData icon, String name) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Radio(
        value: index,
        groupValue: selectedUpi,
        activeColor: const Color(0xff013E6D),
        onChanged: (val) {
          setState(() => selectedUpi = val!);
        },
      ),
      title: Row(
        children: [Icon(icon, size: 22), const SizedBox(width: 12), Text(name)],
      ),
      onTap: () {
        setState(() => selectedUpi = index);
      },
    );
  }

  /// ---------- ADD UPI ROW ----------
  Widget _addUpiRow() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: const Icon(Icons.add_card),
      title: const Text("Add UPI ID"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
