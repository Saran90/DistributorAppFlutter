import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class DeleteAllOrderSummaryByCustomerIdUseCase extends UseCase<void, DeleteAllOrderSummaryByCustomerIdParams> {
  final OrderSummaryRepository orderSummaryRepository;

  DeleteAllOrderSummaryByCustomerIdUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderSummaryRepository.deleteAllCustomerOrders(params.customerId);
  }
}

class DeleteAllOrderSummaryByCustomerIdParams extends Equatable {
  final int customerId;

  const DeleteAllOrderSummaryByCustomerIdParams({required this.customerId});

  @override
  List<Object> get props => [customerId];
}
