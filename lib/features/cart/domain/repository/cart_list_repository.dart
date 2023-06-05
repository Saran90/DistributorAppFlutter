import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_cart_model.dart';

abstract class CartListRepository{
  Future<Either<Failure, List<HiveCartModel>?>> getCustomerCart(
      int customerId);
}