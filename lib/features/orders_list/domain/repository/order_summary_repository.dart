import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../../../core/data/local_storage/models/hive_order_summary_model.dart';

abstract class OrderSummaryRepository{
  Future<Either<Failure,HiveOrderSummaryModel>> addOrder(HiveOrderSummaryModel hiveOrderSummaryModel);
  Future<Either<Failure,void>> deleteOrder(HiveOrderSummaryModel hiveOrderSummaryModel);
  Future<Either<Failure,void>> deleteAllCustomerOrders(int customerId);
  Future<Either<Failure,int?>> deleteAllOrders();
  Future<Either<Failure,List<HiveOrderSummaryModel>?>> getOrdersByCustomer(int customerId);
  Future<Either<Failure,List<HiveOrderSummaryModel>?>> getAllOrders();
  Future<Either<Failure,List<HiveOrderSummaryModel>?>> getAllFailedOrders();
  Future<Either<Failure,List<HiveOrderSummaryModel>?>> getAllUnSendOrders();
  Future<Either<Failure,HiveOrderSummaryModel?>> getOrder(int orderId);
  Future<Either<Failure,void>> updateOrderSummaryStatus(int orderId,int status);
}