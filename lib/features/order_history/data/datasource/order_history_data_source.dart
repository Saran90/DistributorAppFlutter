import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/features/order_history/data/models/order_history_response.dart';

abstract class OrderHistoryDataSource {
  Future<OrderHistoryResponse?> getOrderHistory(
      String? fromDate, String? tillDate);
}

class OrderHistoryDataSourceImpl extends OrderHistoryDataSource {
  final Dio dio;

  OrderHistoryDataSourceImpl({required this.dio});

  @override
  Future<OrderHistoryResponse?> getOrderHistory(
      String? fromDate, String? tillDate) async {
    var result = await dio.get(AppConfig.instance.endPoint!.orderHistory,
        queryParameters: {'fromdate': fromDate, 'tilldate': tillDate});
    OrderHistoryResponse orderHistory = OrderHistoryResponse.fromJson(result.data);
    return orderHistory;
  }
}
