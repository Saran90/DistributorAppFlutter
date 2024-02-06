import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/order_history/data/datasource/order_history_data_source.dart';
import 'package:distributor_app_flutter/features/order_history/domain/repository/order_history_repository.dart';

import '../../../../core/data/interceptors/network_checker.dart';
import '../models/order_history_response.dart';

class OrderHistoryRepositoryImpl extends OrderHistoryRepository {
  final OrderHistoryDataSource dataSource;

  OrderHistoryRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, OrderHistoryResponse?>> getOrderHistory(
      String? fromDate, String? tillDate) async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await dataSource.getOrderHistory(fromDate, tillDate);
        if (result != null) {
          return Right(result);
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
