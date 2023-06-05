import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';

import '../../../../core/data/local_storage/models/hive_cart_model.dart';

abstract class UpdateCartDataSource {
  Future<void> updateCustomerCart(HiveCartModel hiveCartModel);
}

class UpdateCartDataSourceImpl extends UpdateCartDataSource {
  UpdateCartDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<void> updateCustomerCart(HiveCartModel hiveCartModel) {
    return hiveDataSource.updateCart(hiveCartModel);
  }

}
