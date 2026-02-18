class SqlModel {
  final int? id;
  final String name;
  final String displayName;
  final double lat;
  final double lon;

  SqlModel({
    this.id,
    required this.name,
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "displayName": displayName,
      "lat": lat,
      "lon": lon,
    };
  }

  factory SqlModel.fromMap(Map<String, dynamic> map) {
    return SqlModel(
      id: map["id"],
      name: map["name"],
      displayName: map["displayName"],
      lat: map["lat"],
      lon: map["lon"],
    );
  }
}
