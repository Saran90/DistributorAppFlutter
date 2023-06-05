import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class AddOrderSummaryUseCase extends UseCase<HiveOrderSummaryModel, AddOrderSummaryParams> {
  final OrderSummaryRepository orderSummaryRepository;

  AddOrderSummaryUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, HiveOrderSummaryModel>> call(params) {
    return orderSummaryRepository.addOrder(params.hiveOrderSummaryModel);
  }
}

class AddOrderSummaryParams extends Equatable {
  final HiveOrderSummaryModel hiveOrderSummaryModel;

  const AddOrderSummaryParams({required this.hiveOrderSummaryModel});

  @override
  List<Object> get props => [hiveOrderSummaryModel];
}
