import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/delete_cart_repository.dart';

class DeleteCartUseCase extends UseCase<void, DeleteCartParams> {
  final DeleteCartRepository deleteCartRepository;

  DeleteCartUseCase({required this.deleteCartRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return deleteCartRepository.deleteCustomerCart(params.customerId);
  }
}

class DeleteCartParams extends Equatable {
  final int customerId;

  const DeleteCartParams({required this.customerId});

  @override
  List<Object> get props => [customerId];
}
