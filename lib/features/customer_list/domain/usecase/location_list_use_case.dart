import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_location_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/location_list_repository.dart';

class LocationListUseCase extends UseCase<void, NoParams> {
  final LocationListRepository locationListRepository;

  LocationListUseCase({required this.locationListRepository});

  @override
  Future<Either<Failure, List<HiveLocationModel>?>> call(params) {
    return locationListRepository.getLocations();
  }
}
