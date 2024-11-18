class Daily {
  final String id;
  final List<String> hours;
  final List<double> values;
  final String zoneId;
  final String zoneName;

  Daily({
    required this.id,
    required this.hours,
    required this.values,
    required this.zoneId,
    required this.zoneName,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      id: json['id'] as String? ?? '',
      hours: List<String>.from(json['hours']),
      values: List<double>.from(json['values'].map((value) => value.toDouble())),
      zoneId: json['zone']['id'] as String? ?? '',
      zoneName: json['zone']['zoneName'] as String? ?? '',
    );
  }
}
