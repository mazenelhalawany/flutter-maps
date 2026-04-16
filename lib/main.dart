import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/features/auth/cubit/login_cubit.dart';
import 'core/features/auth/view/login_view.dart';
import 'core/features/home/cubit/map_cubit.dart';
import 'core/features/home/data/repo/repoimplement.dart';
import 'core/features/home/view/map.dart';
import 'core/services/api_service.dart';
import 'core/services/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/themes.dart';
import 'firebase_options.dart';

late Widget initialRoute;
//dev first feature
//test source tree
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      initialRoute = LoginView();
    } else {
      initialRoute = MapView();
    }
  });

  /// 1) Dio + ApiService for Search (Nominatim)
  /// ===========================
  final searchDioClient = DioClient(
    baseUrl: "https://nominatim.openstreetmap.org/",
  );
  final searchApiService = ApiService(searchDioClient.dio);

  /// ===========================
  /// 2) Dio + ApiService for Route (OSRM)
  /// ===========================
  final routeDioClient = DioClient(baseUrl: "https://router.project-osrm.org/");
  final routeApiService = ApiService(routeDioClient.dio);

  /// Repo Impl
  final repo = PlacesRepoImpl(
    searchApiService: searchApiService,
    routeApiService: routeApiService,
  );
  final cubit = MapCubit(repo);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => cubit),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
