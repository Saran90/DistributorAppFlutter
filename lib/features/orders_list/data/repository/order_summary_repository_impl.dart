import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/order_summary_data_source.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';

class OrderSummaryRepositoryImpl extends OrderSummaryRepository {
  OrderSummaryRepositoryImpl({required this.orderSummaryDataSource});

  final OrderSummaryDataSource orderSummaryDataSource;

  @override
  Future<Either<Failure, HiveOrderSummaryModel>> addOrder(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    try {
      var result = await orderSummaryDataSource.addOrder(hiveOrderSummaryModel);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllCustomerOrders(int customerId) async {
    try {
      var result =
          await orderSummaryDataSource.deleteAllCustomerOrders(customerId);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int?>> deleteAllOrders() async {
    try {
      var result = await orderSummaryDataSource.deleteAllOrders();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    try {
      var result =
          await orderSummaryDataSource.deleteOrder(hiveOrderSummaryModel);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<HiveOrderSummaryModel>?>> getAllOrders() async {
    try {
      var result = await orderSummaryDataSource.getAllOrders();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<HiveOrderSummaryModel>?>>
      getAllFailedOrders() async {
    try {
      var result = await orderSummaryDataSource.getAllFailedOrders();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<HiveOrderSummaryModel>?>>
      getAllUnSendOrders() async {
    try {
      var result = await orderSummaryDataSource.getAllUnSendOrders();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, HiveOrderSummaryModel?>> getOrder(int orderId) async {
    try {
      var result = await orderSummaryDataSource.getOrder(orderId);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<HiveOrderSummaryModel>?>> getOrdersByCustomer(
      int customerId) async {
    try {
      var result = await orderSummaryDataSource.getOrdersByCustomer(customerId);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderSummaryStatus(
      int orderId, int status) async {
    try {
      var result = await orderSummaryDataSource.updateOrderSummaryStatus(
          orderId, status);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderSummary(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    try {
      var result = await orderSummaryDataSource
          .updateOrderSummary(hiveOrderSummaryModel);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }
}
