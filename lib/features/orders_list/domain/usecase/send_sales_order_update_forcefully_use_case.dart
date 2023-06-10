import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderUpdateRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/sales_order_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/datasource/models/SendSalesOrderResponse.dart';

class SendSalesOrderUpdateForcefullyUseCase extends UseCase<SendSalesOrderResponse?, SendSalesOrderUpdateForcefullyParams> {
  final SalesOrderRepository salesOrderRepository;

  SendSalesOrderUpdateForcefullyUseCase({required this.salesOrderRepository});

  @override
  Future<Either<Failure, SendSalesOrderResponse?>> call(params) {
    return salesOrderRepository.sendSalesOrderUpdateForcefully(params.request);
  }
}

class SendSalesOrderUpdateForcefullyParams extends Equatable {
  final SendSalesOrderUpdateRequest request;

  const SendSalesOrderUpdateForcefullyParams({required this.request});

  @override
  List<Object> get props => [request];
}
