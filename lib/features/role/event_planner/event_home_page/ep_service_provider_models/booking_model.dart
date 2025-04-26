class BookingModel {
  final String eventName;
  final String eventPlannerName;
  final String venue;
  final String location;
  final DateTime date;
  final String numberOfGuests;
  final String eventType;
  final String startTime;
  final String endTime;

  BookingModel({
    required this.eventName,
    required this.eventPlannerName,
    required this.venue,
    required this.location,
    required this.date,
    required this.numberOfGuests,
    required this.eventType,
    required this.startTime,
    required this.endTime,
  });
}
