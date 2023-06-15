import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/preference/constants.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/utils/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import 'models/customer_data_response.dart';

abstract class CustomerDataDataSource {
  Future<List<HiveCustomerModel>?> getCustomers(String name);
}

class CustomerDataDataSourceImpl extends CustomerDataDataSource {
  CustomerDataDataSourceImpl(
      {required this.dio,
      required this.hiveDataSource,
      required this.sharedPreferenceDataSource});

  final Dio dio;
  final HiveDataSource hiveDataSource;
  final SharedPreferenceDataSource sharedPreferenceDataSource;

  @override
  Future<List<HiveCustomerModel>?> getCustomers(String name) async {
    try {
      var response = await dio.get(AppConfig.instance.endPoint!.customers,
          queryParameters: {'Name': name},);
      CustomerDataResponse customerDataResponse =
      CustomerDataResponse.fromJson(response.data);
      List<HiveCustomerModel> hiveCustomerModels =
          _getHiveCustomersModels(customerDataResponse);
      await _storeCustomers(hiveCustomerModels);
      await sharedPreferenceDataSource.setBool(spHasCustomerDataSynced, true);
      return hiveCustomerModels;
    } catch (exception) {
      debugPrint('Customers Call: $exception');
    }
    return null;
  }

  HiveCustomerModel _getHiveCustomerModel(Customers customers) {
    return HiveCustomerModel(
      id: customers.id,
      name: customers.name,
      status: customers.status,
      address: customers.address,
      contactNumber: customers.contactNo,
      contactPerson: customers.contactPerson,
      location: customers.location,
      pincode: customers.pinCode
    );
  }

  List<HiveCustomerModel> _getHiveCustomersModels(
      CustomerDataResponse customerDataResponse) {
    List<HiveCustomerModel> hiveCustomerModels = [];
    if (customerDataResponse.customers != null) {
      for (int i = 0; i < customerDataResponse.customers!.length; i++) {
        HiveCustomerModel hiveCustomerModel =
            _getHiveCustomerModel(customerDataResponse.customers![i]);
        hiveCustomerModels.add(hiveCustomerModel);
      }
    }
    return hiveCustomerModels;
  }

  Future<void> _storeCustomers(List<HiveCustomerModel> hiveCustomerModels) async {
    await hiveDataSource.deleteAllCustomers();
    for (int i = 0; i < hiveCustomerModels.length; i++) {
      await hiveDataSource.addCustomer(hiveCustomerModels[i]);
    }
  }
}
