import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class DeleteOrderSummaryUseCase extends UseCase<void, DeleteOrderSummaryParams> {
  final OrderSummaryRepository orderSummaryRepository;

  DeleteOrderSummaryUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderSummaryRepository.deleteOrder(params.hiveOrderSummaryModel);
  }
}

class DeleteOrderSummaryParams extends Equatable {
  final HiveOrderSummaryModel hiveOrderSummaryModel;

  const DeleteOrderSummaryParams({required this.hiveOrderSummaryModel});

  @override
  List<Object> get props => [hiveOrderSummaryModel];
}
