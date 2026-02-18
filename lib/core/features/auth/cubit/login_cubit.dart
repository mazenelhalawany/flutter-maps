import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController();
  String? _verificationId;

  /// إرسال كود SMS
  Future<void> verifyPhoneNumber() async {
    emit(AuthLoading());

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+2${phoneController.text}',
      timeout: const Duration(seconds: 60),

      verificationCompleted: (credential) async {
        await _firebaseAuth.signInWithCredential(credential);
        emit(
          AuthSuccess(
            _firebaseAuth.currentUser!.uid,
            _firebaseAuth.currentUser?.phoneNumber ?? "null",
          ),
        );
      },

      verificationFailed: (e) {
        emit(AuthError(e.message ?? 'Verification failed'));
      },

      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        emit(CodeSentState(verificationId));
      },

      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  /// تأكيد الكود
  Future<void> submitSmsCode(String smsCode) async {
    if (_verificationId == null) {
      print("verificationId is null");
      emit(AuthError('Verification ID is null'));
      return;
    }

    try {
      emit(AuthLoading());
      print("loading");

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      print("success");

      emit(
        AuthSuccess(
          userCredential.user!.uid,
          _firebaseAuth.currentUser?.phoneNumber ?? "null",
        ),
      );
    } catch (e) {
      print(e.toString());
      emit(AuthError('Invalid code'));
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    emit(AuthInitial());
  }
}
