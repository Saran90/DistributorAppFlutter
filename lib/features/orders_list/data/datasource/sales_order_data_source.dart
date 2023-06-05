import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderResponse.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderUpdateRequest.dart';
import 'package:flutter/foundation.dart';

import '../../../../app_config.dart';
import '../../../../core/data/preference/constants.dart';
import '../../../../utils/endpoints.dart';

abstract class SalesOrderDataSource {
  Future<SendSalesOrderResponse?> sendSalesOrder(SendSalesOrderRequest request);

  Future<SendSalesOrderResponse?> sendSalesOrderUpdate(
      SendSalesOrderUpdateRequest request);
}

class SalesOrderDataSourceImpl extends SalesOrderDataSource {
  SalesOrderDataSourceImpl(
      {required this.dio, required this.sharedPreferenceDataSource});

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  final Dio dio;

  @override
  Future<SendSalesOrderResponse?> sendSalesOrder(
      SendSalesOrderRequest request) async {
    try {
      var response = await dio.post(AppConfig.instance.endPoint!.sendSalesOrder,
          data: request.toJson(),
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferenceDataSource.getString(spAccessToken)}'
          }));
      SendSalesOrderResponse salesOrderResponse =
          SendSalesOrderResponse.fromJson(response.data);
      return salesOrderResponse;
    } catch (exception) {
      debugPrint('Customers Call: $exception');
    }
    return null;
  }

  @override
  Future<SendSalesOrderResponse?> sendSalesOrderUpdate(
      SendSalesOrderUpdateRequest request) async {
    try {
      var response = await dio.post(
          AppConfig.instance.endPoint!.sendSalesOrderUpdate,
          data: request.toJson(),
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferenceDataSource.getString(spAccessToken)}'
          }));
      SendSalesOrderResponse salesOrderResponse =
          SendSalesOrderResponse.fromJson(response.data);
      return salesOrderResponse;
    } catch (exception) {
      debugPrint('Customers Call: $exception');
    }
    return null;
  }
}
