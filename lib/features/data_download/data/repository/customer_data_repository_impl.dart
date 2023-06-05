import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/data_download/data/datasource/customer_data_data_source.dart';
import 'package:distributor_app_flutter/features/data_download/domain/repository/customer_data_repository.dart';

import '../../../../core/data/interceptors/network_checker.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';

class CustomerDataRepositoryImpl extends CustomerDataRepository {
  CustomerDataRepositoryImpl({required this.customerDataDataSource});

  final CustomerDataDataSource customerDataDataSource;

  @override
  Future<Either<Failure, List<HiveCustomerModel>?>> getCustomers(
      String name) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await customerDataDataSource.getCustomers(name);
        if (result != null) {
          return Right(result);
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
