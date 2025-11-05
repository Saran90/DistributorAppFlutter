import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';

abstract class OrderDetailsRepository {
  Future<Either<Failure, void>> addOrderItems(
      List<HiveOrderDetailsModel> models);

  Future<Either<Failure, void>> deleteOrderItems(int orderId);

  Future<Either<Failure, List<HiveOrderDetailsModel>?>> getOrderItemsForOrder(
      int orderId);

  Future<Either<Failure, void>> deleteAllOrderItems();

  Future<Either<Failure,void>> updateOrderDetailStatus(int orderId,int status);

  Future<Either<Failure, void>> updateOrderDetails(
      HiveOrderDetailsModel hiveOrderDetailsModel);

  Future<Either<Failure, void>> deleteOrderItem(int id);
}
