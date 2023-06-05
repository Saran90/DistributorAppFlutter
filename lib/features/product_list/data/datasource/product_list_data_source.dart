import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';

import '../../../../core/data/local_storage/models/hive_product_model.dart';

abstract class ProductListDataSource {
  Future<List<HiveProductModel>?> getProducts(String search);
}

class ProductListDataSourceImpl extends ProductListDataSource {
  ProductListDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<List<HiveProductModel>?> getProducts(
      String search) async {
    return hiveDataSource.getFilteredProducts(search);
  }
}
