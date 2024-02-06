import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/order_history/data/models/order_history_response.dart';
import 'package:distributor_app_flutter/features/order_history/domain/repository/order_history_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class GetOrderHistoryUseCase extends UseCase<void, GetOrderHistoryParams> {
  final OrderHistoryRepository repository;

  GetOrderHistoryUseCase({required this.repository});

  @override
  Future<Either<Failure, OrderHistoryResponse?>> call(params) {
    return repository.getOrderHistory(params.fromDate, params.tillDate);
  }
}

class GetOrderHistoryParams extends Equatable {
  final String? fromDate;
  final String? tillDate;

  const GetOrderHistoryParams({required this.fromDate, required this.tillDate});

  @override
  List<Object> get props => [fromDate ?? '', tillDate ?? ''];
}
