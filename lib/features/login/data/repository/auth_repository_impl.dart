import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/interceptors/network_checker.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/auth_data_source.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/models/login_response.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.authDataSource});

  final AuthDataSource authDataSource;

  @override
  Future<Either<Failure, void>> login(String username, String password) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await authDataSource.login(username, password);
        if (result != null) {
          if (result.error != null && result.error!.isNotEmpty) {
            return Left(ServerFailure(message: result.errorDescription));
          }
          await authDataSource.saveLogin(result);
          return Right(result.salesmanId);
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
  Future<Either<Failure, int?>> isLoggedIn() async {
    try {
      var result = await authDataSource.isLoggedIn();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> loginWithManufacture(
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
          return Right(result.salesmanId);
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
}
