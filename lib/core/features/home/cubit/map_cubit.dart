import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/mapmodel.dart';
import '../data/repo/repo.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final PlacesRepo placesRepo;
  Timer? _debounce;
  RouteModel? routeModel; // هنا هنخزن route اللي جاي من api
  MapCubit(this.placesRepo) : super(MapInitial());

  /// البحث عن الأماكن بالـ query
  Future<void> searchPlaces(String query) async {
    if (query.trim().isEmpty) {
      emit(MapInitial());
      return;
    }

    // cancel previous timer
    _debounce?.cancel();

    // start new timer
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchPlacesLoading());

      try {
        final places = await placesRepo.searchPlaces(query);
        emit(SearchPlacesLoaded(places));
      } catch (e) {
        emit(SearchPlacesError(e.toString()));
      }
    });
  }

  /// ================= ROUTE =================
  Future<void> getRoute({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    emit(RouteLoading());

    try {
      routeModel = await placesRepo.getRoute(
        startLat: startLat,
        startLon: startLon,
        endLat: endLat,
        endLon: endLon,
      );

      emit(RouteLoaded(routeModel!));
    } catch (e) {
      emit(RouteError(e.toString()));
    }
  }

  void hideSearchResults() {
    emit(SearchPlacesHidden());
  }
}
