import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String username, String password);

  Future<Either<Failure, void>> loginWithManufacture(
      String username, String password, int manufacture);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, int?>> isLoggedIn();
}
