import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_location_model.dart';

abstract class LocationDataRepository{
  Future<Either<Failure, List<HiveLocationModel>?>> getLocations();
}