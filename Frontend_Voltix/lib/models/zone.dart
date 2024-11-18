import '../../models/building.dart';

class Zone {
  final String? id;
  final String? zoneName;
  final String? zoneSurface;
  final String? zoneMainActivity;
  final List<String>? attendanceDays;
  final String? workStartTime;
  final String? workEndTime;
  final String? buildingId;

  Zone({
    this.id,
    this.zoneName,
    this.zoneSurface,
    this.zoneMainActivity,
    this.attendanceDays,
    this.workStartTime,
    this.workEndTime,
    this.buildingId,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'] as String? ?? '',
      zoneName: json['zoneName'] as String,
      zoneSurface: json['zoneSurface'] as String,
      zoneMainActivity: json['zoneMainActivity'] as String,
      attendanceDays:
          (json['attendanceDays'] as List<dynamic>?)?.cast<String>() ?? [],
      workStartTime: json['workStartTime'] as String? ?? '',
      workEndTime: json['workEndTime'] as String? ?? '',
      buildingId: json['buildingId'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'zoneName': zoneName,
      'zoneSurface': zoneSurface,
      'zoneMainActivity': zoneMainActivity,
      'attendanceDays': attendanceDays,
      'workStartTime': workStartTime,
      'workEndTime': workEndTime,
      'buildingId': buildingId,
    };
  }
}
