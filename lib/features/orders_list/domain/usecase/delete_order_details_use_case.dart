import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_details_repository.dart';

class DeleteOrderDetailsUseCase
    extends UseCase<void, DeleteOrderDetailsParams> {
  final OrderDetailsRepository orderDetailsRepository;

  DeleteOrderDetailsUseCase({required this.orderDetailsRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderDetailsRepository.deleteOrderItems(params.orderId);
  }
}

class DeleteOrderDetailsParams extends Equatable {
  final int orderId;

  const DeleteOrderDetailsParams({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
