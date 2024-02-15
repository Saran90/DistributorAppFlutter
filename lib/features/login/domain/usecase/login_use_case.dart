import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class LoginUseCase extends UseCase<Map<String,dynamic>?, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Map<String,dynamic>?>> call(params) {
    return authRepository.login(params.username, params.password);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
