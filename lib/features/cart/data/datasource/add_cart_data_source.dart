import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';

import '../../../../../core/data/local_storage/models/hive_product_model.dart';
import '../../../../core/data/local_storage/models/hive_cart_model.dart';

abstract class AddCartDataSource {
  Future<void> addCustomerCart(HiveCartModel hiveCartModel);
}

class AddCartDataSourceImpl extends AddCartDataSource {
  AddCartDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<void> addCustomerCart(HiveCartModel hiveCartModel) {
    return hiveDataSource.addCart(hiveCartModel);
  }

}
