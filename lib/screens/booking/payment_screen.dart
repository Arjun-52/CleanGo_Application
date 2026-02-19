import 'package:clean_go/screens/orders/order_placed_screen.dart';
import 'package:clean_go/widgets/add_upi_row.dart';
import 'package:clean_go/widgets/upi_option_tile.dart';
import 'package:clean_go/widgets/wallet_card.dart';
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 16),

            /// Wallet
            const WalletCard(balance: "250"),

            const SizedBox(height: 20),

            /// UPI Section
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

                  UpiOptionTile(
                    index: 0,
                    selectedIndex: selectedUpi,
                    name: "Paytm",
                    onSelect: (val) {
                      setState(() => selectedUpi = val);
                    },
                  ),
                  const Divider(),

                  UpiOptionTile(
                    index: 1,
                    selectedIndex: selectedUpi,
                    name: "PhonePe",
                    onSelect: (val) {
                      setState(() => selectedUpi = val);
                    },
                  ),
                  const Divider(),

                  UpiOptionTile(
                    index: 2,
                    selectedIndex: selectedUpi,
                    name: "GPay",
                    onSelect: (val) {
                      setState(() => selectedUpi = val);
                    },
                  ),
                  const Divider(),

                  AddUpiRow(onTap: () {}),
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
}
