import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';

import '../../../../../core/data/local_storage/models/hive_product_model.dart';
import '../../../../core/data/local_storage/models/hive_cart_model.dart';

abstract class CartListDataSource {
  Future<List<HiveCartModel>?> getCustomerCart(int customerId);
}

class CartListDataSourceImpl extends CartListDataSource {
  CartListDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<List<HiveCartModel>?> getCustomerCart(
      int customerId) async {
    return hiveDataSource.getCustomerCart(customerId);
  }
}
