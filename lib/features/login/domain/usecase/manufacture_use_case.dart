import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/models/manufacture_list_response.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/manufacture_repository.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';

class ManufactureUseCase extends UseCase<List<ManufactureListResponse>?, NoParams> {
  final ManufactureRepository repository;

  ManufactureUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ManufactureListResponse>?>> call(params) {
    return repository.getManufactures();
  }
}