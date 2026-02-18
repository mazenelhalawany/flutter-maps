import '../model/mapmodel.dart';
import 'repo.dart';
import '../../../../services/api_service.dart';

class PlacesRepoImpl implements PlacesRepo {
  final ApiService searchApiService;
  final ApiService routeApiService;

  PlacesRepoImpl({
    required this.searchApiService,
    required this.routeApiService,
  });

  @override
  Future<List<PlaceModel>> searchPlaces(String query) async {
    final response = await searchApiService.get(
      "search",
      queryParams: {
        "q": query,
        "limit": 5,
        "format": "json",
        "countrycodes": "eg",
      },
    );

    // تأكد إن response.data عبارة عن List<dynamic>
    final List<dynamic> features = response is List ? response : [];

    // بعد كده اعمل map لكل عنصر
    return features.map((item) {
      return PlaceModel(
        placeId: item["place_id"] ?? 0,
        name: item["name"] ?? "",
        displayName: item["display_name"] ?? "",
        lat: double.tryParse(item["lat"]?.toString() ?? "0") ?? 0.0,
        lon: double.tryParse(item["lon"]?.toString() ?? "0") ?? 0.0,
      );
    }).toList();
  }

  @override
  Future<RouteModel> getRoute({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    final response = await routeApiService.get(
      "route/v1/driving/$startLon,$startLat;$endLon,$endLat",
      queryParams: {"overview": "full", "geometries": "geojson"},
    );

    return RouteModel.fromJson(response);
  }
}
