import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';

abstract class CustomerListRepository{
  Future<Either<Failure, List<HiveCustomerModel>?>> getCustomers(
      String search, String location);
}