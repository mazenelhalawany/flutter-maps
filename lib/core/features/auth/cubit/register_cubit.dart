// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'register_state.dart';
// import '../data/model/auth_model.dart';
// import '../data/repository/auth_repository.dart';
// import '../data/repository/auth_repository_implement.dart';

// class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit(this.repo) : super(RegisterInitialState());

//   final AuthRepository repo;
//   static RegisterCubit get(context) => BlocProvider.of(context);

//   bool isSecure = true;
//   bool isConfirmedSecure = true;
//   final formKey = GlobalKey<FormState>();
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

//   void changePasswordVisibility() {
//     isSecure = !isSecure;
//     emit(RegisterChangePasswordVisibilityState());
//   }

//   void changeConfirmPasswordVisibility() {
//     isConfirmedSecure = !isConfirmedSecure;
//     emit(RegisterConfirmChangePasswordVisibilityState());
//   }

//   Future<dynamic> signup(
//       BuildContext context, String email, String password, String name,
//       {String? address, String? visa}) async {
//     if (formKey.currentState!.validate()) {
//       try {
//         emit(RegisterLoadingState());
//         final user = await repo.register(
//             user: UserModel(
//                 email: email,
//                 password: password,
//                 name: name,
//                 address: address,
//                 visa: visa));
//         emit(RegisterSuccessState("success Regiser"));
//       } catch (e) {
//         emit(RegisterErrorState(e.toString()));
//       }
//     } else {
//       return;
//     }
//   }
//   // userRegister(context) async {
//   //   if (formKey.currentState!.validate()) {
//   //     emit(RegisterLoadingState());

//   //     final result = await authRepositoryImplement.register(
//   //       user: UserModel(
//   //         email: usernameController.text.trim(),
//   //         password: passwordController.text.trim(),
//   //       ),
//   //     );

//   //     String message;
//   //     switch (result.message) {
//   //       case 'successful verify your email.':
//   //         message = S.of(context).please_verify_your_email;
//   //         break;
//   //       case 'The password provided is too weak.':
//   //         message = S.of(context).weak_password;
//   //         break;
//   //       case 'The account already exists .':
//   //         message = S.of(context).account_already_exists;
//   //         break;
//   //       default:
//   //         message = S.of(context).unknown_error;
//   //     }

//   //     if (result.success) {
//   //       emit(RegisterSuccessState(message));
//   //     } else {
//   //       emit(RegisterErrorState(result.message));
//   //     }
//   //   }
//   // }
// }
