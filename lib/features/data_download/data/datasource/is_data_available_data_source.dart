import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/preference/constants.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:flutter/cupertino.dart';

abstract class IsDataAvailableDataSource {
  Future<bool> isDataAvailable();
}

class IsDataAvailableDataSourceImpl extends IsDataAvailableDataSource {
  IsDataAvailableDataSourceImpl({
    required this.hiveDataSource,
    required this.sharedPreferenceDataSource,
  });

  final HiveDataSource hiveDataSource;
  final SharedPreferenceDataSource sharedPreferenceDataSource;

  @override
  Future<bool> isDataAvailable() async {
    int customerId = sharedPreferenceDataSource.getInt(spCustomerId) ?? 0;
    bool hasProductSynced =
        sharedPreferenceDataSource.getBool(spHasProductDataSynced) ?? false;
    bool hasLocationSynced =
        sharedPreferenceDataSource.getBool(spHasLocationDataSynced) ?? false;
    bool hasCustomerSynced =
        sharedPreferenceDataSource.getBool(spHasCustomerDataSynced) ?? false;
    debugPrint('Product Synced: $hasProductSynced');
    debugPrint('Location Synced: $hasLocationSynced');
    debugPrint('Customer Synced: $hasCustomerSynced');
    if (customerId > 0) {
      //Customer Login
      return Future.value(
          await hiveDataSource.isDataAvailableForCustomerLogin() &&
              hasCustomerSynced &&
              hasProductSynced);
    } else {
      //SalesMan Login
      return Future.value(await hiveDataSource.isDataAvailable() &&
          hasCustomerSynced &&
          hasLocationSynced &&
          hasProductSynced);
    }
  }
}
