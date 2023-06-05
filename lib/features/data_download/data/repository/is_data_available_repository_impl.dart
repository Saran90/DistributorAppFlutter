import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../../../core/data/interceptors/network_checker.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../domain/repository/is_data_available_repository.dart';
import '../datasource/is_data_available_data_source.dart';

class IsDataAvailableRepositoryImpl extends IsDataAvailableRepository {
  IsDataAvailableRepositoryImpl({required this.isDataAvailableDataSource});

  final IsDataAvailableDataSource isDataAvailableDataSource;

  @override
  Future<Either<Failure, bool>> isDataAvailable() async {
    try {
      var result = await isDataAvailableDataSource.isDataAvailable();
      return Right(result);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
