class CityParking {
  String cityName;
  int totalSlots;
  int occupiedSlots;
  int availableSlots;
  List<String> area;
  Map<String, Map<int, bool>> slotDetails;

  CityParking({
    required this.cityName,
    required this.totalSlots,
    required this.occupiedSlots,
    required this.availableSlots,
    required this.area,
    required this.slotDetails,
  });
}