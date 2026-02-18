import '../model/mapmodel.dart';

abstract class PlacesRepo {
  Future<List<PlaceModel>> searchPlaces(String query);
  Future<RouteModel> getRoute({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  });
}
