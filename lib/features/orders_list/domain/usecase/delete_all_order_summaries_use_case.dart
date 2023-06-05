import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class DeleteAllOrderSummariesUseCase extends UseCase<void, NoParams> {
  final OrderSummaryRepository orderSummaryRepository;

  DeleteAllOrderSummariesUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderSummaryRepository.deleteAllOrders();
  }
}
