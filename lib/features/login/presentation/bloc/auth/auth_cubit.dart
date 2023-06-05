import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/is_logged_in_use_case.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/login_use_case.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/login_with_manufacture_use_case.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/logout_use_case.dart';
import 'package:distributor_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.loginUseCase,
      required this.logoutUseCase,
      required this.isLoggedInUseCase,
      required this.loginWithManufactureUseCase})
      : super(AuthInitial());

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final LoginWithManufactureUseCase loginWithManufactureUseCase;

  Future<void> login(String username, String password) async {
    debugPrint('Login Clicked');
    emit(AuthLoading());
    var result = await loginUseCase
        .call(LoginParams(username: username, password: password));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(AuthenticationFailed(message: l.message ?? serverFailureMessage));
        emit(UnAuthenticated());
      } else if (l is NetworkFailure) {
        emit(AuthenticationFailed(message: networkFailureMessage));
        emit(UnAuthenticated());
      } else {
        emit(AuthenticationFailed(message: 'Login Failed'));
        emit(UnAuthenticated());
      }
    }, (r) => emit(Authenticated(userId: r)));
  }

  Future<void> loginWithManufacture(
      String username, String password, int manufacture) async {
    debugPrint('Login with manufacture Clicked');
    emit(AuthLoading());
    var result = await loginWithManufactureUseCase.call(
        LoginWithManufactureParams(
            username: username, password: password, manufacture: manufacture));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(AuthenticationFailed(message: l.message ?? serverFailureMessage));
        emit(UnAuthenticated());
      } else if (l is NetworkFailure) {
        emit(AuthenticationFailed(message: networkFailureMessage));
        emit(UnAuthenticated());
      } else {
        emit(AuthenticationFailed(message: 'Login Failed'));
        emit(UnAuthenticated());
      }
    }, (r) => emit(Authenticated(userId: r)));
  }

  Future<void> logout() async {
    debugPrint('Logout Clicked');
    emit(AuthLoading());
    var result = await logoutUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(LogoutFailed(message: cacheFailureMessage));
        emit(UnAuthenticated());
      } else {
        emit(LogoutFailed(message: 'Logout Failed'));
      }
    }, (r) => emit(UnAuthenticated()));
  }

  Future<void> isLoggedIn() async {
    debugPrint('isLoggedIn Clicked');
    emit(AuthLoading());
    var result = await isLoggedInUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(LogoutFailed(message: cacheFailureMessage));
        emit(UnAuthenticated());
      } else {
        emit(LogoutFailed(message: 'Logout Failed'));
        emit(UnAuthenticated());
      }
    }, (r) {
      if (r != null) {
        emit(Authenticated(userId: r));
      } else {
        emit(UnAuthenticated());
      }
    });
  }
}
