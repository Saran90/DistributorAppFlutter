import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';

abstract class CustomerDataRepository{
  Future<Either<Failure, List<HiveCustomerModel>?>> getCustomers(String name);
  Future<Either<Failure, void>> saveCustomerSelection(HiveCustomerModel hiveCustomerModel);
  Future<Either<Failure, void>> deleteCustomerSelection();
  Future<Either<Failure, HiveCustomerModel?>> getCustomerSelection();
}