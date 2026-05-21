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
  }
  );

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'totalSlots': totalSlots,
      'occupiedSlots': occupiedSlots,
      'availableSlots': availableSlots,
      'area': area,
      'slotDetails': slotDetails,
    
    };
  }

  factory CityParking.fromJson(Map<String, dynamic> json) {
    return CityParking(
      cityName: json['cityName'] as String,
      totalSlots: json['totalSlots'] as int,
      occupiedSlots: json['occupiedSlots'] as int,
      availableSlots: json['availableSlots'] as int,
      area: List<String>.from(json['area']),
      slotDetails: (json['slotDetails'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, (value as Map<String, dynamic>).map((k, v) => MapEntry(int.parse(k), v as bool)))),
    );
  }
}