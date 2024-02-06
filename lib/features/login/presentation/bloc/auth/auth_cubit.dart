import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/is_logged_in_use_case.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/login_use_case.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/login_with_manufacture_use_case.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/logout_use_case.dart';
import 'package:distributor_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecase/customer_login_use_case.dart';
import '../../../domain/usecase/is_customer_user_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUseCase,
    required this.customerLoginUseCase,
    required this.logoutUseCase,
    required this.isLoggedInUseCase,
    required this.isCustomerUserUseCase,
    required this.loginWithManufactureUseCase,
  }) : super(AuthInitial());

  final LoginUseCase loginUseCase;
  final CustomerLoginUseCase customerLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final IsCustomerUserUseCase isCustomerUserUseCase;
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
    }, (r) {
      if (r != null) {
        emit(Authenticated(
            userId: r['userId']??0,
            customerId: r['customerId']??0,
            isCustomer: (r['customerId']??0) != 0));
      } else {
        emit(AuthenticationFailed(message: 'Login Failed'));
        emit(UnAuthenticated());
      }
    });
  }

  Future<void> customerLogin(String username, String password) async {
    debugPrint('Customer Login Clicked');
    emit(AuthLoading());
    var result = await customerLoginUseCase
        .call(CustomerLoginParams(username: username, password: password));
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
    }, (r) {
      if (r != null) {
        emit(Authenticated(
            userId: r['userId']??0,
            customerId: r['customerId']??0,
            isCustomer: (r['customerId']??0) != 0));
      } else {
        emit(AuthenticationFailed(message: 'Login Failed'));
        emit(UnAuthenticated());
      }
    });
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
    }, (r) {
      if (r != null) {
        emit(Authenticated(
            userId: r['userId']??0,
            customerId: r['customerId']??0,
            isCustomer: (r['customerId']??0) != 0));
      } else {
        emit(AuthenticationFailed(message: 'Login Failed'));
        emit(UnAuthenticated());
      }
    });
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
    }, (r) async {
      emit(UnAuthenticated());
    });
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
        emit(Authenticated(
            userId: r['userId']??0,
            customerId: r['customerId']??0,
            isCustomer: (r['customerId']??0) != 0));
      } else {
        emit(UnAuthenticated());
      }
    });
  }
}
