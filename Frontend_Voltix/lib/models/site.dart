class Site {
  final String siteName;
  final String siteLocation;

  Site({
    required this.siteName,
    required this.siteLocation,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      siteName: json['siteName'],
      siteLocation: json['siteLocation'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'siteName': siteName, 'siteLocation': siteLocation};
  }
}
