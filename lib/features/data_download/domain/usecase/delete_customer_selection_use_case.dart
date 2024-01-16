import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/data_download/domain/repository/customer_data_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../../../core/data/usecase/usecase.dart';

class DeleteCustomerSelectionUseCase extends UseCase<void, NoParams> {
  final CustomerDataRepository customerDataRepository;

  DeleteCustomerSelectionUseCase({required this.customerDataRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    return customerDataRepository.deleteCustomerSelection();
  }
}