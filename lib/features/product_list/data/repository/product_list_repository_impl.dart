import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../../../core/data/local_storage/models/hive_product_model.dart';
import '../../domain/repository/product_list_repository.dart';
import '../datasource/product_list_data_source.dart';

class ProductListRepositoryImpl extends ProductListRepository {
  ProductListRepositoryImpl({required this.productListDataSource});

  final ProductListDataSource productListDataSource;

  @override
  Future<Either<Failure, List<HiveProductModel>?>> getProducts(
      String search) async {
    try {
      var result = await productListDataSource.getProducts(search);
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
