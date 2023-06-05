import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';

import '../../../../core/data/local_storage/models/hive_location_model.dart';
import '../../domain/repository/location_list_repository.dart';
import '../datasource/location_list_data_source.dart';

class LocationListRepositoryImpl extends LocationListRepository {
  LocationListRepositoryImpl({required this.locationListDataSource});

  final LocationListDataSource locationListDataSource;

  @override
  Future<Either<Failure, List<HiveLocationModel>?>> getLocations() async {
    try {
      var result = await locationListDataSource.getLocations();
      if (result != null) {
        return Right(result);
      } else {
        return Left(CacheFailure());
      }
    } catch (exception) {
      return Left(CacheFailure());
    }
  }
}
