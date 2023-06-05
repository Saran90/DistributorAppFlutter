import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_cart_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/add_cart_repository.dart';

class AddCartUseCase extends UseCase<void, AddCartParams> {
  final AddCartRepository addCartRepository;

  AddCartUseCase({required this.addCartRepository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await addCartRepository.addCart(params.hiveCartModel);
  }
}

class AddCartParams extends Equatable {
  final HiveCartModel hiveCartModel;

  const AddCartParams({required this.hiveCartModel});

  @override
  List<Object> get props => [hiveCartModel];
}
