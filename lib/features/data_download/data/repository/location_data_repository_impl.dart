import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/data_download/data/datasource/location_data_data_source.dart';

import '../../../../core/data/interceptors/network_checker.dart';
import '../../../../core/data/local_storage/models/hive_location_model.dart';
import '../../domain/repository/location_data_repository.dart';

class LocationDataRepositoryImpl extends LocationDataRepository {

  LocationDataRepositoryImpl({required this.locationDataDataSource});

  final LocationDataDataSource locationDataDataSource;

  @override
  Future<Either<Failure, List<HiveLocationModel>?>> getLocations() async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await locationDataDataSource.getLocations();
        if(result!=null) {
          return Right(result);
        }else{
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
