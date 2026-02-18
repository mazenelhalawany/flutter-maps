abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class CodeSentState extends AuthState {
  final String verificationId;
  CodeSentState(this.verificationId);
}

class AuthSuccess extends AuthState {
  final String number;
  final String uid;
  AuthSuccess(this.uid, this.number);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
