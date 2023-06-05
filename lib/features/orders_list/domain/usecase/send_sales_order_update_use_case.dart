import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderUpdateRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/sales_order_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/datasource/models/SendSalesOrderResponse.dart';

class SendSalesOrderUpdateUseCase extends UseCase<SendSalesOrderResponse?, SendSalesOrderUpdateParams> {
  final SalesOrderRepository salesOrderRepository;

  SendSalesOrderUpdateUseCase({required this.salesOrderRepository});

  @override
  Future<Either<Failure, SendSalesOrderResponse?>> call(params) {
    return salesOrderRepository.sendSalesOrderUpdate(params.request);
  }
}

class SendSalesOrderUpdateParams extends Equatable {
  final SendSalesOrderUpdateRequest request;

  const SendSalesOrderUpdateParams({required this.request});

  @override
  List<Object> get props => [request];
}
