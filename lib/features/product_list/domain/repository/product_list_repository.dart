import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_product_model.dart';

abstract class ProductListRepository{
  Future<Either<Failure, List<HiveProductModel>?>> getProducts(
      String search);
}