import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String,dynamic>?>> login(String username, String password);

  Future<Either<Failure, Map<String,dynamic>?>> customerLogin(String username, String password);

  Future<Either<Failure, Map<String,dynamic>?>> loginWithManufacture(
      String username, String password, int manufacture);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, Map<String,dynamic>?>> isLoggedIn();

  Future<Either<Failure, bool?>> isCustomerUser();
}
