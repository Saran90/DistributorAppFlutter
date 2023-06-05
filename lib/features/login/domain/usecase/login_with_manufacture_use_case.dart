import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class LoginWithManufactureUseCase
    extends UseCase<void, LoginWithManufactureParams> {
  final AuthRepository authRepository;

  LoginWithManufactureUseCase({required this.authRepository});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return authRepository.loginWithManufacture(
        params.username, params.password, params.manufacture);
  }
}

class LoginWithManufactureParams extends Equatable {
  final String username;
  final String password;
  final int manufacture;

  const LoginWithManufactureParams(
      {required this.username,
      required this.password,
      required this.manufacture});

  @override
  List<Object> get props => [username, password, manufacture];
}
