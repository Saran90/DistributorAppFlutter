import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_summary_repository.dart';

class UpdateOrderSummaryUseCase
    extends UseCase<void, UpdateOrderSummaryParams> {
  final OrderSummaryRepository orderSummaryRepository;

  UpdateOrderSummaryUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderSummaryRepository
        .updateOrderSummary(params.hiveOrderSummaryModel);
  }
}

class UpdateOrderSummaryParams extends Equatable {
  final HiveOrderSummaryModel hiveOrderSummaryModel;

  const UpdateOrderSummaryParams({required this.hiveOrderSummaryModel});

  @override
  List<Object> get props => [hiveOrderSummaryModel];
}
