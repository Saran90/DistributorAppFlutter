import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/interceptors/network_checker.dart';

import '../../domain/repository/manufacture_repository.dart';
import '../datasource/manufacture_data_source.dart';
import '../datasource/models/manufacture_list_response.dart';

class ManufactureRepositoryImpl extends ManufactureRepository {
  ManufactureRepositoryImpl({required this.dataSource});

  final ManufactureDataSource dataSource;

  @override
  Future<Either<Failure, List<ManufactureListResponse>?>> getManufactures() async {
    try {
      if (await NetworkChecker.isConnected()) {
        var result = await dataSource.getManufactures();
        return Right(result);
      } else {
        return Left(NetworkFailure());
      }
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
