import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../data/datasource/models/manufacture_list_response.dart';

abstract class ManufactureRepository {
  Future<Either<Failure, List<ManufactureListResponse>?>> getManufactures();
}
