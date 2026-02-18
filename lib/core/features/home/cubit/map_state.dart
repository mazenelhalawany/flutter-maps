part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

/// ================= SEARCH =================

class SearchPlacesLoading extends MapState {}

class SearchPlacesLoaded extends MapState {
  final List<PlaceModel> places;
  SearchPlacesLoaded(this.places);
}

class SearchPlacesError extends MapState {
  final String message;
  SearchPlacesError(this.message);
}

class SearchPlacesHidden extends MapState {}

/// ================= ROUTE =================

class RouteLoading extends MapState {}

class RouteLoaded extends MapState {
  final RouteModel route;
  RouteLoaded(this.route);
}

class RouteError extends MapState {
  final String message;
  RouteError(this.message);
}
