import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class GetOrderSummaryByIdUseCase extends UseCase<HiveOrderSummaryModel?, GetOrderSummaryByIdParams> {
  final OrderSummaryRepository orderSummaryRepository;

  GetOrderSummaryByIdUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, HiveOrderSummaryModel?>> call(params) {
    return orderSummaryRepository.getOrder(params.orderId);
  }
}

class GetOrderSummaryByIdParams extends Equatable {
  final int orderId;

  const GetOrderSummaryByIdParams({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
