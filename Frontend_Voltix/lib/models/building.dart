class Building {
  final String id;
  final String buildingName;
  final String buildingLocation;

  Building({
    required this.id,
    required this.buildingName,
    required this.buildingLocation,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      id: json['id'] as String? ?? '',
      buildingName: json['buildingName'] as String,
      buildingLocation: json['buildingLocation'] as String,
);
  }

}
