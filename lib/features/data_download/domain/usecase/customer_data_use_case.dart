import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/data_download/domain/repository/customer_data_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../../../core/data/usecase/usecase.dart';

class CustomerDataUseCase extends UseCase<void, CustomerDataParams> {
  final CustomerDataRepository customerDataRepository;

  CustomerDataUseCase({required this.customerDataRepository});

  @override
  Future<Either<Failure, List<HiveCustomerModel>?>> call(params) {
    return customerDataRepository.getCustomers(params.name);
  }
}

class CustomerDataParams extends Equatable {
  final String name;

  const CustomerDataParams({required this.name});

  @override
  List<Object> get props => [name];
}
