import 'package:flutter/material.dart';
import 'package:clean_go/features/home/models/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Dummy Data (All Categories Included)
  List<AppNotification> get notifications => [
    // ORDER
    AppNotification(
      id: "1",
      title: "Order Confirmed",
      message: "Your laundry order #1234 has been confirmed.",
      dateTime: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: false,
      type: NotificationType.order,
    ),

    AppNotification(
      id: "2",
      title: "Out for Delivery",
      message: "Your clothes are out for delivery.",
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      type: NotificationType.order,
    ),

    // PAYMENT
    AppNotification(
      id: "3",
      title: "Payment Successful",
      message: "₹499 payment completed successfully.",
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      type: NotificationType.payment,
    ),

    // OFFER
    AppNotification(
      id: "4",
      title: "20% Off Dry Cleaning",
      message: "Limited time offer on premium dry cleaning.",
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      type: NotificationType.offer,
    ),

    // REMINDER
    AppNotification(
      id: "5",
      title: "Laundry Reminder",
      message: "It's been 2 weeks since your last wash.",
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
      type: NotificationType.reminder,
    ),

    // SYSTEM
    AppNotification(
      id: "6",
      title: "Password Changed",
      message: "Your account password was updated successfully.",
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      isRead: true,
      type: NotificationType.system,
    ),
  ];

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.local_laundry_service;
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.offer:
        return Icons.local_offer;
      case NotificationType.reminder:
        return Icons.access_time;
      case NotificationType.system:
        return Icons.settings;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Colors.blue;
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.offer:
        return Colors.orange;
      case NotificationType.reminder:
        return Colors.purple;
      case NotificationType.system:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    List<AppNotification> todayList = notifications
        .where(
          (n) =>
              n.dateTime.day == today.day &&
              n.dateTime.month == today.month &&
              n.dateTime.year == today.year,
        )
        .toList();

    List<AppNotification> yesterdayList = notifications
        .where(
          (n) =>
              n.dateTime.day == today.subtract(const Duration(days: 1)).day &&
              n.dateTime.month ==
                  today.subtract(const Duration(days: 1)).month &&
              n.dateTime.year == today.subtract(const Duration(days: 1)).year,
        )
        .toList();

    List<AppNotification> olderList = notifications
        .where(
          (n) => n.dateTime.isBefore(today.subtract(const Duration(days: 1))),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (todayList.isNotEmpty) _buildSection("Today", todayList),
          if (yesterdayList.isNotEmpty)
            _buildSection("Yesterday", yesterdayList),
          if (olderList.isNotEmpty) _buildSection("Older", olderList),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<AppNotification> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...list.map((notification) => _buildCard(notification)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCard(AppNotification notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.white
            : Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: _getIconColor(notification.type).withOpacity(0.15),
            child: Icon(
              _getIcon(notification.type),
              color: _getIconColor(notification.type),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notification.message,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
