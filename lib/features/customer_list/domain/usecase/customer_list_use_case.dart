import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/customer_list_repository.dart';

class CustomerListUseCase extends UseCase<void, CustomerListParams> {
  final CustomerListRepository customerListRepository;

  CustomerListUseCase({required this.customerListRepository});

  @override
  Future<Either<Failure, List<HiveCustomerModel>?>> call(params) {
    return customerListRepository.getCustomers(params.search, params.location);
  }
}

class CustomerListParams extends Equatable {
  final String search;
  final String location;

  const CustomerListParams({required this.search, required this.location});

  @override
  List<Object> get props => [search, location];
}
