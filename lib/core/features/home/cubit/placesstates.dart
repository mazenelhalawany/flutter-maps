import 'package:flutter/foundation.dart';
import '../data/model/sqlmodel.dart';

@immutable
sealed class SavedPlacesState {}

final class SavedPlacesInitial extends SavedPlacesState {}

final class SavedPlacesLoading extends SavedPlacesState {}

final class SavedPlacesLoaded extends SavedPlacesState {
  final List<SqlModel> places;
  SavedPlacesLoaded(this.places);
}

final class SavedPlacesError extends SavedPlacesState {
  final String message;
  SavedPlacesError(this.message);
}
