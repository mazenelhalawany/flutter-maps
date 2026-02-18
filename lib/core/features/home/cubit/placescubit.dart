import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/sqlmodel.dart';
import '../data/repo/sqlrepo.dart';
import 'placesstates.dart';

class SavedPlacesCubit extends Cubit<SavedPlacesState> {
  final SqlRepo placesLocalRepo;
  // ignore: strict_top_level_inference
  static SavedPlacesCubit get(context) => BlocProvider.of(context);

  SavedPlacesCubit(this.placesLocalRepo) : super(SavedPlacesInitial());

  Future<void> loadSavedPlaces() async {
    emit(SavedPlacesLoading());

    try {
      final places = await placesLocalRepo.getSavedPlaces();
      emit(SavedPlacesLoaded(places));
    } catch (e) {
      emit(SavedPlacesError(e.toString()));
    }
  }

  Future<void> savePlace(SqlModel place) async {
    try {
      await placesLocalRepo.savePlace(place);
      await loadSavedPlaces();
    } catch (e) {
      emit(SavedPlacesError(e.toString()));
    }
  }

  Future<void> deletePlace(int id) async {
    try {
      await placesLocalRepo.deletePlace(id);
      await loadSavedPlaces();
    } catch (e) {
      emit(SavedPlacesError(e.toString()));
    }
  }

  Future<void> clearAllPlaces() async {
    try {
      await placesLocalRepo.clearAllPlaces();
      await loadSavedPlaces();
    } catch (e) {
      emit(SavedPlacesError(e.toString()));
    }
  }
}
