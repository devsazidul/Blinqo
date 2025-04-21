class Amenity {
  final String name;
  final String icon;

  const Amenity({required this.name, required this.icon});
}

mixin Amenities {
  final List<Amenity> amenitiesList = const [
    Amenity(name: "Wifi", icon: "assets/icons/wifi.png"),
    Amenity(name: "Parking", icon: "assets/icons/bike_dock.png"),
    Amenity(name: "AC", icon: "assets/icons/mode_fan.png"),
    Amenity(name: "Pool", icon: "assets/icons/pool.png"),
  ];
}
