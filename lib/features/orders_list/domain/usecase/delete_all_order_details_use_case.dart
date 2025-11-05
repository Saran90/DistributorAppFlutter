import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/order_details_repository.dart';

class DeleteAllOrderDetailsUseCase
    extends UseCase<void, NoParams> {
  final OrderDetailsRepository orderDetailsRepository;

  DeleteAllOrderDetailsUseCase({required this.orderDetailsRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return orderDetailsRepository.deleteAllOrderItems();
  }
}