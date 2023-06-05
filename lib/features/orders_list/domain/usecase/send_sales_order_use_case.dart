import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderResponse.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/sales_order_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class SendSalesOrderUseCase extends UseCase<SendSalesOrderResponse?, SendSalesOrderParams> {
  final SalesOrderRepository salesOrderRepository;

  SendSalesOrderUseCase({required this.salesOrderRepository});

  @override
  Future<Either<Failure, SendSalesOrderResponse?>> call(params) {
    return salesOrderRepository.sendSalesOrder(params.request);
  }
}

class SendSalesOrderParams extends Equatable {
  final SendSalesOrderRequest request;

  const SendSalesOrderParams({required this.request});

  @override
  List<Object> get props => [request];
}
