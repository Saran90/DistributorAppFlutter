import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_cart_model.dart';

import '../../../../core/data/error/failures.dart';

abstract class DeleteCartRepository{
  Future<Either<Failure, void>> deleteCustomerCart(int customerId);
  Future<Either<Failure, void>> deleteCustomerCartItem(HiveCartModel hiveCartModel);
}