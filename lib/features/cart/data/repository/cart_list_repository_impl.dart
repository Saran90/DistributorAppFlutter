import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../../../core/data/local_storage/models/hive_cart_model.dart';
import '../../domain/repository/cart_list_repository.dart';
import '../datasource/cart_list_data_source.dart';

class CartListRepositoryImpl extends CartListRepository {
  CartListRepositoryImpl({required this.cartListDataSource});

  final CartListDataSource cartListDataSource;

  @override
  Future<Either<Failure, List<HiveCartModel>?>> getCustomerCart(
      int customerId) async {
    try {
      var result = await cartListDataSource.getCustomerCart(customerId);
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
