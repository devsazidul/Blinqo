/// Represents a booking entity with details such as event name, venue, date, time, and status.
class Booking {
  final String id;
  final String name;
  final String venue;
  final String date;
  final String time;
  final String status;

  Booking({
    required this.id,
    required this.name,
    required this.venue,
    required this.date,
    required this.time,
    required this.status,
  });
}