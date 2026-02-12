import 'package:clean_go/screens/orders/order_placed_screen.dart';
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
      backgroundColor: const Color(0xffF6F7F9),

      appBar: AppBar(
        backgroundColor: Colors.white,
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

            const SizedBox(height: 16),

            /// -------- WALLET CARD --------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xff013E6D), width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Row(
                children: [
                  /// Wallet icon container
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xff013E6D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
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
                        SizedBox(height: 4),
                        Text(
                          "Balance ₹250",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  /// Tick mark
                  const Icon(Icons.check_circle, color: Color(0xff013E6D)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// -------- UPI SECTION --------
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "UPI",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),

                  _upiOption(0, "Paytm"),
                  const Divider(),

                  _upiOption(1, "PhonePe"),
                  const Divider(),

                  _upiOption(2, "GPay"),
                  const Divider(),

                  _addUpiRow(),
                ],
              ),
            ),

            const Spacer(),

            /// -------- PAY BUTTON --------
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0D47A1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrderPlacedScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Pay ₹95",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// -------- UPI OPTION --------
  Widget _upiOption(int index, String name) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio(
        value: index,
        groupValue: selectedUpi,
        activeColor: const Color(0xff013E6D),
        onChanged: (val) {
          setState(() => selectedUpi = val!);
        },
      ),
      title: Text(name),
      onTap: () {
        setState(() => selectedUpi = index);
      },
    );
  }

  /// -------- ADD UPI --------
  Widget _addUpiRow() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.add_card),
      title: const Text("Add UPI ID"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
