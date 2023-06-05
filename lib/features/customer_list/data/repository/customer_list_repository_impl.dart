import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../domain/repository/customer_list_repository.dart';
import '../datasource/customer_list_data_source.dart';

class CustomerListRepositoryImpl extends CustomerListRepository {
  CustomerListRepositoryImpl({required this.customerListDataSource});

  final CustomerListDataSource customerListDataSource;

  @override
  Future<Either<Failure, List<HiveCustomerModel>?>> getCustomers(
      String search, String location) async {
    try {
      var result = await customerListDataSource.getCustomers(search, location);
      if (result != null) {
        return Right(result);
      } else {
        return Left(CacheFailure());
      }
    } catch (exception) {
      return Left(CacheFailure());
    }
  }
}
