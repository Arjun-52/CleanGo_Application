import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_go/features/orders/presentation/screens/order_details_screen.dart';
import 'package:clean_go/core/constants/colors.dart';
import 'package:clean_go/features/orders/presentation/providers/order_provider.dart';
import 'package:clean_go/features/orders/presentation/widgets/order_card.dart';
import 'package:clean_go/features/orders/data/models/order_model.dart';

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

  /// Convert enum → UI text
  String _getStatusText(OrderStatus? status) {
    switch (status) {
      case OrderStatus.processing:
      case OrderStatus.inProgress:
      case OrderStatus.pickedUp:
        return "On Track";

      case OrderStatus.delivered:
        return "Breached";

      case OrderStatus.cancelled:
        return "Breached";

      default:
        return "Processing";
    }
  }

  /// Format Date
  String _formatDate(DateTime? date) {
    if (date == null) return "";

    return "${date.day} ${_month(date.month)}, ${_formatTime(date)}";
  }

  String _month(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[m - 1];
  }

  String _formatTime(DateTime d) {
    int hour = d.hour > 12 ? d.hour - 12 : d.hour;
    String period = d.hour >= 12 ? "PM" : "AM";
    String minute = d.minute.toString().padLeft(2, '0');

    return "$hour:$minute $period";
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
                  orderId: order.id ?? '',
                  status: _getStatusText(order.status),
                  date: _formatDate(order.createdAt),
                  amount: "₹${order.totalAmount?.toInt() ?? 0}",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            OrderDetailsScreen(orderId: order.id ?? ''),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
