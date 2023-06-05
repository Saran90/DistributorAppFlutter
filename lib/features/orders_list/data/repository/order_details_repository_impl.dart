import 'package:dartz/dartz.dart';

import 'package:distributor_app_flutter/core/data/error/failures.dart';

import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';

import '../../domain/repository/order_details_repository.dart';
import '../datasource/order_details_data_source.dart';

class OrderDetailsRepositoryImpl extends OrderDetailsRepository {
  OrderDetailsRepositoryImpl({required this.orderDetailsDataSource});

  final OrderDetailsDataSource orderDetailsDataSource;

  @override
  Future<Either<Failure, int>> addOrderItems(
      List<HiveOrderDetailsModel> models) async {
    try {
      var result = await orderDetailsDataSource.addOrderItems(models);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrderItems(int orderId) async {
    try {
      var result = await orderDetailsDataSource.deleteOrderItems(orderId);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<HiveOrderDetailsModel>?>> getOrderItemsForOrder(
      int orderId) async {
    try {
      var result = await orderDetailsDataSource.getOrderItemsForOrder(orderId);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int?>> deleteAllOrderItems() async {
    try {
      var result = await orderDetailsDataSource.deleteAllOrderItems();
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderDetailStatus(int orderId, int status) async {
    try {
      var result = await orderDetailsDataSource.updateOrderDetailStatus(orderId, status);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure());
    }
  }
}
