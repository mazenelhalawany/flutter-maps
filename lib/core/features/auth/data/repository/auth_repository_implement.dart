// import 'package:dio/dio.dart';
// import '../../../../core/services/api_error.dart';
// import '../../../../core/services/api_exceptions.dart';
// import '../../../../core/services/api_service.dart';
// import '../../../../core/utils/sharedpreferences.dart';
// import '../../cubit/profile_cubit.dart';
// import '../model/auth_model.dart';
// import 'auth_repository.dart';
// import 'package:path/path.dart';

// class AuthRepositoryImplement implements AuthRepository {
// //  ApiService apiService = ApiService(DioClient().dio);
// //login
//   final ApiService apiService;
//   AuthRepositoryImplement(this.apiService);
//   bool isGuest = false;
//   UserModel? _currentUser;
//   @override
//   Future<UserModel> login({required UserModel user}) async {
//     try {
//       final response = await apiService.post("login", (user.toJson()));

//       final userr = UserModel.fromJson(response['data']);
//       if (userr.token != null) {
//         await CacheHelper.saveData(key: 'token', value: userr.token);
//       }
//       isGuest = false;
//       _currentUser = userr;
//       return userr;
//     } on DioException catch (e) {
//       // هنا كل الأخطاء هتكون ServerException
//       // أو أي خطأ غريب هيتحول لـ ServerException
//       throw handleApiException(e);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserModel> register({required UserModel user}) async {
//     try {
//       final response = await apiService.post("register", (user.toJson()));

//       final userr = UserModel.fromJson(response['data']);
//       if (userr.token != null) {
//         await CacheHelper.saveData(key: 'token', value: userr.token);
//       }
//       isGuest = false;
//       _currentUser = userr;
//       return userr;
//     } on DioException catch (e) {
//       // هنا كل الأخطاء هتكون ServerException
//       // أو أي خطأ غريب هيتحول لـ ServerException

//       throw handleApiException(e);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserModel?> getData() async {
//     try {
//       final token = await CacheHelper.getData(key: 'token');

//       if (token == null || token.isEmpty || token == 'guest') {
//         return null;
//       }

//       final response = await apiService.get("profile");

//       final userr = UserModel.fromJson(response['data']);
//       _currentUser = userr;
//       return userr;
//     } on DioException catch (e) {
//       // هنا كل الأخطاء هتكون ServerException
//       // أو أي خطأ غريب هيتحول لـ ServerException

//       throw handleApiException(e);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserModel> updateData({required UserModel user}) async {
//     try {
//       final formData = FormData.fromMap({
//         "name": user.name,
//         "email": user.email,
//         "address": user.address,
//         "visa": user.visa,
//         if (ProfileCubit.imgPath != null)
//           "image": MultipartFile.fromBytes(
//             ProfileCubit.imgPath!,
//             filename: ProfileCubit.imgName,
//           ),
//       });
//       final response = await apiService.post("update-profile", formData);

//       final userr = UserModel.fromJson(response['data']);
//       // if (userr.token != null) {
//       //   await CacheHelper.saveData(key: 'token', value: userr.token);
//       // }
//       _currentUser = userr;
//       return userr;
//     } on DioException catch (e) {
//       // هنا كل الأخطاء هتكون ServerException
//       // أو أي خطأ غريب هيتحول لـ ServerException

//       throw handleApiException(e);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<void> logout() async {
//     final response = await apiService.post("logout", {});

//     if (response["data"] != null) {
//       throw ServerException(errmodel: ErrorModel(message: response["message"]));
//     }
//     await CacheHelper.removeData(key: 'token');
//     isGuest = true;
//     _currentUser = null;
//   }

//   @override
//   Future<UserModel?> autoLogin() async {
//     final token = await CacheHelper.getData(key: "token");
//     if (token == null || token.isEmpty || token == 'guest') {
//       isGuest = true;
//       _currentUser = null;
//       return null;
//     }
//     isGuest = false;
//     try {
//       final user = await getData();
//       _currentUser = user;
//       return user;
//     } catch (e) {
//       CacheHelper.removeData(key: "token");
//       isGuest = true;
//       _currentUser = null;
//       return null;
//     }
//   }

//   @override
//   Future<void> continueAsGuest() async {
//     isGuest = true;
//     _currentUser = null;
//     await CacheHelper.saveData(key: 'token', value: 'guest');
//   }

//   @override
//   bool get issGuest => isGuest;
//   @override
//   UserModel? get currentUser => _currentUser;
//   @override
//   bool get isLoggedIn => !isGuest && _currentUser != null;
// }
