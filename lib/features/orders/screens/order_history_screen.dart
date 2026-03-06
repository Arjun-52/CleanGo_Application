import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/orders/providers/order_provider.dart';
import 'package:clean_go/features/orders/widgets/order_card.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderProvider>().loadPastOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Order History",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
      ),

      body: Builder(
        builder: (_) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (provider.pastOrders.isEmpty) {
            return const Center(child: Text("No past orders"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.pastOrders.length,
            itemBuilder: (context, index) {
              final order = provider.pastOrders[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OrderCard(
                  order: order,
                  orderId: '',
                  status: '',
                  date: '',
                  amount: '',
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
