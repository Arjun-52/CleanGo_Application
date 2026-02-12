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
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff1E3A8A), Color(0xff3B82F6)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  /// Card Pattern
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),

                  /// Card Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        /// Wallet Icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),

                        const Spacer(),

                        /// Available Balance
                        const Text(
                          "Available Balance",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "₹250.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.white54),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(Icons.add, size: 20),
                                label: const Text("Add Money"),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.white54),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ),
                                label: const Text("Redeem"),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// Card Number
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.credit_card,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                "•••• •••• •••• 4532",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
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
                          "Added to Wallet",
                          "05 Feb 2026",
                          "+₹100.00",
                          Colors.green,
                          Icons.add_circle_outline,
                        ),
                        _transactionItem(
                          "Order Payment",
                          "04 Feb 2026",
                          "-₹50.00",
                          Colors.red,
                          Icons.remove_circle_outline,
                        ),
                        _transactionItem(
                          "Added to Wallet",
                          "03 Feb 2026",
                          "+₹200.00",
                          Colors.green,
                          Icons.add_circle_outline,
                        ),
                        _transactionItem(
                          "Order Payment",
                          "02 Feb 2026",
                          "-₹75.00",
                          Colors.red,
                          Icons.remove_circle_outline,
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
