class Review {
  final String userName;
  final double rating;
  final String comment;
  final int timestamp; // Store date as a Unix timestamp (milliseconds)

  Review({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  String get displayDate {
    // Convert timestamp to DateTime
    DateTime reviewDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));

    // Check if the review date is today
    if (reviewDate.year == today.year &&
        reviewDate.month == today.month &&
        reviewDate.day == today.day) {
      return "Today";
    }
    // Check if the review date is yesterday
    if (reviewDate.year == yesterday.year &&
        reviewDate.month == yesterday.month &&
        reviewDate.day == yesterday.day) {
      return "Yesterday";
    }
    // Otherwise, return the date in local format (MM/dd/yyyy)
    return "${reviewDate.month.toString().padLeft(2, '0')}/${reviewDate.day.toString().padLeft(2, '0')}/${reviewDate.year}";
  }
}
