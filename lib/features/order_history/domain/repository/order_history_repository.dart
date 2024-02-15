import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../data/models/order_history_response.dart';

abstract class OrderHistoryRepository{
  Future<Either<Failure,OrderHistoryResponse?>> getOrderHistory(String? fromDate, String? tillDate);
}