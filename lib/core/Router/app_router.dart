import 'package:flutter/material.dart';
import '../features/home/view/map.dart';
import '../services/api_service.dart';
import '../services/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

// صفحاتك

import '../features/home/cubit/placescubit.dart';
import '../features/home/cubit/map_cubit.dart';
import '../features/home/data/repo/sqlrepoimplement.dart';
import '../features/home/data/repo/repoimplement.dart';
import '../features/home/view/places.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/saved_places':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                SavedPlacesCubit(PlacesLocalRepoImpl())..loadSavedPlaces(),
            child: const SavedPlacesView(),
          ),
        );

      case '/map_view':
        final LatLng? destinationPlace = settings.arguments as LatLng?;
        final searchDioClient = DioClient(
          baseUrl: "https://nominatim.openstreetmap.org/",
        );
        final routeDioClient = DioClient(
          baseUrl: "https://router.project-osrm.org/",
        );
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => MapCubit(
              PlacesRepoImpl(
                searchApiService: ApiService(
                  searchDioClient.dio,
                ), // عبيهم بالقيم الصح
                routeApiService: ApiService(routeDioClient.dio),
              ),
            ),
            child: MapView(destinationPlace: destinationPlace),
          ),
        );

      default:
        return null;
    }
  }
}
