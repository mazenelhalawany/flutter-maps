import 'package:latlong2/latlong.dart';

class PlaceModel {
  final int placeId;
  final String name;
  final String displayName;
  final double lat;
  final double lon;

  PlaceModel({
    required this.placeId,
    required this.name,
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      placeId: json['place_id'],
      name: json['name'] ?? "",
      displayName: json['display_name'] ?? "",
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}

class RouteModel {
  final double distance;
  final double duration;
  final List<LatLng> points;

  RouteModel({
    required this.distance,
    required this.duration,
    required this.points,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final route = json['routes'][0];
    final leg = route['legs'][0];

    // duration & distance
    final distance = (leg['distance'] as num).toDouble();
    final duration = (leg['duration'] as num).toDouble();

    // coordinates → LatLng(lat, lon)
    final coords = route['geometry']['coordinates'] as List;
    final points = coords.map<LatLng>((c) {
      final lon = (c[0] as num).toDouble();
      final lat = (c[1] as num).toDouble();
      return LatLng(lat, lon); // مهم: LatLng(lat, lon)
    }).toList();

    return RouteModel(distance: distance, duration: duration, points: points);
  }
}
