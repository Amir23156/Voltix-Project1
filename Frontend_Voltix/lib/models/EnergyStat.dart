class EnergyStats {
  final String id;
  final double dailyConsumption;
  final double monthlyConsumption;
  final double annualConsumption;
  final String zoneId;
  final String zoneName; // Add this field to store the zone name

  EnergyStats({
    required this.id,
    required this.dailyConsumption,
    required this.monthlyConsumption,
    required this.annualConsumption,
    required this.zoneId,
    required this.zoneName, // Initialize zone name
  });

  factory EnergyStats.fromJson(Map<String, dynamic> json) {
    return EnergyStats(
      id: json['id'] as String? ?? '',
      dailyConsumption: (json['dailyConsumption'] as num).toDouble(),
      monthlyConsumption: (json['monthlyConsumption'] as num).toDouble(),
      annualConsumption: (json['annualConsumption'] as num).toDouble(),
      zoneId: json['zone']['id'] as String? ?? '',
      zoneName: json['zone']['zoneName'] as String? ?? '', // Get the zone name from the JSON
    );
  }
}
