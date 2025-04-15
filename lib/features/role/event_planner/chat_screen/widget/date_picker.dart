import 'package:intl/intl.dart';

class DatePicker {
  static String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('h:mm a').format(date);
  }

  static String formatMessageTime(int timestamp) {
    final now = DateTime.now();
    final messageDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (messageDate.year == now.year &&
        messageDate.month == now.month &&
        messageDate.day == now.day) {
      return DateFormat('h:mm a').format(messageDate);
    }
    final diff = now.difference(messageDate).inDays;
    if (diff < 7) {
      return DateFormat('EEEE').format(messageDate);
    }
    return DateFormat('dd/MM/yyyy').format(messageDate);
  }
}
