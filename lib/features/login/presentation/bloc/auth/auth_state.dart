part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  int userId;
  bool isCustomer;

  Authenticated({required this.userId, this.isCustomer = false});
}

class UnAuthenticated extends AuthState {
}

class AuthenticationFailed extends AuthState {
  final String message;

  AuthenticationFailed({required this.message});
}

class LogoutFailed extends AuthState {
  final String message;

  LogoutFailed({required this.message});
}
