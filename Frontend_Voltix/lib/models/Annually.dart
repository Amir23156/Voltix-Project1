class Annually {
  final String id;
  final List<String> hours;
  final List<double> values;
  final String zoneId;
  final String zoneName;

  Annually({
    required this.id,
    required this.hours,
    required this.values,
    required this.zoneId,
    required this.zoneName,
  });

  factory Annually.fromJson(Map<String, dynamic> json) {
    return Annually(
      id: json['id'] as String? ?? '',
      hours: List<String>.from(json['hours']),
      values: List<double>.from(json['values'].map((value) => value.toDouble())),
      zoneId: json['zone']['id'] as String? ?? '',
      zoneName: json['zone']['zoneName'] as String? ?? '',
    );
  }
}
