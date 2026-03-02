enum NotificationType { order, payment, offer, reminder, system }

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime dateTime;
  final bool isRead;
  final NotificationType type;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.isRead,
    required this.type,
  });
}
