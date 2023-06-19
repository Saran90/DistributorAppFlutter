import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_details_repository.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/repository/order_summary_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class DeleteOrderItemByIdUseCase extends UseCase<void, DeleteOrderItemByIdParams> {
  final OrderDetailsRepository orderDetailsRepository;

  DeleteOrderItemByIdUseCase({required this.orderDetailsRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderDetailsRepository.deleteOrderItem(params.id);
  }
}

class DeleteOrderItemByIdParams extends Equatable {
  final int id;

  const DeleteOrderItemByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
