import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return authRepository.logout();
  }
}