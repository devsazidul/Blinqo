class EventAmenity {
  final String id;
  final String name;
  final bool defaultSelected;

  EventAmenity({
    required this.id,
    required this.name,
    required this.defaultSelected,
  });

  factory EventAmenity.fromJson(Map<String, dynamic> json) {
    return EventAmenity(
      id: json['id'],
      name: json['name'],
      defaultSelected: json['default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'default': defaultSelected,
    };
  }
}
