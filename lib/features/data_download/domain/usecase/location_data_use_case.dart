import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/data_download/domain/repository/location_data_repository.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_location_model.dart';
import '../../../../core/data/usecase/usecase.dart';

class LocationDataUseCase extends UseCase<void, NoParams> {
  final LocationDataRepository locationDataRepository;

  LocationDataUseCase({required this.locationDataRepository});

  @override
  Future<Either<Failure, List<HiveLocationModel>?>> call(params) {
    return locationDataRepository.getLocations();
  }
}