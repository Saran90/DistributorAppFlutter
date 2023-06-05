import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_cart_model.dart';

abstract class DeleteCartDataSource {
  Future<void> deleteCustomerCart(int customerId);
  Future<void>? deleteCustomerCartItem(HiveCartModel hiveCartModel);
}

class DeleteCartDataSourceImpl extends DeleteCartDataSource {
  DeleteCartDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<void> deleteCustomerCart(int customerId) {
    return hiveDataSource.deleteCustomerCart(customerId);
  }

  @override
  Future<void>? deleteCustomerCartItem(HiveCartModel hiveCartModel) {
    return hiveDataSource.deleteCustomerCartItem(hiveCartModel);
  }

}
