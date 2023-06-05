import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_cart_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/delete_cart_repository.dart';

class DeleteCartItemUseCase extends UseCase<void, DeleteCartItemParams> {
  final DeleteCartRepository deleteCartRepository;

  DeleteCartItemUseCase({required this.deleteCartRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return deleteCartRepository.deleteCustomerCartItem(params.hiveCartModel);
  }
}

class DeleteCartItemParams extends Equatable {
  final HiveCartModel hiveCartModel;

  const DeleteCartItemParams({required this.hiveCartModel});

  @override
  List<Object> get props => [hiveCartModel];
}
