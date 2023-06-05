import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../../../core/data/local_storage/models/hive_cart_model.dart';
import '../../domain/repository/add_cart_repository.dart';
import '../datasource/add_cart_data_source.dart';

class AddCartRepositoryImpl extends AddCartRepository {
  AddCartRepositoryImpl({required this.addCartDataSource});

  final AddCartDataSource addCartDataSource;

  @override
  Future<Either<Failure, void>> addCart(HiveCartModel hiveCartModel) async {
    try {
      var result = await addCartDataSource.addCustomerCart(hiveCartModel);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }
}
