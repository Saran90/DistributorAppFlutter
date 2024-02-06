import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/interceptors/network_checker.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/auth_data_source.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.authDataSource});

  final AuthDataSource authDataSource;

  @override
  Future<Either<Failure, Map<String,dynamic>?>> login(String username, String password) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await authDataSource.login(username, password);
        if (result != null) {
          if (result.error != null && result.error!.isNotEmpty) {
            return Left(ServerFailure(message: result.errorDescription));
          }
          await authDataSource.saveLogin(result);
          return Right({'userId':result.salesmanId,'customerId':0});
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } catch (exception) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>?>> customerLogin(
      String username, String password) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await authDataSource.customerLogin(username, password);
        if (result != null) {
          if (result.error != null && result.error!.isNotEmpty) {
            return Left(ServerFailure(message: result.errorDescription));
          }
          await authDataSource.saveCustomerLogin(result);
          return Right({'userId':0,'customerId':result.customerId});
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } catch (exception) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      var result = await authDataSource.logout();
      return Right(result);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>?>> isLoggedIn() async {
    try {
      var result = await authDataSource.isLoggedIn();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>?>> loginWithManufacture(
      String username, String password, int manufacture) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await authDataSource.loginWithManufacture(
            username, password, manufacture);
        if (result != null) {
          if (result.error != null && result.error!.isNotEmpty) {
            return Left(ServerFailure(message: result.errorDescription));
          }
          await authDataSource.saveLoginWithManufacture(result, manufacture);
          return Right({'userId':result.salesmanId,'customerId':0});
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } catch (exception) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool?>> isCustomerUser() async {
    try {
      var result = await authDataSource.isCustomerUser();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }
}
