import 'package:clean_go/features/orders/presentation/screens/order_placed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_go/features/orders/presentation/providers/new_order_provider.dart';
import 'package:clean_go/features/orders/presentation/providers/states/new_order_state.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedUpi = 0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewOrderProvider>();
    final isCreating = provider.createOrderState is CreateOrderLoading;
    final totalAmount = provider.totalPrice.toInt();

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

            const SizedBox(height: 14),

            /// WALLET CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                color: Colors.white,
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
                  backgroundColor: const Color(0xff0D47A1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isCreating ? null : () async {
                  final orderProvider = context.read<NewOrderProvider>();
                  
                  // Validation
                  const customerId = "1b88ab09-6f39-4893-8880-a7077c8c81fe";
                  const customerName = "Rahul Verma";
                  const storeId = "47d1c382-7fc8-498a-9065-606674158cc3";
                  final itemsCount = orderProvider.totalClothes;
                  final serviceMode = orderProvider.selectedMode == 0 ? "Fasttrack" : "Standard";
                  
                  String serviceType = "Wash & Iron";
                  if (orderProvider.selectedService >= 0 && orderProvider.selectedService < orderProvider.services.length) {
                    serviceType = orderProvider.services[orderProvider.selectedService]["title"] as String? ?? "Wash & Iron";
                  }

                  if (customerId.isEmpty || customerName.isEmpty || storeId.isEmpty || itemsCount <= 0 || serviceMode.isEmpty || serviceType.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Validation Error: Please select items and ensure all details are valid."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final createdOrder = await orderProvider.createOrder(
                    customerId: customerId,
                    customerName: customerName,
                    itemsCount: itemsCount,
                    serviceMode: serviceMode,
                    serviceType: serviceType,
                    storeId: storeId,
                  );

                  if (createdOrder != null && mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => OrderPlacedScreen(order: createdOrder),
                      ),
                      (route) => false,
                    );
                  } else if (mounted) {
                    final errorMsg = orderProvider.createOrderState is CreateOrderError
                        ? (orderProvider.createOrderState as CreateOrderError).message
                        : "Failed to create order";
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMsg),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: isCreating
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        "Pay ₹$totalAmount",
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///  UPI OPTIONS
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

  /// ADD UPI ROW
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
