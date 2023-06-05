import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/local_storage/models/hive_cart_model.dart';
import '../../domain/repository/update_cart_repository.dart';
import '../datasource/update_cart_data_source.dart';

class UpdateCartRepositoryImpl extends UpdateCartRepository {
  UpdateCartRepositoryImpl({required this.updateCartDataSource});

  final UpdateCartDataSource updateCartDataSource;

  @override
  Future<Either<Failure, void>> updateCart(HiveCartModel hiveCartModel) async {
    try {
      var result = await updateCartDataSource.updateCustomerCart(hiveCartModel);
      return Right(result);
    } catch (exception) {
      debugPrint('UpdateCartRepositoryImpl: $exception');
      return Left(CacheFailure());
    }
  }
}
