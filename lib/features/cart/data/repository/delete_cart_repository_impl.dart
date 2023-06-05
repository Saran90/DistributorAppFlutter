import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_cart_model.dart';

import '../../domain/repository/delete_cart_repository.dart';
import '../datasource/delete_cart_data_source.dart';

class DeleteCartRepositoryImpl extends DeleteCartRepository {
  DeleteCartRepositoryImpl({required this.deleteCartDataSource});

  final DeleteCartDataSource deleteCartDataSource;

  @override
  Future<Either<Failure, void>> deleteCustomerCart(int customerId) async {
    try {
      var result = await deleteCartDataSource.deleteCustomerCart(customerId);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCustomerCartItem(HiveCartModel hiveCartModel) async {
    try {
      var result = await deleteCartDataSource.deleteCustomerCartItem(hiveCartModel);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }
}
