import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class GetAllUnSendOrderSummariesUseCase extends UseCase<List<HiveOrderSummaryModel>?, NoParams> {
  final OrderSummaryRepository orderSummaryRepository;

  GetAllUnSendOrderSummariesUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, List<HiveOrderSummaryModel>?>> call(params) {
    return orderSummaryRepository.getAllUnSendOrders();
  }
}