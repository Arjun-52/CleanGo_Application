import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  final List<AppNotification> _notifications = [
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
    AppNotification(
      id: "3",
      title: "Payment Successful",
      message: "₹499 payment completed successfully.",
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      type: NotificationType.payment,
    ),
    AppNotification(
      id: "4",
      title: "20% Off Dry Cleaning",
      message: "Limited time offer on premium dry cleaning.",
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      type: NotificationType.offer,
    ),
    AppNotification(
      id: "5",
      title: "Laundry Reminder",
      message: "It's been 2 weeks since your last wash.",
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
      type: NotificationType.reminder,
    ),
    AppNotification(
      id: "6",
      title: "Password Changed",
      message: "Your account password was updated successfully.",
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      isRead: true,
      type: NotificationType.system,
    ),
  ];

  List<AppNotification> get notifications => _notifications;

  List<AppNotification> get todayNotifications {
    final today = DateTime.now();
    return _notifications
        .where(
          (n) =>
              n.dateTime.day == today.day &&
              n.dateTime.month == today.month &&
              n.dateTime.year == today.year,
        )
        .toList();
  }

  List<AppNotification> get yesterdayNotifications {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return _notifications
        .where(
          (n) =>
              n.dateTime.day == yesterday.day &&
              n.dateTime.month == yesterday.month &&
              n.dateTime.year == yesterday.year,
        )
        .toList();
  }

  List<AppNotification> get olderNotifications {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return _notifications.where((n) => n.dateTime.isBefore(yesterday)).toList();
  }
}
