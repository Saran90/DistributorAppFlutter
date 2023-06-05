import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_order_details_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_details_repository.dart';

class GetOrderDetailsForOrderUseCase extends UseCase<List<HiveOrderDetailsModel>?, GetOrderDetailsForOrderParams> {
  final OrderDetailsRepository orderDetailsRepository;

  GetOrderDetailsForOrderUseCase({required this.orderDetailsRepository});

  @override
  Future<Either<Failure, List<HiveOrderDetailsModel>?>> call(params) {
    return orderDetailsRepository.getOrderItemsForOrder(params.orderId);
  }
}

class GetOrderDetailsForOrderParams extends Equatable {
  final int orderId;

  const GetOrderDetailsForOrderParams({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
