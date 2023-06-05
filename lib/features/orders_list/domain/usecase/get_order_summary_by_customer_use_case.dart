import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class GetOrderSummaryByCustomerIdUseCase extends UseCase<List<HiveOrderSummaryModel>?, GetOrderSummaryByCustomerIdParams> {
  final OrderSummaryRepository orderSummaryRepository;

  GetOrderSummaryByCustomerIdUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, List<HiveOrderSummaryModel>?>> call(params) {
    return orderSummaryRepository.getOrdersByCustomer(params.customerId);
  }
}

class GetOrderSummaryByCustomerIdParams extends Equatable {
  final int customerId;

  const GetOrderSummaryByCustomerIdParams({required this.customerId});

  @override
  List<Object> get props => [customerId];
}
