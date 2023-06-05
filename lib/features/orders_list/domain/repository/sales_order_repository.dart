import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderResponse.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderUpdateRequest.dart';

import '../../../../core/data/error/failures.dart';

abstract class SalesOrderRepository{
  Future<Either<Failure, SendSalesOrderResponse?>> sendSalesOrder(SendSalesOrderRequest request);
  Future<Either<Failure, SendSalesOrderResponse?>> sendSalesOrderUpdate(SendSalesOrderUpdateRequest request);
}