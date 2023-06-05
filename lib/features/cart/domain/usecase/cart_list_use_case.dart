import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_cart_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/cart_list_repository.dart';

class CartListUseCase extends UseCase<void, CartListParams> {
  final CartListRepository cartListRepository;

  CartListUseCase({required this.cartListRepository});

  @override
  Future<Either<Failure, List<HiveCartModel>?>> call(params) {
    return cartListRepository.getCustomerCart(params.customerId);
  }
}

class CartListParams extends Equatable {
  final int customerId;

  const CartListParams({required this.customerId});

  @override
  List<Object> get props => [customerId];
}
