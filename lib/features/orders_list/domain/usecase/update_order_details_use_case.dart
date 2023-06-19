import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_details_repository.dart';

class UpdateOrderDetailsUseCase
    extends UseCase<void, UpdateOrderDetailsParams> {
  final OrderDetailsRepository orderDetailsRepository;

  UpdateOrderDetailsUseCase({required this.orderDetailsRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderDetailsRepository
        .updateOrderDetails(params.hiveOrderDetailsModel);
  }
}

class UpdateOrderDetailsParams extends Equatable {
  final HiveOrderDetailsModel hiveOrderDetailsModel;

  const UpdateOrderDetailsParams({required this.hiveOrderDetailsModel});

  @override
  List<Object> get props => [hiveOrderDetailsModel];
}
