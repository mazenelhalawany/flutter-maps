import '../model/auth_model.dart';

abstract class AuthRepository {
  Future<void> login({required UserModel user});
  Future<void> register({required UserModel user});
  Future<UserModel?> getData();
  Future<UserModel?> updateData({required UserModel user});
  Future<void> logout();
  Future<void> continueAsGuest();
  Future<void> autoLogin();
  // 👈 ضيف الـ getters هنا
  bool get isLoggedIn;
  UserModel? get currentUser;
  bool get issGuest;
}
