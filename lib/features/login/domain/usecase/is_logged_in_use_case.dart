import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class IsLoggedInUseCase extends UseCase<Map<String,dynamic>?, NoParams> {
  final AuthRepository authRepository;

  IsLoggedInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Map<String,dynamic>?>> call(params) {
    return authRepository.isLoggedIn();
  }
}