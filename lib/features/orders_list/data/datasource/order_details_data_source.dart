import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';

abstract class OrderDetailsDataSource {
  Future<void> addOrderItems(List<HiveOrderDetailsModel> models);

  Future<void> deleteOrderItems(int orderId);

  Future<List<HiveOrderDetailsModel>?> getOrderItemsForOrder(int orderId);

  Future<int?> deleteAllOrderItems();

  Future<void> updateOrderDetailStatus(int orderId, int status);

  Future<void> updateOrderDetails(HiveOrderDetailsModel hiveOrderDetailsModel);

  Future<void> deleteOrderDetailsForId(int id);
}

class OrderDetailsDataSourceImpl extends OrderDetailsDataSource {
  OrderDetailsDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<void> addOrderItems(List<HiveOrderDetailsModel> models) {
    return hiveDataSource.addOrderDetails(models);
  }

  @override
  Future<void> deleteOrderItems(int orderId) {
    return hiveDataSource.deleteOrderDetailsForOrder(orderId);
  }

  @override
  Future<List<HiveOrderDetailsModel>?> getOrderItemsForOrder(int orderId) {
    return hiveDataSource.getAllOrderDetailsByOrder(orderId);
  }

  @override
  Future<int?> deleteAllOrderItems() {
    return hiveDataSource.deleteAllOrderDetails();
  }

  @override
  Future<void> updateOrderDetailStatus(int orderId, int status) {
    return hiveDataSource.updateOrderDetailStatus(orderId, status);
  }

  @override
  Future<void> updateOrderDetails(HiveOrderDetailsModel hiveOrderDetailsModel) async {
    return hiveDataSource.updateOrderDetails(hiveOrderDetailsModel);
  }

  @override
  Future<void> deleteOrderDetailsForId(int id) {
    return hiveDataSource.deleteOrderDetailsForId(id);
  }
}
