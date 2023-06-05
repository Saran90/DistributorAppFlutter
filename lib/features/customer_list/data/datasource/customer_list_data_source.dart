import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';

import '../../../../core/data/local_storage/models/hive_customer_model.dart';

abstract class CustomerListDataSource {
  Future<List<HiveCustomerModel>?> getCustomers(String search, String location);
}

class CustomerListDataSourceImpl extends CustomerListDataSource {
  CustomerListDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<List<HiveCustomerModel>?> getCustomers(
      String search, String location) async {
    return hiveDataSource.getAllFilteredCustomer(search, location);
  }
}
