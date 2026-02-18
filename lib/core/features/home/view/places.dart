import 'package:flutter/material.dart';
import 'map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../cubit/placescubit.dart';
import '../cubit/placesstates.dart';
import '../data/repo/sqlrepoimplement.dart';

class SavedPlacesView extends StatelessWidget {
  const SavedPlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SavedPlacesCubit(PlacesLocalRepoImpl())..loadSavedPlaces();

    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Saved Places"),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                cubit.clearAllPlaces();
              },
            ),
          ],
        ),
        body: BlocBuilder<SavedPlacesCubit, SavedPlacesState>(
          builder: (context, state) {
            final cubit = SavedPlacesCubit.get(context);
            if (state is SavedPlacesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SavedPlacesError) {
              print(state.message);
              return Center(child: Text(state.message));
            }

            if (state is SavedPlacesLoaded) {
              if (state.places.isEmpty) {
                return const Center(
                  child: Text(
                    "No saved places yet",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.places.length,
                itemBuilder: (context, index) {
                  final place = state.places[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapView(
                              destinationPlace: LatLng(
                                place.lat,
                                place.lon,
                              ), // المكان النهائي
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(place.name),
                        subtitle: Text(place.displayName),
                        leading: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            cubit.deletePlace(place.id!);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
