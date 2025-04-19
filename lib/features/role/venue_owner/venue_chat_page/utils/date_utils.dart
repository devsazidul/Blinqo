// Import intl for formatting dates and times
import 'package:intl/intl.dart';

class ChatDateUtils {
  // Format timestamp as 12-hour time with AM/PM (e.g., "2:30 PM")
  static String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat(
      'h:mm a',
    ).format(date); // Changed from 'HH:mm' to 'h:mm a'
  }

  // Format timestamp based on message date
  static String formatMessageTime(int timestamp) {
    final now = DateTime.now();
    final messageDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // If today, show 12-hour time with AM/PM
    if (messageDate.year == now.year &&
        messageDate.month == now.month &&
        messageDate.day == now.day) {
      return DateFormat(
        'h:mm a',
      ).format(messageDate); // Changed from 'HH:mm' to 'h:mm a'
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
