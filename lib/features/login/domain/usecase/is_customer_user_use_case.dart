import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class IsCustomerUserUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  IsCustomerUserUseCase({required this.authRepository});

  @override
  Future<Either<Failure, bool?>> call(params) {
    return authRepository.isCustomerUser();
  }
}