import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/data_download/data/datasource/models/products_data_response.dart';
import 'package:distributor_app_flutter/features/data_download/data/datasource/product_data_data_source.dart';
import 'package:distributor_app_flutter/features/data_download/domain/repository/product_data_repository.dart';

import '../../../../core/data/interceptors/network_checker.dart';
import '../../../../core/data/local_storage/models/hive_product_model.dart';

class ProductDataRepositoryImpl extends ProductDataRepository {

  ProductDataRepositoryImpl({required this.productDataDataSource});

  final ProductDataDataSource productDataDataSource;

  @override
  Future<Either<Failure, List<HiveProductModel>?>> getProducts(String name) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await productDataDataSource.getProducts(name);
        if(result!=null) {
          return Right(result);
        }else{
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
