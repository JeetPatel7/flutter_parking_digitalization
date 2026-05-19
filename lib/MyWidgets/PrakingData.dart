class CityParking {
  String cityName;
  int totalSlots;
  int occupiedSlots;
  int availableSlots;
  List<String> address;
  Map<int, bool> slotDetails;

  CityParking({
    required this.cityName,
    required this.totalSlots,
    required this.occupiedSlots,
    required this.availableSlots,
    required this.address,
    required this.slotDetails,
  });
}