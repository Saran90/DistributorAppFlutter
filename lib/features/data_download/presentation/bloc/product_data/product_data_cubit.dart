import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/customer_product_data_use_case.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/product_data_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local_storage/models/hive_product_model.dart';
import '../../../../../utils/strings.dart';

part 'product_data_state.dart';

class ProductDataCubit extends Cubit<ProductDataState> {
  ProductDataCubit(
      {required this.productDataUseCase,
      required this.customerProductDataUseCase})
      : super(ProductDataInitial());

  final ProductDataUseCase productDataUseCase;
  final CustomerProductDataUseCase customerProductDataUseCase;

  Future<void> getProducts(String name) async {
    emit(ProductDataLoading());
    var result = await productDataUseCase.call(ProductDataParams(name: name));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(const ProductDataFetchingFailed(message: serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(const ProductDataFetchingFailed(message: networkFailureMessage));
      } else {
        emit(const ProductDataFetchingFailed(
            message: 'Products fetching failed'));
      }
    }, (r) => emit(ProductDataPopulated(products: r ?? [])));
  }

  Future<void> getCustomerProducts(String name) async {
    emit(ProductDataLoading());
    var result = await customerProductDataUseCase
        .call(CustomerProductDataParams(name: name));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(const ProductDataFetchingFailed(message: serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(const ProductDataFetchingFailed(message: networkFailureMessage));
      } else {
        emit(const ProductDataFetchingFailed(
            message: 'Products fetching failed'));
      }
    }, (r) => emit(ProductDataPopulated(products: r ?? [])));
  }
}
