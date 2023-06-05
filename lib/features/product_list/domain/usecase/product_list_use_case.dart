import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/local_storage/models/hive_product_model.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/product_list_repository.dart';

class ProductListUseCase extends UseCase<void, ProductListParams> {
  final ProductListRepository productListRepository;

  ProductListUseCase({required this.productListRepository});

  @override
  Future<Either<Failure, List<HiveProductModel>?>> call(params) {
    return productListRepository.getProducts(params.search);
  }
}

class ProductListParams extends Equatable {
  final String search;

  const ProductListParams({required this.search});

  @override
  List<Object> get props => [search];
}
