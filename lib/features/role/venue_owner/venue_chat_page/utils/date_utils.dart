import 'package:intl/intl.dart';

class ChatDateUtils {
  static String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('HH:mm').format(date);
  }

  static String formatMessageTime(int timestamp) {
    final now = DateTime.now();
    final messageDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // If today, show time
    if (messageDate.year == now.year &&
        messageDate.month == now.month &&
        messageDate.day == now.day) {
      return DateFormat('HH:mm').format(messageDate);
    }

    // If this week, show day name
    final diff = now.difference(messageDate).inDays;
    if (diff < 7) {
      return DateFormat('EEEE').format(messageDate);
    }

    // Otherwise show date
    return DateFormat('dd/MM/yyyy').format(messageDate);
  }
}