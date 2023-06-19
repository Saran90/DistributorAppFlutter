import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';

abstract class OrderSummaryDataSource{
  Future<HiveOrderSummaryModel> addOrder(HiveOrderSummaryModel hiveOrderSummaryModel);
  Future<void> deleteOrder(HiveOrderSummaryModel hiveOrderSummaryModel);
  Future<void> deleteAllCustomerOrders(int customerId);
  Future<int?> deleteAllOrders();
  Future<List<HiveOrderSummaryModel>?> getOrdersByCustomer(int customerId);
  Future<List<HiveOrderSummaryModel>?> getAllOrders();
  Future<List<HiveOrderSummaryModel>?> getAllFailedOrders();
  Future<List<HiveOrderSummaryModel>?> getAllUnSendOrders();
  Future<HiveOrderSummaryModel?> getOrder(int orderId);
  Future<void> updateOrderSummaryStatus(int orderId, int status);
  Future<void> updateOrderSummary(HiveOrderSummaryModel hiveOrderSummaryModel);
}

class OrderSummaryDataSourceImpl extends OrderSummaryDataSource{

  OrderSummaryDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<HiveOrderSummaryModel> addOrder(HiveOrderSummaryModel hiveOrderSummaryModel) async {
    return hiveDataSource.addOrderSummary(hiveOrderSummaryModel);
  }

  @override
  Future<void> deleteOrder(HiveOrderSummaryModel hiveOrderSummaryModel) async {
    return hiveDataSource.deleteOrderSummary(hiveOrderSummaryModel);
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getAllOrders() async {
    return hiveDataSource.getAllOrderSummaries();
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getAllFailedOrders() async {
    return hiveDataSource.getAllFailedOrderSummaries();
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getAllUnSendOrders() async {
    return hiveDataSource.getAllUnSendOrderSummaries();
  }

  @override
  Future<HiveOrderSummaryModel?> getOrder(int orderId) async {
    return hiveDataSource.getOrderSummaryById(orderId);
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getOrdersByCustomer(int customerId) async {
  return hiveDataSource.getOrderSummariesByCustomer(customerId);
  }

  @override
  Future<void> deleteAllCustomerOrders(int customerId) async {
    return hiveDataSource.deleteOrderSummaryByCustomer(customerId);
  }

  @override
  Future<int?> deleteAllOrders() async {
    return hiveDataSource.deleteAllOrderSummaries();
  }

  @override
  Future<void> updateOrderSummaryStatus(int orderId, int status) {
    return hiveDataSource.updateOrderSummaryStatus(orderId, status);
  }

  @override
  Future<void> updateOrderSummary(HiveOrderSummaryModel hiveOrderSummaryModel) {
    return hiveDataSource.updateOrderSummary(hiveOrderSummaryModel);
  }


}