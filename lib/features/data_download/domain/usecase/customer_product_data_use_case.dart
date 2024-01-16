import 'package:dartz/dartz.dart';
import 'package:distributor_app_flutter/features/data_download/domain/repository/product_data_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_product_model.dart';
import '../../../../core/data/usecase/usecase.dart';

class CustomerProductDataUseCase extends UseCase<void, CustomerProductDataParams> {
  final ProductDataRepository productDataRepository;

  CustomerProductDataUseCase({required this.productDataRepository});

  @override
  Future<Either<Failure, List<HiveProductModel>?>> call(params) {
    return productDataRepository.getCustomerProducts(params.name);
  }
}

class CustomerProductDataParams extends Equatable {
  final String name;

  const CustomerProductDataParams({required this.name});

  @override
  List<Object> get props => [name];
}
