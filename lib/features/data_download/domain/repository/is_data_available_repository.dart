import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';

abstract class IsDataAvailableRepository{
  Future<Either<Failure, bool>> isDataAvailable();
}