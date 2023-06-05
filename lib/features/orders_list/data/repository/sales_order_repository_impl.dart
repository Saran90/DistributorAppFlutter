import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderResponse.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderUpdateRequest.dart';

import '../../../../core/data/interceptors/network_checker.dart';
import '../../domain/repository/sales_order_repository.dart';
import '../datasource/sales_order_data_source.dart';

class SalesOrderRepositoryImpl extends SalesOrderRepository {
  SalesOrderRepositoryImpl({required this.salesOrderDataSource});

  final SalesOrderDataSource salesOrderDataSource;

  @override
  Future<Either<Failure, SendSalesOrderResponse?>> sendSalesOrder(
      SendSalesOrderRequest request) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await salesOrderDataSource.sendSalesOrder(request);
        if (result != null) {
          return Right(result);
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } catch (exception) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SendSalesOrderResponse?>> sendSalesOrderUpdate(
      SendSalesOrderUpdateRequest request) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await salesOrderDataSource.sendSalesOrderUpdate(request);
        if (result != null) {
          return Right(result);
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
