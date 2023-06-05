import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/is_data_available_repository.dart';

class IsDataAvailableUseCase extends UseCase<void, NoParams> {
  final IsDataAvailableRepository isDataAvailableRepository;

  IsDataAvailableUseCase({required this.isDataAvailableRepository});

  @override
  Future<Either<Failure, bool>> call(params) {
    return isDataAvailableRepository.isDataAvailable();
  }
}
