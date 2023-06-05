import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_cart_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/update_cart_repository.dart';

class UpdateCartUseCase extends UseCase<void, UpdateCartParams> {
  final UpdateCartRepository updateCartRepository;

  UpdateCartUseCase({required this.updateCartRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return updateCartRepository.updateCart(params.hiveCartModel);
  }
}

class UpdateCartParams extends Equatable {
  final HiveCartModel hiveCartModel;

  const UpdateCartParams({required this.hiveCartModel});

  @override
  List<Object> get props => [hiveCartModel];
}
