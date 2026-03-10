import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_go/features/home/data/models/notification_model.dart';
import 'package:clean_go/features/home/presentation/providers/notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
    final provider = Provider.of<NotificationProvider>(context);

    final todayList = provider.todayNotifications;
    final yesterdayList = provider.yesterdayNotifications;
    final olderList = provider.olderNotifications;

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
