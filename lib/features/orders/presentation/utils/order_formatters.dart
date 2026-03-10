import '../../domain/entities/order_entity.dart';

String getOrderStatusText(OrderStatus? status) {
  switch (status) {
    case OrderStatus.pending:
      return "Pending";
    case OrderStatus.confirmed:
      return "Confirmed";
    case OrderStatus.pickedUp:
      return "Picked Up";
    case OrderStatus.inProgress:
      return "Processing";
    case OrderStatus.outForDelivery:
      return "Out for Delivery";
    case OrderStatus.delivered:
      return "Delivered";
    case OrderStatus.cancelled:
      return "Cancelled";
    case OrderStatus.processing:
      return "Processing";
    case OrderStatus.completed:
      return "Completed";
    default:
      return "Unknown";
  }
}

String formatTime(DateTime? dateTime) {
  if (dateTime == null) return "";
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

String formatDate(DateTime? dateTime) {
  if (dateTime == null) return "";

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

  return "${months[dateTime.month - 1]} ${dateTime.day}";
}
