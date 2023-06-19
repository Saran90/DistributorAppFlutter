import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_order_details_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_details_repository.dart';

class AddOrderDetailsUseCase extends UseCase<void, AddOrderDetailsParams> {
  final OrderDetailsRepository orderDetailsRepository;

  AddOrderDetailsUseCase({required this.orderDetailsRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderDetailsRepository.addOrderItems(params.hiveOrderDetailsModels);
  }
}

class AddOrderDetailsParams extends Equatable {
  final List<HiveOrderDetailsModel> hiveOrderDetailsModels;

  const AddOrderDetailsParams({required this.hiveOrderDetailsModels});

  @override
  List<Object> get props => [hiveOrderDetailsModels];
}
