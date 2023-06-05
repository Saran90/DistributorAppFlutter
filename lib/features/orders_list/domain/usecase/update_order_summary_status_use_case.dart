import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_summary_repository.dart';

class UpdateOrderSummaryStatusUseCase
    extends UseCase<void, UpdateOrderSummaryStatusParams> {
  final OrderSummaryRepository orderSummaryRepository;

  UpdateOrderSummaryStatusUseCase({required this.orderSummaryRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderSummaryRepository.updateOrderSummaryStatus(
        params.orderId, params.status);
  }
}

class UpdateOrderSummaryStatusParams extends Equatable {
  final int orderId;
  final int status;

  const UpdateOrderSummaryStatusParams(
      {required this.orderId, required this.status});

  @override
  List<Object> get props => [orderId, status];
}
