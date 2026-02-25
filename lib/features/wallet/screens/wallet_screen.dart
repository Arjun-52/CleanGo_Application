import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Wallet",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          /// Wallet Card
          Container(
            height: 270,
            child: Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ///
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff1E3A8A), Color(0xff3B82F6)],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Available Balance",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "₹250",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          /// Add Money
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xff1E3A8A),
                                side: const BorderSide(
                                  color: Color(0xff1E3A8A),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text("Add Money"),
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// Redeem
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xff1E3A8A),
                                side: const BorderSide(
                                  color: Color(0xff1E3A8A),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              icon: const Icon(Icons.card_giftcard),
                              label: const Text("Redeem"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Transactions Section
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),

                  /// Transaction List
                  Expanded(
                    child: ListView(
                      children: [
                        _transactionItem(
                          "Order Payment",
                          "Jan 08, 4:00 PM",
                          "-₹100.00",
                          Colors.red,
                          Icons.north_east,
                        ),
                        _transactionItem(
                          "Wallet Recharge",
                          "Jan 06, 11:06 AM",
                          "+₹300.00",
                          Colors.green,
                          Icons.south_west,
                        ),
                        _transactionItem(
                          "Order Payment",
                          "Jan 08, 4:00 PM",
                          "-₹100.00",
                          Colors.red,
                          Icons.north_east,
                        ),
                        _transactionItem(
                          "Order Payment",
                          "Jan 08, 4:00 PM",
                          "-₹100.00",
                          Colors.red,
                          Icons.north_east,
                        ),
                        _transactionItem(
                          "Wallet Recharge",
                          "Jan 08, 4:00 PM",
                          "+₹250.00",
                          Colors.green,
                          Icons.south_west,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(
    String title,
    String date,
    String amount,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
