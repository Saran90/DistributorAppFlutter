import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_details_repository.dart';

class UpdateOrderDetailsStatusUseCase
    extends UseCase<void, UpdateOrderDetailsStatusParams> {
  final OrderDetailsRepository orderDetailsRepository;

  UpdateOrderDetailsStatusUseCase({required this.orderDetailsRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderDetailsRepository.updateOrderDetailStatus(
        params.orderId, params.status);
  }
}

class UpdateOrderDetailsStatusParams extends Equatable {
  final int orderId;
  final int status;

  const UpdateOrderDetailsStatusParams(
      {required this.orderId, required this.status});

  @override
  List<Object> get props => [orderId, status];
}
