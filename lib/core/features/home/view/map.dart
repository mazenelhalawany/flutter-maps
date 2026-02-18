import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../cubit/map_cubit.dart';
import '../data/model/mapmodel.dart';
import '../widget/drawer.dart';
import '../widget/time&distance.dart';
import '../../../utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../data/model/sqlmodel.dart';
import '../data/repo/sqlrepoimplement.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, this.destinationPlace});
  final LatLng? destinationPlace; // المكان اللي عايز تعمل له Route
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapController mapController;

  LatLng? currentLocation;
  LatLng? selectedPlace;

  RouteModel? placeDirections;

  bool isTimeAndDistanceVisible = false;

  List<LatLng> routePoints = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    getMyCurrentLocation();
  }

  Future<void> getMyCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      final pos = await LocationHelper.getCurrentLocation();
      // setState(() {
      //   currentLocation = LatLng(pos.latitude, pos.longitude);
      // });
      setState(() {
        currentLocation = LatLng(pos.latitude, pos.longitude);

        // لو فيه destinationPlace جاي من صفحة SavedPlaces
        if (widget.destinationPlace != null) {
          selectedPlace = widget.destinationPlace;

          mapController.move(currentLocation!, 15); // ابدأ من current location

          // خد Route مباشرة
          final cubit = context.read<MapCubit>();
          cubit.getRoute(
            startLat: currentLocation!.latitude,
            startLon: currentLocation!.longitude,
            endLat: selectedPlace!.latitude,
            endLon: selectedPlace!.longitude,
          );
        } else {
          mapController.move(currentLocation!, 15);
        }
      });
      //  mapController.move(currentLocation!, 15);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
    }
  }

  void goToPlace(LatLng place) {
    mapController.move(place, 15);
  }

  void clearRouteAndInfo() {
    setState(() {
      routePoints.clear();
      placeDirections = null;
      isTimeAndDistanceVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: const Text("Map")),
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state is RouteLoaded) {
            setState(() {
              placeDirections = state.route;

              /// هنا بقى بنحول ال geojson points ل LatLng
              routePoints = state.route.points;
              // .map((p) => LatLng(p.latitude, p.longitude))
              // .toList();

              isTimeAndDistanceVisible = true;
            });
            print("Duration: ${placeDirections!.duration}"); // لازم يطبع 2314.7
            print(
              "Distance: ${placeDirections!.distance}",
            ); // لازم يطبع 34764.1
          }

          if (state is RouteError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<MapCubit>();

          return Stack(
            children: [
              // =======================
              // Map Full Screen
              // =======================
              FlutterMap(
                mapController: mapController,
                options: const MapOptions(
                  initialCenter: LatLng(30.0444, 31.2357),
                  initialZoom: 12,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                    userAgentPackageName:
                        'com.example.flutter_application_testmaps',
                  ),

                  // =======================
                  // Route Polyline
                  // =======================
                  if (routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          strokeWidth: 5,
                          color: Colors.blue,
                        ),
                      ],
                    ),

                  // =======================
                  // Marker: My Current Location (Blue)
                  // =======================
                  if (currentLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: currentLocation!,
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.blue,
                            size: 45,
                          ),
                        ),
                      ],
                    ),

                  // =======================
                  // Marker: Selected Place (Red)
                  // =======================
                  if (selectedPlace != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: selectedPlace!,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                ],
              ),

              // =======================
              // Distance & Time Widget
              // =======================
              if (placeDirections != null)
                DistanceAndTime(
                  placeDirections: placeDirections,
                  isTimeAndDistanceVisible: isTimeAndDistanceVisible,
                ),

              // =======================
              // Search Bar + Results Overlay
              // =======================
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 50,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 5),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // =======================
                      // Search TextField
                      // =======================
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search place...",
                          prefixIcon: Icon(Icons.search, color: AppColors.blue),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();

                              cubit.hideSearchResults();

                              setState(() {
                                selectedPlace = null;
                              });

                              clearRouteAndInfo();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          cubit.searchPlaces(value);
                        },
                      ),

                      if (state is SearchPlacesLoading)
                        const LinearProgressIndicator(),

                      // =======================
                      // Results List
                      // =======================
                      if (state is SearchPlacesLoaded)
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.places.length,
                            itemBuilder: (context, index) {
                              final place = state.places[index];

                              return ListTile(
                                title: Text(place.name),
                                subtitle: Text(place.displayName),
                                onTap: () async {
                                  final latLng = LatLng(place.lat, place.lon);

                                  // move map
                                  goToPlace(latLng);

                                  // close keyboard
                                  FocusScope.of(context).unfocus();

                                  // write place name in search field
                                  searchController.text = place.name;

                                  // save selected marker
                                  setState(() {
                                    selectedPlace = latLng;
                                  });
                                  // ✅ حفظ المكان في SQFLite
                                  final placesRepo = PlacesLocalRepoImpl();
                                  placesRepo.savePlace(
                                    SqlModel(
                                      name: place.name,
                                      displayName: place.displayName,
                                      lat: place.lat,
                                      lon: place.lon,
                                    ),
                                  );

                                  // hide results list
                                  cubit.hideSearchResults();

                                  // clear old route first
                                  clearRouteAndInfo();

                                  // get route
                                  if (currentLocation != null) {
                                    cubit.getRoute(
                                      startLat: currentLocation!.latitude,
                                      startLon: currentLocation!.longitude,
                                      endLat: latLng.latitude,
                                      endLon: latLng.longitude,
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),

                      if (state is SearchPlacesError)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(state.message),
                        ),

                      if (state is RouteLoading)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),

              // =======================
              // My Location Button
              // =======================
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: AppColors.blue,
                  child: const Icon(Icons.my_location),
                  onPressed: () {
                    if (currentLocation != null) {
                      mapController.move(currentLocation!, 16);
                    } else {
                      getMyCurrentLocation();
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
